import 'package:flutter/material.dart';
import '../widgets/hero_section.dart';
import '../widgets/home_feature_card.dart';
import '../widgets/home_features_section.dart';
import '../widgets/company_section.dart';
import '../widgets/content_section.dart';
import '../widgets/news_section.dart';
import '../widgets/faq_section.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      HomeFeatureCard(
        heading: 'A.I. CRM',
        description:
            'Powerful customer relationship management with quantum-level security',
        backgroundColor: const Color(0xFFF0F9FF), // Light blue
        subFeatures: [
          const SubFeatureCardData(
            icon: Icons.message,
            text: 'WhatsApp & Telegram integrations',
          ),
          const SubFeatureCardData(
            icon: Icons.calendar_today,
            text: 'Calendar Integration',
          ),
          const SubFeatureCardData(icon: Icons.people, text: 'CRM Integration'),
          const SubFeatureCardData(icon: Icons.mail, text: 'Email Automation'),
        ],
      ),
      HomeFeatureCard(
        heading: 'A.I. SALES',
        description: 'AI-powered sales tools to boost your revenue',
        backgroundColor: const Color(0xFFF5F3FF), // Light purple
        subFeatures: [
          const SubFeatureCardData(
            icon: Icons.phone,
            text: 'Voice AI Integration',
          ),
          const SubFeatureCardData(
            icon: Icons.trending_up,
            text: 'Sales Analytics',
          ),
          const SubFeatureCardData(
            icon: Icons.person_add,
            text: 'Lead Management',
          ),
          const SubFeatureCardData(icon: Icons.bolt, text: 'Automation Tools'),
        ],
      ),
      HomeFeatureCard(
        heading: 'A.I. MKT',
        description: 'Transform your marketing with artificial intelligence',
        backgroundColor: const Color(0xFFFEFFE6), // Light yellow
        subFeatures: [
          const SubFeatureCardData(
            icon: Icons.public,
            text: 'Social Media Management',
          ),
          const SubFeatureCardData(
            icon: Icons.analytics,
            text: 'Campaign Analytics',
          ),
          const SubFeatureCardData(icon: Icons.email, text: 'Email Marketing'),
          const SubFeatureCardData(
            icon: Icons.psychology,
            text: 'AI Content Creation',
          ),
        ],
      ),
      HomeFeatureCard(
        heading: 'A.I. CSR',
        description: '24/7 intelligent customer support',
        backgroundColor: const Color(0xFFEBF5FF), // Light cyan
        subFeatures: [
          const SubFeatureCardData(
            icon: Icons.headset_mic,
            text: '24/7 Support',
          ),
          const SubFeatureCardData(
            icon: Icons.chat,
            text: 'Live Chat Integration',
          ),
          const SubFeatureCardData(
            icon: Icons.people_outline,
            text: 'Customer Analytics',
          ),
          const SubFeatureCardData(
            icon: Icons.security,
            text: 'Issue Resolution',
          ),
        ],
      ),
      HomeFeatureCard(
        heading: 'PRICING',
        description: 'Solutions that scale with your business',
        backgroundColor: const Color(0xFFFFF5E6), // Light orange
        subFeatures: [
          const SubFeatureCardData(
            icon: Icons.business,
            text: 'Enterprise Plans',
          ),
          const SubFeatureCardData(
            icon: Icons.storage,
            text: 'Scalable Solutions',
          ),
          const SubFeatureCardData(
            icon: Icons.payment,
            text: 'Flexible Billing',
          ),
          const SubFeatureCardData(icon: Icons.lock, text: 'Secure Payments'),
        ],
      ),
    ];

    return Column(
      children: [
        const HeroSection(),
        HomeFeaturesSection(cards: cards),
        const CompanySection(),
        const ContentSection(),
        const NewsSection(),
        const FaqSection(
          title: 'FAQ',
          subtitle:
              'Click to view all frequently asked questions or explore our most common inquiries below',
        ),
      ],
    );
  }
}
