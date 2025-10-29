import 'package:flutter/material.dart';
import '../models/faq_item.dart';
import 'faq_accordion_item.dart';

class FaqSection extends StatefulWidget {
  final List<FaqItem>? faqItems;
  final String? title;
  final String? subtitle;

  const FaqSection({super.key, this.faqItems, this.title, this.subtitle});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFC), // Light blue background
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 40 : 60,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1232),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSectionHeader(),
              const SizedBox(height: 48),
              _buildFaqGrid(isMobile, isTablet),
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
        Text(
          widget.title ?? 'FAQ',
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E40AF),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          widget.subtitle ??
              'Click to view all frequently asked questions or explore our most common inquiries below',
          style: const TextStyle(fontSize: 18, color: Color(0xFF6B7280)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFaqGrid(bool isMobile, bool isTablet) {
    final faqItems = widget.faqItems ?? _getFaqItems();

    if (isMobile) {
      // Single column on mobile
      return Column(
        children: faqItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: FaqAccordionItem(
              question: item.question,
              answer: item.answer,
              isExpanded: _expandedIndex == index,
              onTap: () => _toggleExpansion(index),
            ),
          );
        }).toList(),
      );
    } else {
      // Two columns on tablet and desktop
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: _buildFaqColumn(
                faqItems,
                0,
                2,
              ), // First column: items 0, 2, 4, 6, 8
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: _buildFaqColumn(
                faqItems,
                1,
                2,
              ), // Second column: items 1, 3, 5, 7, 9
            ),
          ),
        ],
      );
    }
  }

  List<Widget> _buildFaqColumn(
    List<FaqItem> faqItems,
    int startIndex,
    int step,
  ) {
    List<Widget> columnItems = [];
    for (int i = startIndex; i < faqItems.length; i += step) {
      columnItems.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: FaqAccordionItem(
            question: faqItems[i].question,
            answer: faqItems[i].answer,
            isExpanded: _expandedIndex == i,
            onTap: () => _toggleExpansion(i),
          ),
        ),
      );
    }
    return columnItems;
  }

  void _toggleExpansion(int index) {
    setState(() {
      _expandedIndex = _expandedIndex == index ? null : index;
    });
  }

  List<FaqItem> _getFaqItems() {
    return [
      const FaqItem(
        question: 'What AI services does OPPERATOR AI provide?',
        answer:
            'We provide comprehensive AI-powered solutions including AI Receptionist for 24/7 customer support, A.I. CRM for secure and efficient customer relationship management, AI Sales automation, 3D Avatar-Web integration, AI Content Creation, Social Media Automation, Lead Generation, and Customer Service Representatives. Our solutions are designed to streamline business operations and enhance customer engagement',
      ),
      const FaqItem(
        question: 'Can OPPERATOR AI handle multiple languages?',
        answer:
            'Yes! Our AI solutions support multiple languages including Arabic, English, French, Spanish, and many more. The AI can seamlessly switch between languages during conversations and can be customized to support your specific market\'s language requirements.',
      ),
      const FaqItem(
        question: 'How quickly can I get started with OPPERATOR AI?',
        answer:
            'Getting started is simple! Contact our team through the website, schedule a consultation call, and we\'ll assess your specific needs. We\'ll then customize our AI solutions to fit your business requirements, provide implementation support, and offer training to ensure smooth adoption of our technology. Most implementations take 2-4 weeks.',
      ),
      const FaqItem(
        question: 'What kind of support do you provide after implementation?',
        answer:
            'We provide comprehensive 24/7 support including technical assistance, regular system updates, performance monitoring, and optimization recommendations. Our dedicated support team is always available to ensure your AI solutions continue to perform at peak efficiency.',
      ),
      const FaqItem(
        question: 'Does OPPERATOR AI integrate with my existing systems?',
        answer:
            'Yes, absolutely! Our AI solutions are designed to integrate seamlessly with your existing CRM, calendar systems, email platforms, WhatsApp, Telegram, LinkedIn, and other business tools. We ensure minimal disruption to your current workflows while maximizing the benefits of AI automation.',
      ),
      const FaqItem(
        question: 'How does AI improve my sales performance?',
        answer:
            'Our AI Sales solution automates lead qualification, follow-ups, and customer engagement, allowing your team to focus on closing deals. It provides predictive analytics, intelligent lead scoring, and automated workflows that can increase sales productivity by up to 40% and significantly reduce response times.',
      ),
      const FaqItem(
        question: 'What is the pricing structure for OPPERATOR AI services?',
        answer:
            'Each AI product costs 800 AED for customization and deployment, plus a subscription of 4 AED per day. This includes full setup, training, and ongoing support. We offer flexible pricing options and can customize packages based on your specific business needs and scale.',
      ),
      const FaqItem(
        question: 'Can I customize the AI to match my brand voice?',
        answer:
            'Absolutely! We fully customize each AI solution to match your brand\'s personality, tone, and communication style. Whether you need formal corporate communication or casual friendly interactions, we train the AI to represent your brand perfectly across all customer touchpoints.',
      ),
      const FaqItem(
        question: 'How secure is my business data with OPPERATOR AI?',
        answer:
            'We take security extremely seriously. All data is encrypted end-to-end, stored in secure cloud infrastructure, and complies with international data protection standards. We implement multi-layer security protocols and regular security audits to ensure your business information remains completely protected.',
      ),
      const FaqItem(
        question: 'What ROI can I expect from implementing OPPERATOR AI?',
        answer:
            'Most clients see significant ROI within 3-6 months. Benefits include 70% reduction in operational costs, 24/7 customer service coverage, 40% faster sales cycles, and improved customer satisfaction scores. We provide detailed analytics to track your ROI and continuously optimize performance.',
      ),
    ];
  }
}
