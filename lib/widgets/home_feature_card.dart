import 'package:flutter/material.dart';
import 'home_sub_feature_card.dart';

class HomeFeatureCard extends StatefulWidget {
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
  State<HomeFeatureCard> createState() => _HomeFeatureCardState();
}

class _HomeFeatureCardState extends State<HomeFeatureCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1232),
      padding: EdgeInsets.all(isMobile ? 20 : 30),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTopSection(isMobile),
          const SizedBox(height: 32),
          _buildSubFeaturesGrid(isMobile),
        ],
      ),
    );
  }

  Widget _buildTopSection(bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextContent(isMobile),
          const SizedBox(height: 24),
          _buildImageArea(isMobile),
        ],
      );
    }

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
          widget.description,
          style: TextStyle(
            fontSize: isMobile ? 14 : 19,
            color: const Color(0xFF374151),
            height: 1.6,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
            decoration: BoxDecoration(
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: const Color(0xFF155DFC).withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: ElevatedButton(
              onPressed: widget.onViewMorePressed ?? () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return const Color(0xFF0F4CD8);
                  }
                  return const Color(0xFF155DFC);
                }),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                elevation: MaterialStateProperty.resolveWith<double>((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return 14;
                  }
                  return 10;
                }),
              ),
              child: const Text(
                'View more',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeading() {
    final parts = widget.heading.split(' ');
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
                color: Color(0xFFEC4899),
              ),
            ),
            TextSpan(
              text: parts[1],
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
          ],
        ),
      );
    }

    if (parts.length >= 2 && parts[0].toUpperCase() == 'A.I.') {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${parts[0]} ',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFFEC4899),
              ),
            ),
            TextSpan(
              text: parts[1],
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
          ],
        ),
      );
    }

    return Text(
      widget.heading,
      style: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E3A8A),
      ),
    );
  }

  Widget _buildImageArea(bool isMobile) {
    final Widget content = widget.illustration ??
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
        children: widget.subFeatures.asMap().entries.map((entry) {
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
    widget.subFeatures.asMap().entries.forEach((entry) {
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
