import 'package:flutter/material.dart';
import 'package:new_public_website/utils/app_reponsiveness/app_spaces.dart';

class PricingDetailsCard extends StatelessWidget {
  final String title;
  final String setupPrice;
  final String setupLabel;
  final String subscriptionPrice;
  final String subscriptionLabel;
  final Color backgroundColor;
  final Color titleColor;
  final Color priceColor;
  final Color labelColor;

  final bool isMobile;
  final bool isTablet;

  const PricingDetailsCard({
    super.key,
    required this.title,
    required this.setupPrice,
    required this.setupLabel,
    required this.subscriptionPrice,
    required this.subscriptionLabel,
    this.backgroundColor = const Color(0xFF0D47A1),
    this.titleColor = Colors.white,
    this.priceColor = Colors.white,
    this.labelColor = Colors.white70,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = isMobile ? 16 : (isTablet ? 32 : 48);
    final double verticalPadding = isMobile ? 20 : 32;
    final double titleFontSize = isMobile ? 18 : (isTablet ? 20 : 22);
    final double priceFontSize = isMobile ? 22 : 28;
    final double labelFontSize = isMobile ? 12 : 14;

    return Container(
      width:   double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _priceBlock(
                price: setupPrice,
                label: setupLabel,
                priceColor: priceColor,
                labelColor: labelColor,
                priceFontSize: priceFontSize,
                labelFontSize: labelFontSize,
                isMobile: isMobile,
                   context: context,
              ),
              if (!isMobile) const SizedBox(width: 40),
              _priceBlock(
                context: context,
                price: subscriptionPrice,
                label: subscriptionLabel,
                priceColor: priceColor,
                labelColor: labelColor,
                priceFontSize: priceFontSize,
                labelFontSize: labelFontSize,
                isMobile: isMobile,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priceBlock({
    required String price,
    required String label,
    required Color priceColor,
    required Color labelColor,
    required double priceFontSize,
    required double labelFontSize,
    required bool isMobile,
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 12 : 0),
      child: Column(
        children: [
          Text(
            price,
            style: TextStyle(
              color: priceColor,
              fontSize: priceFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpaces.verticalBox(context,10),
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: labelFontSize,
            ),
          ),
          AppSpaces.verticalBox(context,10),
        ],
      ),
    );
  }
}
