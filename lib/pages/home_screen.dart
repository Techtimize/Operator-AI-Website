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
    Widget buildIllustration(IconData icon, List<IconData> badges, Color bg) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [bg.withValues(alpha: 0.3), bg.withValues(alpha: 0.1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: Icon(icon, size: 120, color: const Color(0xFF1E3A8A)),
              ),
            ),
            Positioned(
              left: 24,
              top: 28,
              child: Row(
                children: badges
                    .map(
                      (b) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          b,
                          size: 18,
                          color: const Color(0xFF2563EB),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      );
    }

    final cards = [
      HomeFeatureCard(
        heading: 'A.I. CRM',
        description:
            'Powerful customer relationship management with quantum-level security',
        backgroundColor: const Color(0xFFF0F9FF), // Light blue
        illustration: buildIllustration(Icons.hub_outlined, const [
          Icons.message,
          Icons.calendar_today,
          Icons.people_alt_outlined,
        ], const Color(0xFF38BDF8)),
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
        illustration: buildIllustration(Icons.trending_up, const [
          Icons.person_add,
          Icons.phone,
          Icons.analytics_outlined,
        ], const Color(0xFFA78BFA)),
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
        illustration: buildIllustration(Icons.campaign_outlined, const [
          Icons.public,
          Icons.analytics,
          Icons.email,
        ], const Color(0xFFF59E0B)),
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
        illustration: buildIllustration(Icons.headset_mic, const [
          Icons.chat_bubble_outline,
          Icons.security_outlined,
        ], const Color(0xFF60A5FA)),
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
        illustration: buildIllustration(Icons.payments_outlined, const [
          Icons.price_change_outlined,
          Icons.lock_outline,
        ], const Color(0xFFFBBF24)),
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
