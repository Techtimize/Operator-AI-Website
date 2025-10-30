import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class HeyGenService {
  static const String _baseUrl = 'https://api.heygen.com';
  static const String _streamingUrl = 'wss://api.heygen.com/v1/streaming';

  // CORS proxy options - try these in order
  static const List<String> _corsProxies = [
    'https://cors-anywhere.herokuapp.com/',
    'https://api.allorigins.win/raw?url=',
    'https://corsproxy.io/?',
    '', // Direct connection (no proxy)
  ];

  int _currentProxyIndex = 0;

  String? _apiKey;
  WebSocketChannel? _channel;
  StreamController<Map<String, dynamic>>? _messageController;
  StreamController<String>? _videoStreamController;
  StreamController<String>? _audioStreamController;

  bool _isConnected = false;
  String? _sessionId;

  HeyGenService() {
    _messageController = StreamController<Map<String, dynamic>>.broadcast();
    _videoStreamController = StreamController<String>.broadcast();
    _audioStreamController = StreamController<String>.broadcast();
  }

  // Initialize with API key
  void initialize(String apiKey) {
    _apiKey = apiKey;
    _currentProxyIndex = 0; // Reset proxy index
  }

  // Reset proxy index to try all proxies again
  void resetProxyIndex() {
    _currentProxyIndex = 0;
  }

  // Get current proxy being used
  String get currentProxy => _corsProxies[_currentProxyIndex].isEmpty
      ? 'Direct'
      : _corsProxies[_currentProxyIndex];

  // Create a streaming avatar session
  Future<String?> createStreamingSession({
    required String avatarId,
    String? voiceId,
    String? language = 'en',
  }) async {
    if (_apiKey == null) {
      throw Exception('API key not initialized');
    }

    // Try each CORS proxy until one works
    for (int i = _currentProxyIndex; i < _corsProxies.length; i++) {
      try {
        final proxy = _corsProxies[i];
        final url = proxy.isEmpty
            ? '$_baseUrl/v1/streaming.create'
            : '${proxy}${Uri.encodeComponent('$_baseUrl/v1/streaming.create')}';

        // Decode API key if it's base64 encoded
        String decodedApiKey = _apiKey!;
        try {
          final bytes = base64Decode(_apiKey!);
          decodedApiKey = String.fromCharCodes(bytes);
        } catch (e) {
          decodedApiKey = _apiKey!;
        }

        final response = await http.post(
          Uri.parse(url),
          headers: {
            'X-API-KEY': decodedApiKey,
            'Content-Type': 'application/json',
            if (proxy.isNotEmpty) 'Origin': 'http://localhost:58774',
          },
          body: jsonEncode({
            'avatar_id': avatarId,
            'voice_id': voiceId,
            'language': language,
          }),
        );

        // Avoid logging raw response in production

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          _sessionId = data['session_id'];
          _currentProxyIndex = i; // Remember working proxy
          return _sessionId;
        } else {
          continue; // Try next proxy
        }
      } catch (e) {
        continue; // Try next proxy
      }
    }

    // All proxies failed
    throw Exception(
      'All CORS proxy attempts failed. Please check your network connection and try again.',
    );
  }

  // Connect to WebSocket stream
  Future<bool> connectToStream() async {
    if (_sessionId == null) {
      throw Exception('Session not created');
    }

    try {
      final wsUrl = '$_streamingUrl/$_sessionId';

      try {
        _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

        _channel!.stream.listen(
          (data) {
            _handleWebSocketMessage(data);
          },
          onError: (error) {
            _isConnected = false;
          },
          onDone: () {
            _isConnected = false;
          },
        );

        // Wait for connection to be established
        await Future.delayed(const Duration(seconds: 2));
        _isConnected = true;
        return true;
      } catch (e) {
        throw e;
      }
    } catch (e) {
      return false;
    }
  }

  // Handle incoming WebSocket messages
  void _handleWebSocketMessage(dynamic data) {
    try {
      final message = jsonDecode(data);
      final type = message['type'];

      switch (type) {
        case 'video':
          _videoStreamController?.add(message['data']);
          break;
        case 'audio':
          _audioStreamController?.add(message['data']);
          break;
        case 'status':
          _messageController?.add(message);
          break;
        case 'error':
          _messageController?.add(message);
          break;
      }
    } catch (e) {
      // Swallow JSON parse errors in production
    }
  }

  // Send text to avatar for speech
  Future<void> sendTextToAvatar(String text) async {
    if (!_isConnected || _channel == null) {
      throw Exception('Not connected to stream');
    }

    final message = {'type': 'text', 'text': text, 'session_id': _sessionId};

    _channel!.sink.add(jsonEncode(message));
  }

  // Send audio to avatar
  Future<void> sendAudioToAvatar(String audioData) async {
    if (!_isConnected || _channel == null) {
      throw Exception('Not connected to stream');
    }

    final message = {
      'type': 'audio',
      'data': audioData,
      'session_id': _sessionId,
    };

    _channel!.sink.add(jsonEncode(message));
  }

  // Control avatar actions
  Future<void> controlAvatar({
    String? action,
    Map<String, dynamic>? parameters,
  }) async {
    if (!_isConnected || _channel == null) {
      throw Exception('Not connected to stream');
    }

    final message = {
      'type': 'control',
      'action': action,
      'parameters': parameters,
      'session_id': _sessionId,
    };

    _channel!.sink.add(jsonEncode(message));
  }

  // Get video stream
  Stream<String> get videoStream => _videoStreamController!.stream;

  // Get audio stream
  Stream<String> get audioStream => _audioStreamController!.stream;

  // Get message stream
  Stream<Map<String, dynamic>> get messageStream => _messageController!.stream;

  // Check if connected
  bool get isConnected => _isConnected;

  // Get session ID
  String? get sessionId => _sessionId;

  // Disconnect and cleanup
  Future<void> disconnect() async {
    _isConnected = false;
    await _channel?.sink.close(status.goingAway);
    await _messageController?.close();
    await _videoStreamController?.close();
    await _audioStreamController?.close();
    _channel = null;
    _sessionId = null;
  }

  // Dispose resources
  void dispose() {
    disconnect();
  }
}
