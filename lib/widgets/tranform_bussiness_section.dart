import 'package:flutter/material.dart';
import 'package:new_public_website/library/extensions/context_extensions.dart';
// assuming context.isMobile/isTablet come from here

class TransformBusinessSection extends StatelessWidget {
  const TransformBusinessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;
    final bool isTablet = context.isTablet;
    final bool useColumn = isMobile || isTablet;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: useColumn ? 40 : 60,
        horizontal: useColumn ? 24 : 80,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        gradient: LinearGradient(
          colors: [
            Color(0xFF2563EB), // blue-600
            Color(0xFF9333EA), // purple-600
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            useColumn ? CrossAxisAlignment.center : CrossAxisAlignment.center,
        children: [
          Text(
            "Ready to Transform Your Business?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: useColumn ? 20 : 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Contact our AI specialists to discuss your specific needs and get a customized implementation plan.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: useColumn ? 14 : 16,
              color: Colors.white.withOpacity(0.9),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
          useColumn
              ? Column(
                  children: [
                    _buildPrimaryButton(context),
                    const SizedBox(height: 16),
                    _buildSecondaryButton(context),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPrimaryButton(context),
                    const SizedBox(width: 16),
                    _buildSecondaryButton(context),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // handle Schedule Consultation tap
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2563EB),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        "Schedule Consultation",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // handle secondary action
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        side: const BorderSide(color: Colors.white, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        "",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
