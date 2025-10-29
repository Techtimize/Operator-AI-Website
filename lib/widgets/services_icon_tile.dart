import 'package:flutter/material.dart';

class ServiceInfoTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String smallLabelText;
  final Color smallLabelTextColor;
  final String description;
  final Color titleColor;
  final Color descriptionColor;

  const ServiceInfoTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.smallLabelText,
    required this.smallLabelTextColor,
    required this.description,
    required this.titleColor,
    required this.descriptionColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon container (no background, just icon)
        Icon(
          icon,
          color: iconColor,
          size: 48,
        ),
        const SizedBox(width: 12),
        // Text section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and small label row
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: smallLabelTextColor.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      smallLabelText,
                      style: TextStyle(
                        color: smallLabelTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  color: descriptionColor,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
