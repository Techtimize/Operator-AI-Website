import 'package:flutter/material.dart';
import '../models/content_item.dart';
import 'content_carousel.dart';
import 'cta_card.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFC), // Light blue background
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1232),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSectionHeader(),
              const SizedBox(height: 48),
              ContentCarousel(contentItems: _getNewsItems()),
              const SizedBox(height: 48),
              _buildCtaCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Light blue line above title
        Container(
          width: 40,
          height: 2,
          decoration: const BoxDecoration(
            color: Color(0xFF3B82F6),
            borderRadius: BorderRadius.all(Radius.circular(1)),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Latest News Releases',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E40AF),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        const Text(
          'Stay informed with the latest announcements, partnerships, and milestones from OPPERATOR AI',
          style: TextStyle(fontSize: 18, color: Color(0xFF6B7280)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCtaCard() {
    return CtaCard(
      title: 'Media & Press Inquiries',
      description:
          'For press releases, media kits, or interview requests, contact our communications team.',
      primaryButtonText: 'Contact Press Team',
      secondaryButtonText: 'Download Media Kit',
      onPrimaryPressed: () {
        // TODO: Implement contact press team functionality
      },
      onSecondaryPressed: () {
        // TODO: Implement download media kit functionality
      },
    );
  }

  List<ContentItem> _getNewsItems() {
    return [
      const ContentItem(
        title: 'OPPERATOR AI Launches Revolutionary AI Receptionist',
        description:
            'Dubai-based OPPERATOR AI unveils next-generation AI Receptionist platform, delivering 24/7 intelligent customer engagement with natural language processing and advanced automation capabilities.',
        category: 'Product Launch',
        date: 'January 15, 2025',
        author: 'Press Team',
        imagePath: 'assets/images/news-product-launch.jpg',
      ),
      const ContentItem(
        title: 'Strategic Partnership with Leading UAE Real Estate Firms',
        description:
            'OPPERATOR AI announces major partnership with top real estate developers to deploy AI CSR solutions, automating customer service and streamlining property management processes.',
        category: 'Partnership',
        date: 'January 10, 2025',
        author: 'Press Team',
        imagePath: 'assets/images/news-partnership.jpg',
      ),
      const ContentItem(
        title: 'OPPERATOR AI Reports 300% Growth in Q4 2024',
        description:
            'Company achieves remarkable milestone with triple-digit growth, expanding client base across healthcare, real estate, and financial services sectors with innovative AI solutions.',
        category: 'Company News',
        date: 'January 5, 2025',
        author: 'Press Team',
        imagePath: 'assets/images/news-growth.jpg',
      ),
      const ContentItem(
        title: 'AI Innovation Award for Excellence in Customer Service',
        description:
            'OPPERATOR AI receives prestigious recognition for outstanding contributions to AI-powered customer service solutions, setting new industry standards for intelligent automation.',
        category: 'Awards',
        date: 'December 28, 2024',
        author: 'Press Team',
        imagePath: 'assets/images/news-award.jpg',
      ),
      const ContentItem(
        title: 'Expansion into European Markets with AI Solutions',
        description:
            'OPPERATOR AI announces strategic expansion into European markets, bringing cutting-edge AI receptionist and customer service solutions to businesses across the continent.',
        category: 'Expansion',
        date: 'December 20, 2024',
        author: 'Press Team',
        imagePath: 'assets/images/news-expansion.jpg',
      ),
      const ContentItem(
        title: 'New Research Partnership with Leading Universities',
        description:
            'OPPERATOR AI establishes research partnerships with top universities to advance AI technology and develop next-generation conversational AI solutions for enterprise applications.',
        category: 'Research',
        date: 'December 15, 2024',
        author: 'Press Team',
        imagePath: 'assets/images/news-research.jpg',
      ),
    ];
  }
}
