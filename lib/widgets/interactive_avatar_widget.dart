import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../services/heygen_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../constants/heygen_config.dart';
import 'heygen_embed.dart' as heygen_embed;

class InteractiveAvatarWidget extends StatefulWidget {
  final String avatarId;
  final String? voiceId;
  final String language;
  final String apiKey;
  final VoidCallback? onChatNowPressed;
  final Function(String)? onLanguageChanged;

  const InteractiveAvatarWidget({
    super.key,
    required this.avatarId,
    this.voiceId,
    this.language = 'en',
    required this.apiKey,
    this.onChatNowPressed,
    this.onLanguageChanged,
  });

  @override
  State<InteractiveAvatarWidget> createState() =>
      _InteractiveAvatarWidgetState();
}

class _InteractiveAvatarWidgetState extends State<InteractiveAvatarWidget> {
  late HeyGenService _heyGenService;
  VideoPlayerController? _videoController;

  bool _isConnecting = false;
  bool _isConnected = false;
  bool _isSpeaking = false;
  bool _isListening = false;
  String _connectionStatus = 'Disconnected';
  String _currentLanguage = 'en';

  // Video frame handling
  ui.Image? _currentVideoFrame;
  bool _hasVideoFrame = false;
  Timer? _videoFrameTimer;
  Timer? _connectionTimeoutTimer;

  StreamSubscription<Map<String, dynamic>>? _messageSubscription;
  StreamSubscription<String>? _videoSubscription;
  StreamSubscription<String>? _audioSubscription;

  @override
  void initState() {
    super.initState();
    _currentLanguage = widget.language;
    _heyGenService = HeyGenService();
    _heyGenService.initialize(widget.apiKey);
    _setupStreamListeners();
    _initializeAvatar();
  }

  void _setupStreamListeners() {
    _messageSubscription = _heyGenService.messageStream.listen((message) {
      _handleMessage(message);
    });

    _videoSubscription = _heyGenService.videoStream.listen((videoData) {
      _handleVideoData(videoData);
    });

    _audioSubscription = _heyGenService.audioStream.listen((audioData) {
      _handleAudioData(audioData);
    });
  }

  void _handleMessage(Map<String, dynamic> message) {
    setState(() {
      switch (message['type']) {
        case 'status':
          _connectionStatus = message['status'] ?? 'Unknown';
          _isConnected = message['status'] == 'connected';
          break;
        case 'speaking_started':
          _isSpeaking = true;
          break;
        case 'speaking_ended':
          _isSpeaking = false;
          break;
        case 'listening_started':
          _isListening = true;
          break;
        case 'listening_ended':
          _isListening = false;
          break;
        case 'error':
          _connectionStatus = 'Error: ${message['message']}';
          _isConnected = false;
          break;
      }
    });
  }

  void _handleVideoData(String videoData) {
    // Handle base64 video data from HeyGen
    try {
      final bytes = base64Decode(videoData);

      // Convert bytes to Uint8List
      final uint8List = Uint8List.fromList(bytes);

      // Decode the image
      _decodeImageFromBytes(uint8List);

      if (mounted) {
        setState(() {
          _connectionStatus = 'Video streaming';
          _hasVideoFrame = true;
        });
      }
    } catch (e) {}
  }

  Future<void> _decodeImageFromBytes(Uint8List bytes) async {
    try {
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();

      if (mounted) {
        setState(() {
          _currentVideoFrame = frame.image;
        });
      }
    } catch (e) {}
  }

  void _handleAudioData(String audioData) {
    // Handle base64 audio data from HeyGen
    try {
      // TODO: Implement audio playback
      // For now, we'll just acknowledge receipt
      if (mounted) {
        setState(() {
          _connectionStatus = 'Audio streaming';
        });
      }

      // In a real implementation, you would:
      // 1. Convert base64 to audio bytes
      // 2. Use audio player to play the audio
      // 3. Handle audio playback state
    } catch (e) {}
  }

