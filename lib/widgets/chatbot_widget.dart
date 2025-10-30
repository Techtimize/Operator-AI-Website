import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../models/chatbot_response.dart';
import 'chatbot_network.dart';
import 'chat_media_card.dart';
import '../models/chatbot_button_data.dart';
import 'package:uuid/uuid.dart';

class ChatbotWidget extends StatefulWidget {
  final double panelRightOffset;
  final double panelBottomOffset;

  const ChatbotWidget({
    super.key,
    this.panelRightOffset = 24,
    this.panelBottomOffset = 96,
  });

  @override
  State<ChatbotWidget> createState() => ChatbotWidgetState();
}

class ChatMessage {
  final bool isUser;
  final String text;
  final List<Widget> attachments;
  ChatMessage({
    required this.isUser,
    required this.text,
    this.attachments = const [],
  });
}

class ChatbotWidgetState extends State<ChatbotWidget> {
  final String _userId = Uuid().v4();
  bool _isOpen = false;
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSending = false;
  bool _initializedWelcome = false;
  final ValueNotifier<bool> _isOpenNotifier = ValueNotifier<bool>(false);
  List<ChatbotButtonData> _initialButtons = const [];

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Expose open state to parent layout
  bool get isOpen => _isOpen;
  ValueListenable<bool> get isOpenListenable => _isOpenNotifier;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_isOpen)
          ModalBarrier(
            color: Colors.black.withOpacity(0.5),
            dismissible: true,
            onDismiss: () {
              setState(() => _isOpen = false);
              _isOpenNotifier.value = false;
            },
          ),

        if (_isOpen)
          Positioned(top: 70, left: 0, right: 0, child: _buildChatPanel()),
      ],
    );
  }

  // Public method to open chatbot programmatically
  void openChatbot() {
    if (!_isOpen) {
      setState(() {
        _isOpen = true;
        _ensureWelcomeMessage();
      });
      _isOpenNotifier.value = true;
    }
  }

  void _ensureWelcomeMessage() {
    if (_initializedWelcome) return;
    _initializedWelcome = true;
    setState(() {
      _messages.add(
        ChatMessage(
          isUser: false,
          text:
              "Hello! I'm PAPS, the AI from Opperator A.I. What is your name?",
        ),
      );
    });
  }

  Widget _buildChatPanel() {
    final Size screen = MediaQuery.of(context).size;

    final bool isMobile = screen.width < 600;
    final bool isTablet = screen.width >= 600 && screen.width < 900;
    final bool isLaptop = screen.width >= 900 && screen.width < 1200;
    final bool isDesktop = screen.width >= 1200 && screen.width < 1600;

    double widthReduction;
    double heightReduction;
    if (isMobile) {
      widthReduction = 40;
      heightReduction = 150;
    } else if (isTablet) {
      widthReduction = 80;
      heightReduction = 130;
    } else if (isLaptop) {
      widthReduction = 280;
      heightReduction = 80;
    } else if (isDesktop) {
      widthReduction = 300;
      heightReduction = 90;
    } else {
      widthReduction = 320;
      heightReduction = 100;
    }

    final double safeWidth = screen.width - widthReduction;
    final double safeHeight = screen.height - heightReduction;
    final double maxChatbotWidth = screen.width >= 1600 ? 1800 : 1400;
    final double maxChatbotHeight = screen.width >= 1600 ? 1100 : 950;

    final BoxConstraints constraints = BoxConstraints(
      maxWidth: safeWidth < maxChatbotWidth ? safeWidth : maxChatbotWidth,
      maxHeight: safeHeight < maxChatbotHeight ? safeHeight : maxChatbotHeight,
    );

    return Center(
      child: ConstrainedBox(
        constraints: constraints,
        child: Material(
          color: Colors.transparent,
          elevation: 8,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 240, 230, 1),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Artificial Intelligence',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() => _isOpen = false);
                          _isOpenNotifier.value = false;
                        },
                        icon: const Icon(Icons.close),
                        tooltip: 'Close chat',
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(15),
                    itemCount: _messages.length,
                    itemBuilder: (_, idx) => _buildMessage(_messages[idx]),
                  ),
                ),

                if (_initialButtons.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: _buildButtonsGrid(context, _initialButtons),
                  ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          onSubmitted: (_) => _send(),
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white70,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                          ),
                          minLines: 1,
                          maxLines: 1,
                          textInputAction: TextInputAction.send,
                          keyboardType: TextInputType.text,
                          enabled: !_isSending,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: _isSending
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.send),
                        onPressed: _isSending ? null : () => _send(),
                        color: Colors.blue,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    final bubbleColor = message.isUser
        ? const Color(0xFFEEF2FF)
        : const Color(0xFFF3F4F6);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Align(
        alignment: message.isUser
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.text.isNotEmpty) Text(message.text),
                  if (message.attachments.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    ...message.attachments,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonsGrid(
    BuildContext context,
    List<ChatbotButtonData> buttons,
  ) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final bool oneColumn = maxWidth < 600;
    final int columns = oneColumn ? 1 : 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double buttonWidth =
            constraints.maxWidth / columns - (columns > 1 ? 6 : 0);
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: buttons.map((b) {
            return SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () => _handleButtonClick(b),
                child: Text(b.text),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _handleButtonClick(ChatbotButtonData button) {
    // Simulate sending the button text as user message
    setState(() {
      _messages.add(ChatMessage(isUser: true, text: button.text));
    });

    // If a media file is provided, show it as bot attachment
    if (button.mediaFilename.isNotEmpty) {
      final type = getMediaTypeFromFilename(button.mediaFilename);
      final fullAssetPath = 'assets/${button.mediaFilename}';
      setState(() {
        _messages.add(
          ChatMessage(
            isUser: false,
            text: '',
            attachments: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ChatMediaCard(type: type, mediaUrl: fullAssetPath),
              ),
            ],
          ),
        );
      });
    }

    // Optionally call backend with the intent
    _sendFromButton(button.text);
  }

  Future<void> _sendFromButton(String text) async {
    final response = await ChatbotNetworkService.sendMessage(
      userId: _userId,
      message: text,
    );
    if (!mounted) return;
    if (response != null) {
      _handleBotResponse(response);
    } else {
      setState(() {
        _messages.add(
          ChatMessage(
            isUser: false,
            text: 'Sorry, I encountered an error. Please try again later.',
          ),
        );
      });
    }
  }

  Future<void> _send() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(isUser: true, text: text));
      _isSending = true;
      _textController.clear();
    });
    await Future.delayed(const Duration(milliseconds: 50));
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);

    final response = await ChatbotNetworkService.sendMessage(
      userId: _userId,
      message: text,
    );
    if (!mounted) return;
    if (response != null) {
      _handleBotResponse(response);
    } else {
      setState(() {
        _messages.add(
          ChatMessage(
            isUser: false,
            text: 'Sorry, I encountered an error. Please try again later.',
          ),
        );
      });
    }
    setState(() => _isSending = false);
    await Future.delayed(const Duration(milliseconds: 50));
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void _handleBotResponse(ChatbotResponse response) {
    if (response.text.isNotEmpty) {
      _messages.add(ChatMessage(isUser: false, text: response.text));
    }

    // Add any extra text bubbles sent by the backend
    if (response.additionalMessages != null &&
        response.additionalMessages!.isNotEmpty) {
      for (final extra in response.additionalMessages!) {
        final trimmed = extra.trim();
        if (trimmed.isEmpty) continue;
        _messages.add(ChatMessage(isUser: false, text: trimmed));
      }
    }

    if (response.media != null && response.media!.isNotEmpty) {
      final attachments = <Widget>[];
      for (final mediaPath in response.media!) {
        final t = getMediaTypeFromFilename(mediaPath);
        final fullAssetPath = 'assets/$mediaPath';
        attachments.add(
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ChatMediaCard(type: t, mediaUrl: fullAssetPath),
          ),
        );
      }
      _messages.add(
        ChatMessage(isUser: false, text: '', attachments: attachments),
      );
    }
    setState(() {});
  }
}
