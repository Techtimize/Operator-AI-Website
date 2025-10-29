import 'package:flutter/material.dart';
import 'home_feature_card.dart';

class HomeFeaturesSection extends StatelessWidget {
  final List<HomeFeatureCard> cards;

  const HomeFeaturesSection({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Center(
        child: Column(
          children: cards.asMap().entries.map((entry) {
            final index = entry.key;
            final card = entry.value;
            return Column(
              children: [if (index > 0) const SizedBox(height: 24), card],
            );
          }).toList(),
        ),
      ),
    );
  }
}