  Future<void> _initializeAvatar() async {
    setState(() {
      _isConnecting = true;
      _connectionStatus = 'Connecting...';
    });

    _startConnectionTimeout();

    try {
      // Initialize avatar session

      // Create streaming session
      final sessionId = await _heyGenService.createStreamingSession(
        avatarId: widget.avatarId,
        voiceId: widget.voiceId,
        language: _currentLanguage,
      );

      if (sessionId != null) {
        // Connect to WebSocket stream
        final connected = await _heyGenService.connectToStream();

        setState(() {
          _isConnecting = false;
          _isConnected = connected;
          _connectionStatus = connected ? 'Connected' : 'Connection failed';
        });
        _clearConnectionTimeout();
      } else {
        // Session creation failed
        setState(() {
          _isConnecting = false;
          _connectionStatus = 'Failed to create session';
        });
        _clearConnectionTimeout();
      }
    } catch (e) {
      setState(() {
        _isConnecting = false;
        if (e.toString().contains('CORS') ||
            e.toString().contains('Failed to fetch')) {
          _connectionStatus =
              'CORS Error: Try refreshing or check browser settings';
        } else {
          _connectionStatus = 'Error: $e';
        }
      });
      _clearConnectionTimeout();
    }
  }

  Future<void> _retryWithDifferentProxy() async {
    // Retry with next available proxy
    _heyGenService.resetProxyIndex();
    await _initializeAvatar();
  }

  void _startConnectionTimeout() {
    _clearConnectionTimeout();
    _connectionTimeoutTimer = Timer(HeyGenConfig.connectionTimeout, () {
      if (!mounted) return;
      if (_isConnected) return;
      setState(() {
        _isConnecting = false;
        _connectionStatus = 'Connection timeout. Showing fallback.';
      });
    });
  }

