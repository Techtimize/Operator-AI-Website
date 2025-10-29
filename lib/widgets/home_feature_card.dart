import 'package:flutter/material.dart';
import 'home_sub_feature_card.dart';

class HomeFeatureCard extends StatelessWidget {
  final String heading;
  final String description;
  final VoidCallback? onViewMorePressed;
  final List<SubFeatureCardData> subFeatures;
  final Color backgroundColor;
  final Widget? illustration;

  const HomeFeatureCard({
    super.key,
    required this.heading,
    required this.description,
    this.onViewMorePressed,
    required this.subFeatures,
    required this.backgroundColor,
    this.illustration,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1232),
      padding: EdgeInsets.all(isMobile ? 20 : 30),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top section with heading, description, button, and image
          _buildTopSection(isMobile),
          const SizedBox(height: 32),
          // Sub-features grid
          _buildSubFeaturesGrid(isMobile),
        ],
      ),
    );
  }

  Widget _buildTopSection(bool isMobile) {
    if (isMobile) {
      // Mobile: Stack elements vertically
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextContent(isMobile),
          const SizedBox(height: 24),
          _buildImageArea(isMobile),
        ],
      );
    }

    // Desktop: Side by side layout
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildTextContent(isMobile)),
        const SizedBox(width: 48),
        Expanded(flex: 3, child: _buildImageArea(isMobile)),
      ],
    );
  }

  Widget _buildTextContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeading(),
        const SizedBox(height: 16),
        Text(
          description,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: const Color(0xFF374151),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: onViewMorePressed ?? () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'View more',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeading() {
    final parts = heading.split(' ');
    final hasAiAndSales =
        parts.length >= 2 &&
        parts[0].toUpperCase() == 'A.I.' &&
        parts[1].toUpperCase() == 'SALES';

    if (hasAiAndSales) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${parts[0]} ',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFFEC4899), // Pink
              ),
            ),
            TextSpan(
              text: parts[1],
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A), // Deep blue
              ),
            ),
          ],
        ),
      );
    }

    // Check for other patterns with "A.I."
    if (parts.length >= 2 && parts[0].toUpperCase() == 'A.I.') {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${parts[0]} ',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFFEC4899), // Pink
              ),
            ),
            TextSpan(
              text: parts[1],
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A), // Deep blue
              ),
            ),
          ],
        ),
      );
    }

    return Text(
      heading,
      style: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E3A8A),
      ),
    );
  }

  Widget _buildImageArea(bool isMobile) {
    final Widget content =
        illustration ??
        const Center(
          child: Icon(Icons.image, size: 64, color: Color(0xFF9CA3AF)),
        );

    return Container(
      constraints: const BoxConstraints(maxWidth: 832, maxHeight: 256),
      width: double.infinity,
      height: isMobile ? 200 : 256,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
      ),
      child: content,
    );
  }

  Widget _buildSubFeaturesGrid(bool isMobile) {
    final crossAxisCount = isMobile ? 1 : 4;

    if (crossAxisCount == 1) {
      return Column(
        children: subFeatures.asMap().entries.map((entry) {
          final index = entry.key;
          final feature = entry.value;
          return Column(
            children: [
              if (index > 0) const SizedBox(height: 16),
              HomeSubFeatureCard(icon: feature.icon, text: feature.text),
            ],
          );
        }).toList(),
      );
    }

    final List<Widget> widgets = [];
    subFeatures.asMap().entries.forEach((entry) {
      final index = entry.key;
      final feature = entry.value;

      if (index > 0) {
        widgets.add(const SizedBox(width: 16));
      }

      widgets.add(
        Expanded(
          child: HomeSubFeatureCard(icon: feature.icon, text: feature.text),
        ),
      );
    });

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }
}

class SubFeatureCardData {
  final IconData icon;
  final String text;

  const SubFeatureCardData({required this.icon, required this.text});
}
