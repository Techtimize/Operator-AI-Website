import 'package:flutter/material.dart';

class ContactSupportCard extends StatefulWidget {
  const ContactSupportCard({super.key});

  @override
  State<ContactSupportCard> createState() => _ContactSupportCardState();
}

class _ContactSupportCardState extends State<ContactSupportCard> {
  bool _isButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 768, minHeight: 250),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Still Have Questions?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Our team is here to help! Reach out to us and we\'ll get back to you within 24 hours.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _buildContactButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactButton() {
    return Center(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isButtonHovered = true),
        onExit: (_) => setState(() => _isButtonHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform: _isButtonHovered
              ? (Matrix4.identity()..scale(1.1))
              : Matrix4.identity(),
          child: ElevatedButton(
            onPressed: () {
              // TODO: Implement contact support functionality
              print('Contact Support Team clicked');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: const Color(0xFF2563EB).withValues(alpha: 0.3),
            ),
            child: const Text(
              'Contact Support Team',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
