import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_public_website/widgets/ctaButton.dart';
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
        // Container(
        //   width: 40,
        //   height: 2,
        //   decoration: const BoxDecoration(
        //     color: Color(0xFF3B82F6),
        //     borderRadius: BorderRadius.all(Radius.circular(1)),
        //   ),
        // ),
        // const SizedBox(height: 16),
        Text(
          widget.title ?? 'FAQ',
          style: const TextStyle(
            fontSize: 46,
            fontWeight: FontWeight.normal,
            color: Color(0xFF155DFC),
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
        question: 'Does OPERATOR AI Integrate with my existing system?',
        answer:
            'Yes, absolutely! Our AI solutions are designed to integrate seamlessly with your existing CRM, calendar systems, email platforms, WhatsApp, Telegram, LinkedIn, and other business tools. We ensure minimal disruption to your current workflows while maximizing the benefits of AI automation.',
      ),
      const FaqItem(
        question: 'How quickly can I get started with OPPERATOR AI?',
        answer:
            'Getting started is simple! Contact our team through the website, schedule a consultation call, and we\'ll assess your specific needs. We\'ll then customize our AI solutions to fit your business requirements, provide implementation support, and offer training to ensure smooth adoption of our technology. Most implementations take 2-4 weeks.',
      ),
      const FaqItem(
        question: 'What is the Pricing structure for OPPERATOR AI services?',
        answer:
            'We provide comprehensive 24/7 support including technical assistance, regular system updates, performance monitoring, and optimization recommendations. Our dedicated support team is always available to ensure your AI solutions continue to perform at peak efficiency.',
      ),
    ];
  }
}
