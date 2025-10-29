import 'package:flutter/material.dart';
import 'interactive_avatar_widget.dart';
import '../constants/heygen_config.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight:
            MediaQuery.of(context).size.height - 60, // Account for navbar
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF87CEEB), // Light sky blue
            Color(0xFF4169E1), // Royal blue
          ],
        ),
      ),
      child: Stack(
        children: [
          // Subtle background pattern
          _buildBackgroundPattern(),

          // Main content with proper padding
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buildInteractiveAvatar()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundPattern() {
    return Positioned.fill(child: CustomPaint(painter: DotsPatternPainter()));
  }

  Widget _buildInteractiveAvatar() {
    return InteractiveAvatarWidget(
      avatarId: HeyGenConfig.avatarId,
      voiceId: HeyGenConfig.voiceId,
      language: HeyGenConfig.defaultLanguage,
      apiKey: HeyGenConfig.apiKey,
      onChatNowPressed: () {
        // Handle chat now button press
        _handleChatNowPressed();
      },
      onLanguageChanged: (language) {
        // Handle language change
        _handleLanguageChange(language);
      },
    );
  }

  void _handleChatNowPressed() {
    // Navigate to chat page or show chat interface
    // You can implement this based on your app's navigation structure
    print('Chat now pressed - implement navigation to chat');
  }

  void _handleLanguageChange(String language) {
    // Handle language change
    print('Language changed to: $language');
  }
}

// Custom painter for background dots pattern
class DotsPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    const double dotSize = 3;
    const double spacing = 40;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
