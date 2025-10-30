import 'package:flutter/material.dart';

class CtaCard extends StatelessWidget {
  final String title;
  final String description;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final Color? primaryButtonColor;
  final Color? secondaryButtonColor;
  final Color? primaryButtonTextColor;
  final Color? secondaryButtonTextColor;

  const CtaCard({
    super.key,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.primaryButtonColor,
    this.secondaryButtonColor,
    this.primaryButtonTextColor,
    this.secondaryButtonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      constraints: BoxConstraints(
        maxWidth: isMobile ? screenWidth - 32 : 672,
        minHeight: isMobile ? 280 : 220,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 24 : 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitle(isMobile),
            SizedBox(height: isMobile ? 16 : 12),
            _buildDescription(isMobile),
            SizedBox(height: isMobile ? 32 : 24),
            _buildButtons(isMobile, isTablet),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(bool isMobile) {
    return Text(
      title,
      style: TextStyle(
        fontSize: isMobile ? 20 : 24,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1F2937),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription(bool isMobile) {
    return Text(
      description,
      style: TextStyle(
        fontSize: isMobile ? 14 : 16,
        color: const Color(0xFF6B7280),
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildButtons(bool isMobile, bool isTablet) {
    if (isMobile) {
      // Stack buttons vertically on mobile
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPrimaryButton(isMobile),
          const SizedBox(height: 12),
          _buildSecondaryButton(isMobile),
        ],
      );
    } else {
      // Keep buttons horizontal on tablet and desktop
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPrimaryButton(isMobile),
          const SizedBox(width: 16),
          _buildSecondaryButton(isMobile),
        ],
      );
    }
  }

  Widget _buildPrimaryButton(bool isMobile) {
    return SizedBox(
      width: isMobile ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPrimaryPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryButtonColor ?? const Color(0xFF2563EB),
          foregroundColor: primaryButtonTextColor ?? Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 32 : 24,
            vertical: isMobile ? 16 : 12,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(
          primaryButtonText,
          style: TextStyle(
            fontSize: isMobile ? 16 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(bool isMobile) {
    return SizedBox(
      width: isMobile ? double.infinity : null,
      child: OutlinedButton(
        onPressed: onSecondaryPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: secondaryButtonTextColor ?? const Color(0xFF2563EB),
          side: BorderSide(
            color: secondaryButtonColor ?? const Color(0xFF2563EB),
            width: 1,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 32 : 24,
            vertical: isMobile ? 16 : 12,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          secondaryButtonText,
          style: TextStyle(
            fontSize: isMobile ? 16 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
