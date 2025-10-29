import 'package:flutter/material.dart';
import 'package:new_public_website/library/extensions/context_extensions.dart';
import 'package:new_public_website/widgets/services_icon_tile.dart';
import 'custom_pricing_box.dart';


class ResponsiveServiceRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String smallLabelText;
  final Color smallLabelTextColor;
  final String description;
  final Color titleColor;
  final Color descriptionColor;

  // Pricing box
  final String setupPrice;
  final String setupSubtitle;
  final String subscriptionPrice;
  final String subscriptionSubtitle;
  final String buttonText;
  final String implementationText;
  final Color backgroundColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final VoidCallback onButtonTap;

  const ResponsiveServiceRow({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.smallLabelText,
    required this.smallLabelTextColor,
    required this.description,
    required this.titleColor,
    required this.descriptionColor,
    required this.setupPrice,
    required this.setupSubtitle,
    required this.subscriptionPrice,
    required this.subscriptionSubtitle,
    required this.buttonText,
    required this.implementationText,
    required this.backgroundColor,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
        final bool isMobile = context.isMobile;
    final bool isTablet = context.isTablet; 
  
    final bool useColumn = isMobile || isTablet;

    final Widget infoTile = ServiceInfoTile(
      icon: icon,
      iconColor: iconColor,
      title: title,
      smallLabelText: smallLabelText,
      smallLabelTextColor: smallLabelTextColor,
      description: description,
      titleColor: titleColor,
      descriptionColor: descriptionColor,
    );

    final Widget pricingBox = CustomPricingBox(
      setupPrice: setupPrice,
      setupSubtitle: setupSubtitle,
      subscriptionPrice: subscriptionPrice,
      subscriptionSubtitle: subscriptionSubtitle,
      buttonText: buttonText,
      implementationText: implementationText,
      backgroundColor: backgroundColor,
      buttonColor: buttonColor,
      buttonTextColor: buttonTextColor,
      onButtonTap: onButtonTap,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: useColumn ? 16 : 24,
        horizontal: useColumn ? 12 : 60,
      ),
      child: useColumn
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infoTile,
                const SizedBox(height: 20),
                pricingBox,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: infoTile),
                const SizedBox(width: 40),
                Expanded(flex: 3, child: pricingBox),
              ],
            ),
    );
  }
}
