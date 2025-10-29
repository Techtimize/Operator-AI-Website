import 'package:flutter/material.dart';
import 'feature_card.dart';

class FeatureCardsSection extends StatelessWidget {
  const FeatureCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    final features = [
      {
        'icon': Icons.chat_bubble_outline,
        'title': 'AI Conversations',
        'description':
            'Natural language conversations with AI-powered responses',
      },
      {
        'icon': Icons.analytics_outlined,
        'title': 'Smart Analytics',
        'description': 'Get insights with real-time analytics and reporting',
      },
      {
        'icon': Icons.security,
        'title': 'Secure Platform',
        'description': 'Enterprise-grade security and data protection',
      },
      {
        'icon': Icons.integration_instructions,
        'title': 'Easy Integration',
        'description': 'Seamlessly integrate with your existing workflows',
      },
      {
        'icon': Icons.support_agent,
        'title': '24/7 Support',
        'description': 'Round-the-clock customer support and assistance',
      },
      {
        'icon': Icons.auto_fix_high,
        'title': 'Auto Optimization',
        'description': 'Automatic performance optimization and improvements',
      },
    ];

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Container(
      width: double.infinity,
      color: const Color(0xFFF9FAFB),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 48 : 80,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              Text(
                'Our Features',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E3A8A),
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Text(
                'Comprehensive AI solutions designed for your business needs',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  color: const Color(0xFF6B7280),
                ),
              ),
              SizedBox(height: isMobile ? 32 : 48),
              _buildFeaturesGrid(features, crossAxisCount),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesGrid(
    List<Map<String, dynamic>> features,
    int crossAxisCount,
  ) {
    // For mobile (1 column), return a simple column with full-width cards
    if (crossAxisCount == 1) {
      return Column(
        children: features.asMap().entries.map((entry) {
          final index = entry.key;
          final feature = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FeatureCard(
                icon: feature['icon'] as IconData,
                title: feature['title'] as String,
                description: feature['description'] as String,
              ),
              if (index < features.length - 1) const SizedBox(height: 16),
            ],
          );
        }).toList(),
      );
    }

    // For tablet and desktop, create rows with equal-width cards
    final List<Widget> rows = [];
    for (int i = 0; i < features.length; i += crossAxisCount) {
      final List<Widget> rowCards = [];
      for (int j = 0; j < crossAxisCount && (i + j) < features.length; j++) {
        if (j > 0) {
          rowCards.add(const SizedBox(width: 16));
        }
        final feature = features[i + j];
        rowCards.add(
          Expanded(
            child: FeatureCard(
              icon: feature['icon'] as IconData,
              title: feature['title'] as String,
              description: feature['description'] as String,
            ),
          ),
        );
      }
      if (i > 0) {
        rows.add(const SizedBox(height: 16));
      }
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rowCards,
          ),
        ),
      );
    }

    return Column(children: rows);
  }
}
