import 'package:flutter/material.dart';
import '../widgets/faq_section.dart';
import '../widgets/contact_support_card.dart';

class FaqPageContent extends StatelessWidget {
  const FaqPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FaqSection(
          title: 'Frequently Asked Questions',
          subtitle:
              'Find answers to common questions about OPPERATOR AI services, implementation, and support.',
        ),
        ContactSupportCard(),
      ],
    );
  }
}
