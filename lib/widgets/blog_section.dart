import 'package:flutter/material.dart';
import '../models/content_item.dart';
import 'content_carousel.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({super.key});

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
              ContentCarousel(contentItems: _getContentItems()),
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
          'AI Innovation Blog',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E40AF),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        const Text(
          'Stay ahead of the curve with insights on the latest AI technologies transforming industries worldwide',
          style: TextStyle(fontSize: 18, color: Color(0xFF6B7280)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  List<ContentItem> _getContentItems() {
    return [
      const ContentItem(
        title: 'Revolutionizing Customer Engagement: The Rise of AI',
        description:
            'Discover how AI voice agents are transforming customer interactions with natural, human-like conversations that deliver exceptional experiences and drive business growth.',
        category: 'Voice Technology',
        date: 'December 15, 2024',
        author: 'OPPERATOR AI Team',
        imagePath: 'assets/images/blog-voice-ai.jpg',
      ),
      const ContentItem(
        title: 'AI Video Creation: Transforming Content',
        description:
            'Explore the breakthrough technologies enabling businesses to create professional-quality videos in minutes, not hours, using advanced AI algorithms and machine learning.',
        category: 'Video AI',
        date: 'December 12, 2024',
        author: 'OPPERATOR AI Team',
        imagePath: 'assets/images/blog-video-ai.jpg',
      ),
      const ContentItem(
        title: 'The Future is Here: AI Avatars Redefining Digital',
        description:
            'Learn how photorealistic AI avatars are revolutionizing virtual meetings, customer service, and digital marketing with lifelike interactions that bridge the gap between human and digital.',
        category: 'Avatar Technology',
        date: 'December 10, 2024',
        author: 'OPPERATOR AI Team',
        imagePath: 'assets/images/blog-avatar-ai.jpg',
      ),
      const ContentItem(
        title: 'Machine Learning in Healthcare: A New Era',
        description:
            'Discover how AI is transforming healthcare with predictive analytics, personalized treatments, and automated diagnostics that improve patient outcomes and reduce costs.',
        category: 'Healthcare AI',
        date: 'December 8, 2024',
        author: 'OPPERATOR AI Team',
        imagePath: 'assets/images/blog-healthcare-ai.jpg',
      ),
      const ContentItem(
        title: 'Automating Business Processes with AI',
        description:
            'Learn how intelligent automation is streamlining operations, reducing manual work, and increasing efficiency across various industries with smart AI solutions.',
        category: 'Business AI',
        date: 'December 5, 2024',
        author: 'OPPERATOR AI Team',
        imagePath: 'assets/images/blog-business-ai.jpg',
      ),
      const ContentItem(
        title: 'The Ethics of Artificial Intelligence',
        description:
            'Explore the important considerations around AI ethics, responsible development, and ensuring that artificial intelligence benefits humanity while addressing potential risks.',
        category: 'AI Ethics',
        date: 'December 3, 2024',
        author: 'OPPERATOR AI Team',
        imagePath: 'assets/images/blog-ethics-ai.jpg',
      ),
    ];
  }
}
