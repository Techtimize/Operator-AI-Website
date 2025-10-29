import 'package:flutter/material.dart';

class CustomPricingBox extends StatelessWidget {
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

  const CustomPricingBox({
    super.key,
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Setup Price
          Text(
            setupPrice,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            setupSubtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 16),

          // Subscription
          Text(
            subscriptionPrice,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subscriptionSubtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 24),

          // Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              onPressed: onButtonTap,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: buttonTextColor,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Implementation
          Text(
            implementationText,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
