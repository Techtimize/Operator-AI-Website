import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final Function(String)? onRouteChanged;

  const Footer({super.key, this.onRouteChanged});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFC), // Light gray background
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 24 : 32,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1232),
          child: isMobile ? _buildMobileFooter() : _buildDesktopFooter(),
        ),
      ),
    );
  }

  Widget _buildDesktopFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildCopyright(),
        const SizedBox(width: 24),
        _buildNavigationLinks(),
      ],
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      children: [
        _buildCopyright(),
        const SizedBox(height: 16),
        _buildNavigationLinks(),
      ],
    );
  }

  Widget _buildCopyright() {
    return const Text(
      '© 2025 Operator AI FZCO. All rights reserved.',
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFF6B7280),
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildNavigationLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLink('Privacy Policy'),
        _buildSeparator(),
        _buildLink('Terms of Service'),
        _buildSeparator(),
        _buildLink('FAQ'),
      ],
    );
  }

  Widget _buildLink(String text) {
    return GestureDetector(
      onTap: () => _handleLinkTap(text),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF2563EB),
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
          decorationColor: Color(0xFF2563EB),
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: 1,
      height: 16,
      color: const Color(0xFFD1D5DB),
    );
  }

  void _handleLinkTap(String linkName) {
    // Handle navigation to different pages
    switch (linkName) {
      case 'Privacy Policy':
        print('Navigate to Privacy Policy');
        // TODO: Implement navigation to privacy policy page
        break;
      case 'Terms of Service':
        print('Navigate to Terms of Service');
        // TODO: Implement navigation to terms of service page
        break;
      case 'FAQ':
        onRouteChanged?.call('/faq');
        break;
    }
  }
}
