import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          child: isMobile
              ? _buildMobileFooter(context)
              : _buildDesktopFooter(context),
        ),
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildCopyright(),
        const SizedBox(width: 24),
        _buildNavigationLinks(context),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      children: [
        _buildCopyright(),
        const SizedBox(height: 16),
        _buildNavigationLinks(context),
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

  Widget _buildNavigationLinks(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLink('Blog', context),
        _buildSeparator(),
        _buildLink('News', context),
        _buildSeparator(),
        _buildLink('Resources', context),
        _buildSeparator(),
        _buildLink('Privacy Policy', context),
        _buildSeparator(),
        _buildLink('Terms of Service', context),
      ],
    );
  }

  Widget _buildLink(String text, BuildContext context) {
    return GestureDetector(
      onTap: () => _handleLinkTap(text, context),
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

  void _handleLinkTap(String linkName, BuildContext context) {
    // Handle navigation to different pages using GoRouter for proper URL updates
    switch (linkName) {
      case 'Privacy Policy':
        context.go('/privacy-policy');
        onRouteChanged?.call('/privacy-policy');
        break;
      case 'Terms of Service':
        context.go('/terms-of-service');
        onRouteChanged?.call('/terms-of-service');
        break;
      case 'FAQ':
        context.go('/faq');
        onRouteChanged?.call('/faq');
        break;
    }
  }
}