  void _clearConnectionTimeout() {
    _connectionTimeoutTimer?.cancel();
    _connectionTimeoutTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine available space from the parent (hero section)
        final fallbackSize = MediaQuery.of(context).size;
        final maxWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : fallbackSize.width;
        final maxHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : fallbackSize.height;

        // Target a tall avatar that fits inside the hero section
        // Prefer height: ~80% of parent, keep 16:9 aspect ratio
        const aspectRatio = 16 / 9;
        final minHeight = math.min(500.0, maxHeight);
        double avatarHeight = (maxHeight * 0.80).clamp(minHeight, maxHeight);
        final minWidth = math.min(500.0, maxWidth);
        double avatarWidth = (avatarHeight * aspectRatio).clamp(
          minWidth,
          maxWidth,
        );

        // If width overflows, fit width and adjust height to maintain aspect
        if (avatarWidth > maxWidth) {
          avatarWidth = maxWidth;
          final minH = math.min(400.0, maxHeight);
          avatarHeight = (avatarWidth / aspectRatio).clamp(minH, maxHeight);
        }

        // Cap the avatar window width and center it in the hero section
        const double maxAvatarWindowWidth = 1232.0;
        avatarWidth = math.min(avatarWidth, maxAvatarWindowWidth);

        return Center(
          child: Container(
            width: avatarWidth,
            height: avatarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF2D2D2D), width: 8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  // Avatar video area
                  _buildAvatarVideoArea(),

                  // Connection status indicator (hide on web fallback)
                  if (!kIsWeb || _isConnected)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: _buildConnectionStatus(),
                    ),

                  // Speaking indicator
                  if (_isSpeaking) _buildSpeakingIndicator(),

                  // Listening indicator
                  if (_isListening) _buildListeningIndicator(),

                  // Bottom controls - only show when connected
                  if (_isConnected)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: _buildVideoControls(),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatarVideoArea() {
    if (_isConnecting) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8B5CF6)),
                  strokeWidth: 3,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Connecting to AI Avatar...',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF1976D2),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please wait while we establish the connection',
                style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
              ),
            ],
          ),
        ),
      );
    }

    if (!_isConnected) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
          ),
        ),
        child: Stack(
          children: [
            if (kIsWeb)
              // Web fallback: show only the iframe to avoid overlay clutter
              Positioned.fill(
                child: heygen_embed.buildHeygenEmbed(
                  HeyGenConfig.fallbackEmbedUrl,
                ),
              )
            else ...[
              // Centered offline content (non-web only)
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.smart_toy_outlined,
                            size: 60,
                            color: Color(0xFF6C757D),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Avatar Offline',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Color(0xFF495057),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _connectionStatus,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6C757D),
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Bottom-centered button with max width (non-web only)
              Positioned(
                left: 24,
                right: 24,
                bottom: 24,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: ElevatedButton(
                      onPressed: _isConnecting
                          ? null
                          : _retryWithDifferentProxy,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 3,
                      ),
                      child: _isConnecting
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text('Connecting...'),
                              ],
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.refresh, size: 20),
                                SizedBox(width: 8),
                                Text('Try Different Proxy'),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    }

    // Connected state - show avatar video
    if (_hasVideoFrame && _currentVideoFrame != null) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomPaint(
          painter: VideoFramePainter(_currentVideoFrame!),
          size: Size.infinite,
        ),
      );
    }

    // Connected state but no video frame yet
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF87CEEB), Color(0xFF4169E1)],
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.smart_toy, size: 80, color: Colors.white),
            SizedBox(height: 16),
            Text(
              'AI Avatar Active',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Waiting for video stream...',
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionStatus() {
    Color statusColor;
    switch (_connectionStatus) {
      case 'Connected':
        statusColor = const Color(0xFF00FF00);
        break;
      case 'Connecting...':
        statusColor = const Color(0xFFFFA500);
        break;
      default:
        statusColor = const Color(0xFFFF0000);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            _connectionStatus.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeakingIndicator() {
    return Positioned(
      top: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF8B5CF6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.mic, color: Colors.white, size: 16),
            SizedBox(width: 4),
            Text(
              'SPEAKING',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListeningIndicator() {
    return Positioned(
      top: 60,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF10B981),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hearing, color: Colors.white, size: 16),
            SizedBox(width: 4),
            Text(
              'LISTENING',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoControls() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final content = Center(child: _buildChatPill());

        return Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: content,
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatPill() {
    return GestureDetector(
      onTap: widget.onChatNowPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF8B5CF6),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Text(
          'Chat now',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    _videoSubscription?.cancel();
    _audioSubscription?.cancel();
    _videoController?.dispose();
    _videoFrameTimer?.cancel();
    _connectionTimeoutTimer?.cancel();
    _currentVideoFrame?.dispose();
    _heyGenService.dispose();
    super.dispose();
  }
}

// Custom painter for rendering video frames
class VideoFramePainter extends CustomPainter {
  final ui.Image videoFrame;

  VideoFramePainter(this.videoFrame);

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the aspect ratio and positioning
    final imageAspectRatio = videoFrame.width / videoFrame.height;
    final containerAspectRatio = size.width / size.height;

    Rect destRect;
    if (imageAspectRatio > containerAspectRatio) {
      // Image is wider than container
      final scaledHeight = size.width / imageAspectRatio;
      final offsetY = (size.height - scaledHeight) / 2;
      destRect = Rect.fromLTWH(0, offsetY, size.width, scaledHeight);
    } else {
      // Image is taller than container
      final scaledWidth = size.height * imageAspectRatio;
      final offsetX = (size.width - scaledWidth) / 2;
      destRect = Rect.fromLTWH(offsetX, 0, scaledWidth, size.height);
    }

    // Draw the video frame
    canvas.drawImageRect(
      videoFrame,
      Rect.fromLTWH(
        0,
        0,
        videoFrame.width.toDouble(),
        videoFrame.height.toDouble(),
      ),
      destRect,
      Paint()..filterQuality = FilterQuality.high,
    );
  }

  @override
  bool shouldRepaint(VideoFramePainter oldDelegate) {
    return oldDelegate.videoFrame != videoFrame;
  }
}
