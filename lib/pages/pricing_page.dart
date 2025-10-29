import 'package:flutter/material.dart';
import 'package:new_public_website/library/extensions/context_extensions.dart';
import 'package:new_public_website/reponsiveness.dart/app_textstyles.dart';
import 'package:new_public_website/utils/app_reponsiveness/app_spaces.dart';
import 'package:new_public_website/utils/colors_util.dart';
import 'package:new_public_website/widgets/feature_grid_section.dart';
import 'package:new_public_website/widgets/pricing_card.dart';
import 'package:new_public_website/widgets/pricing_detail_card.dart';
import 'package:new_public_website/widgets/responsive_service_row.dart';
import 'package:new_public_website/widgets/tranform_bussiness_section.dart';

class PricingPageContent extends StatefulWidget {
  const PricingPageContent({super.key});

  @override
  State<PricingPageContent> createState() => _PricingPageContentState();
}

class _PricingPageContentState extends State<PricingPageContent> {
  final List<Widget> pricingCards = [
    PricingCard(
      title: "800 AED",
      isHover: false,
      subtitle: "Setup & Deployment",
      description: "One-time customization fee",
      titleColor: Colors.blue,
      focusBorderColor: Colors.blue,
      hoverColor: Colors.blue.withOpacity(0.1),
      onTap: () {},
    ),
    PricingCard(
      title: "4 AED/day",
      subtitle: "Monthly Subscription",
      description: "Per service, billed monthly",
      titleColor: Colors.green,
      backgroundColor: Colors.white,
      borderColor: Colors.green.withOpacity(0.3),
      focusBorderColor: Colors.green,
      showBadge: false,
      isHover: false,
      badgeText: "Save 15%",
      badgeColor: Colors.green,
      onTap: () {},
    ),
    PricingCard(
      title: "2-4 weeks",
      subtitle: "Implementation",
      description: "Design, develop & deploy",
      titleColor: AppColor.backgroundEndColor,
      subtitleColor: AppColor.backgroundEndColor,
      descriptionColor: AppColor.backgroundEndColor,
      backgroundColor: Colors.white,
      isHover: false,
      borderColor: Colors.green.withOpacity(0.3),
      focusBorderColor: Colors.green,
      badgeText: "Save 15%",
      badgeColor: Colors.green,
      onTap: () {},
    ),
  ];

  final List<Widget> planCards = [
    PricingCard(
      title: "Individual Services",
      description: "Choose specific AI services for your needs",
      titleColor: AppColor.darkTextColor,
      focusBorderColor: Colors.blue,
      hoverColor: Colors.blue.withOpacity(0.1),
      onTap: () {},
    ),
    PricingCard(
      title: "Startup Package",
      description: "3-4 services bundle for growing businesses",
      titleColor: AppColor.darkTextColor,
      backgroundColor: Colors.white,
      borderColor: Colors.green.withOpacity(0.3),
      focusBorderColor: Colors.green,
      showBadge: true,
      badgeText: "Save 15%",
      badgeColor: Colors.green,
      onTap: () {},
    ),
    PricingCard(
      title: "Enterprise Package",
      description: "All 8 services for comprehensive AI transformation",
      titleColor: Colors.black,
      borderColor: Colors.grey.withOpacity(0.3),
      focusBorderColor: Colors.blue,
      hoverBorderColor: Colors.blueAccent,
      hoverColor: Colors.blue.withOpacity(0.08),
      showBadge: true,
      badgeText: "Save 25%",
      badgeColor: Colors.green,
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;
    final bool isTablet = context.isTablet;
    final bool useColumn = isMobile || isTablet;
    final bool useColumnn = isMobile || isTablet;
    return Container(
      width: double.infinity,
      padding: AppSpaces.customPadding(context, h: 35, v: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'AI',
                textAlign: TextAlign.center,
                style: AppTextStyles.darkTexttext10(
                  context,
                ).copyWith(color: AppColor.primaryBrightTextColor),
              ),
              Text(
                textAlign: TextAlign.center,
                ' Services Pricing',
                style: AppTextStyles.darkTexttext10(context),
              ),
            ],
          ),
          AppSpaces.verticalBox(context, 8),
          Center(
            child: Text(
              'Choose from our comprehensive suite of AI solutions.Each service is designed\n to transform your businessoperations with cutting-edge artificial intelligence.',
              style: AppTextStyles.mediumDarkText3(context),
              textAlign: TextAlign.center,
            ),
          ),
          AppSpaces.verticalBox(context, 32),
          Padding(
            padding: AppSpaces.customPadding(context, h: 100),
            child: useColumn
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      pricingCards.length * 2 - 1,
                      (index) => index.isEven
                          ? pricingCards[index ~/ 2]
                          : AppSpaces.verticalBox(context, 20),
                    ),
                  )
                : Row(
                    children: List.generate(
                      pricingCards.length * 2 - 1,
                      (index) => index.isEven
                          ? Expanded(child: pricingCards[index ~/ 2])
                          : AppSpaces.horizontalBox(context, 20),
                    ),
                  ),
          ),

          AppSpaces.verticalBox(context, 50),
          Text(
            'Choose Your package',
            style: AppTextStyles.darkTexttext5(
              context,
            ).copyWith(fontWeight: FontWeight.normal),
          ),
          AppSpaces.verticalBox(context, 10),
          Padding(
            padding: AppSpaces.customPadding(context, h: 100),
            child: useColumnn
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      planCards.length * 2 - 1,
                      (index) => index.isEven
                          ? planCards[index ~/ 2]
                          : AppSpaces.verticalBox(context, 20),
                    ),
                  )
                : Row(
                    children: List.generate(
                      planCards.length * 2 - 1,
                      (index) => index.isEven
                          ? Expanded(child: planCards[index ~/ 2])
                          : AppSpaces.horizontalBox(context, 20),
                    ),
                  ),
          ),

          AppSpaces.verticalBox(context, 50),
          Padding(
            padding: AppSpaces.customPadding(context, h : isMobile|| isTablet ? 10 : 100),
            child: PricingDetailsCard(
              title: "Startup Package Pricing",
              setupPrice: "2720 AED",
              setupLabel: "Setup & Deployment",
              subscriptionPrice: "14 AED/day",
              subscriptionLabel: "Monthly Subscription",
              isMobile: context.isMobile,
              isTablet: context.isTablet,
            ),
          ),

          AppSpaces.verticalBox(context, 50),
          ResponsiveServiceRow(
            icon: Icons.people_alt_outlined,
            iconColor: Colors.blue,
            title: "AI CRM",
            smallLabelText: "Service 1 of 8",
            smallLabelTextColor: Colors.grey.shade600,
            description:
                "AI-powered CRM system that automates customer interactions.",
            titleColor: Colors.black,
            descriptionColor: Colors.black87,
            setupPrice: "800 AED",
            setupSubtitle: "Setup & Customization",
            subscriptionPrice: "4 AED/day",
            subscriptionSubtitle: "Monthly Subscription",
            buttonText: "Get Started",
            implementationText: "Implementation: 2–4 weeks",
            backgroundColor: Colors.white,
            buttonColor: const Color(0xFF0062FF),
            buttonTextColor: Colors.white,
            onButtonTap: () {},
          ),
          AppSpaces.verticalBox(context, 50),
          FeatureGridSection(
            title: "Core Features & Capabilities",
            features: [
              "Automated Lead Scoring & Qualification",
              "Intelligent Customer Segmentation",
              "Predictive Sales Analytics",
              "AI-Powered Email Automation",
              "Smart Contact Management",
              "Real-time Sales Dashboard",
              "Integration with 50+ Platforms",
              "Custom Workflow Automation",
            ],
            featureIcon: Icons.check_rounded,
            featureIconColor: Colors.green,
            titleColor: Colors.black,
            textColor: Colors.black87,
            tileBackgroundColor: const Color(0xFFF9FAFB),
            borderColor: Colors.grey,
          ),
          AppSpaces.verticalBox(context, 50),
          ResponsiveServiceRow(
            icon: Icons.people_alt_outlined,
            iconColor: Colors.blue,
            title: "AI Sales",
            smallLabelText: "Service 2 of 8",
            smallLabelTextColor: Colors.grey.shade600,
            description:
                "Intelligent Customer Relationship Management system that automates lead tracking, customer interactions, and sales pipeline management with AI-powered insights.",
            titleColor: Colors.black,
            descriptionColor: Colors.black87,
            setupPrice: "800 AED",
            setupSubtitle: "Setup & Customization",
            subscriptionPrice: "4 AED/day",
            subscriptionSubtitle: "Monthly Subscription",
            buttonText: "Get Started",
            implementationText: "Implementation: 2-4 weeks",
            backgroundColor: Colors.white,
            buttonColor: const Color(0xFF0062FF),
            buttonTextColor: Colors.white,
            onButtonTap: () {
              // handle tap
            },
          ),

          FeatureGridSection(
            title: "Core Features & Capabilities",
            features: [
              "AI Sales Script Generation",
              "Real-time Objection Handling",
              "Conversation Intelligence",
              "Automated Follow-up Sequences",
              "Personalized Proposal Creation",
              "Deal Probability Scoring",
              "Performance Analytics",
              "A/B Testing for Sales Scripts",
            ],
            featureIcon: Icons.check_rounded,
            featureIconColor: Colors.green,
            titleColor: Colors.black,
            textColor: Colors.black87,
            tileBackgroundColor: const Color(0xFFF9FAFB),
            borderColor: Colors.grey,
          ),
          AppSpaces.verticalBox(context, 50),
          ResponsiveServiceRow(
            icon: Icons.people_alt_outlined,
            iconColor: Colors.blue,
            title: "AI MKT",
            smallLabelText: "Service 3 of 8",
            smallLabelTextColor: Colors.grey.shade600,
            description:
                "Comprehensive AI marketing platform that creates, optimizes, and manages your marketing campaigns across all channels with data-driven insights.",
            titleColor: Colors.black,
            descriptionColor: Colors.black87,
            setupPrice: "800 AED",
            setupSubtitle: "Setup & Customization",
            subscriptionPrice: "4 AED/day",
            subscriptionSubtitle: "Monthly Subscription",
            buttonText: "Get Started",
            implementationText: "Implementation: 2-4 weeks",
            backgroundColor: Colors.white,
            buttonColor: const Color(0xFF0062FF),
            buttonTextColor: Colors.white,
            onButtonTap: () {
              // handle tap
            },
          ),

          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Expanded(
          //       flex: 6,
          //       child: ServiceInfoTile(
          //         icon: Icons.people_alt_outlined,
          //         iconColor: Colors.blue,
          //         title: "AI SALes",
          //         smallLabelText: "Service 2 of 8",
          //         smallLabelTextColor: Colors.grey.shade600,
          //         description:
          //             "Intelligent Customer Relationship Management system that automates lead tracking, customer interactions, and sales pipeline management with AI-powered insights.",
          //         titleColor: Colors.black,
          //         descriptionColor: Colors.black87,
          //       ),
          //     ),
          //     const SizedBox(width: 24),
          //     Expanded(
          //       flex: 3,
          //       child: CustomPricingBox(
          //         setupPrice: "800 AED",
          //         setupSubtitle: "Setup & Customization",
          //         subscriptionPrice: "4 AED/day",
          //         subscriptionSubtitle: "Monthly Subscription",
          //         buttonText: "Get Started",
          //         implementationText: "Implementation: 2-4 weeks",
          //         backgroundColor: Colors.white,
          //         buttonColor: const Color(0xFF0062FF),
          //         buttonTextColor: Colors.white,
          //         onButtonTap: () {
          //           // handle tap
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          AppSpaces.verticalBox(context, 50),
          FeatureGridSection(
            title: "Core Features & Capabilities",
            features: [
              "Automated Content Creation",
              "Multi-Channel Campaign Management",
              "Audience Targeting & Segmentation",
              "Performance Optimization",
              "Social Media Automation",
              "Email Marketing AI",
              "SEO Content Optimization",
              "Marketing ROI Analytics",
            ],
            featureIcon: Icons.check_rounded,
            featureIconColor: Colors.green,
            titleColor: Colors.black,
            textColor: Colors.black87,
            tileBackgroundColor: const Color(0xFFF9FAFB),
            borderColor: Colors.grey,
          ),
          AppSpaces.verticalBox(context, 50),

          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Expanded(
          //       flex: 6,
          //       child: ServiceInfoTile(
          //         icon: Icons.people_alt_outlined,
          //         iconColor: Colors.blue,
          //         title: "AI 3D AVATAR WEB",
          //         smallLabelText: "Service 1 of 8",
          //         smallLabelTextColor: Colors.grey.shade600,
          //         description:
          //             "Comprehensive AI marketing platform that creates, optimizes, and manages your marketing campaigns across all channels with data-driven insights.",
          //         titleColor: Colors.black,
          //         descriptionColor: Colors.black87,
          //       ),
          //     ),
          //     const SizedBox(width: 24),
          //     Expanded(
          //       flex: 3,
          //       child: CustomPricingBox(
          //         setupPrice: "800 AED",
          //         setupSubtitle: "Setup & Customization",
          //         subscriptionPrice: "4 AED/day",
          //         subscriptionSubtitle: "Monthly Subscription",
          //         buttonText: "Get Started",
          //         implementationText: "Implementation: 2-4 weeks",
          //         backgroundColor: Colors.white,
          //         buttonColor: const Color(0xFF0062FF),
          //         buttonTextColor: Colors.white,
          //         onButtonTap: () {
          //           // handle tap
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          AppSpaces.verticalBox(context, 50),
          FeatureGridSection(
            title: "Core Features & Capabilities",
            features: [
              "Photorealistic 3D Avatars",
              "Natural Language Processing",
              "Voice Synthesis & Recognition",
              "Gesture & Emotion Recognition",
              "Multi-language Support",
              "Custom Avatar Design",
              "WebGL Integration",
              "MReal-time Interaction Analytics",
            ],
            featureIcon: Icons.check_rounded,
            featureIconColor: Colors.green,
            titleColor: Colors.black,
            textColor: Colors.black87,
            tileBackgroundColor: const Color(0xFFF9FAFB),
            borderColor: Colors.grey,
          ),

          AppSpaces.verticalBox(context, 50),
          ResponsiveServiceRow(
            icon: Icons.people_alt_outlined,
            iconColor: Colors.blue,
            title: "AI 3D AVATAR WEB",
            smallLabelText: "Service 4 of 8",
            smallLabelTextColor: Colors.grey.shade600,
            description:
                "Interactive 3D AI avatars for your website that engage visitors with lifelike conversations, product demonstrations, and personalized assistance.",
            titleColor: Colors.black,
            descriptionColor: Colors.black87,
            setupPrice: "800 AED",
            setupSubtitle: "Setup & Customization",
            subscriptionPrice: "4 AED/day",
            subscriptionSubtitle: "Monthly Subscription",
            buttonText: "Get Started",
            implementationText: "Implementation: 2-4 weeks",
            backgroundColor: Colors.white,
            buttonColor: const Color(0xFF0062FF),
            buttonTextColor: Colors.white,
            onButtonTap: () {
              // handle tap
            },
          ),

          AppSpaces.verticalBox(context, 50),
          FeatureGridSection(
            title: "Core Features & Capabilities",
            features: [
              "Photorealistic 3D Avatars",
              "Natural Language Processing",
              "Voice Synthesis & Recognition",
              "Gesture & Emotion Recognition",
              "Multi-language Support",
              "Custom Avatar Design",
              "WebGL Integration",
              "Real-time Interaction Analytics",
            ],
            featureIcon: Icons.check_rounded,
            featureIconColor: Colors.green,
            titleColor: Colors.black,
            textColor: Colors.black87,
            tileBackgroundColor: const Color(0xFFF9FAFB),
            borderColor: Colors.grey,
          ),

          AppSpaces.verticalBox(context, 50),
          ResponsiveServiceRow(
            icon: Icons.people_alt_outlined,
            iconColor: Colors.blue,
            title: "AI CSR",
            smallLabelText: "Service 5 of 8",
            smallLabelTextColor: Colors.grey.shade600,
            description:
                "AI-powered customer service representative that provides 24/7 support, handles inquiries, and resolves issues with human-like empathy and efficiency.",
            titleColor: Colors.black,
            descriptionColor: Colors.black87,
            setupPrice: "800 AED",
            setupSubtitle: "Setup & Customization",
            subscriptionPrice: "4 AED/day",
            subscriptionSubtitle: "Monthly Subscription",
            buttonText: "Get Started",
            implementationText: "Implementation: 2-4 weeks",
            backgroundColor: Colors.white,
            buttonColor: const Color(0xFF0062FF),
            buttonTextColor: Colors.white,
            onButtonTap: () {
              // handle tap
            },
          ),

          AppSpaces.verticalBox(context, 50),
          FeatureGridSection(
            title: "Core Features & Capabilities",
            features: [
              "24/7 Customer Support",
              "Multi-language Communication",
              "Sentiment Analysis",
              "Ticket Management System",
              "Knowledge Base Integration",
              "Escalation Management",
              "Customer Satisfaction Tracking",
              "Live Chat Integration",
            ],
            featureIcon: Icons.check_rounded,
            featureIconColor: Colors.green,
            titleColor: Colors.black,
            textColor: Colors.black87,
            tileBackgroundColor: const Color(0xFFF9FAFB),
            borderColor: Colors.grey,
          ),

          AppSpaces.verticalBox(context, 50),
          ResponsiveServiceRow(
            icon: Icons.people_alt_outlined,
            iconColor: Colors.blue,
            title: "AI SOCIAL",
            smallLabelText: "Service 6 of 8",
            smallLabelTextColor: Colors.grey.shade600,
            description:
                "Intelligent social media management platform that creates content, schedules posts, engages with followers, and analyzes social media performance.",
            titleColor: Colors.black,
            descriptionColor: Colors.black87,
            setupPrice: "800 AED",
            setupSubtitle: "Setup & Customization",
            subscriptionPrice: "4 AED/day",
            subscriptionSubtitle: "Monthly Subscription",
            buttonText: "Get Started",
            implementationText: "Implementation: 2-4 weeks",
            backgroundColor: Colors.white,
            buttonColor: const Color(0xFF0062FF),
            buttonTextColor: Colors.white,
            onButtonTap: () {
              // handle tap
            },
          ),

          AppSpaces.verticalBox(context, 50),
          FeatureGridSection(
            title: "Core Features & Capabilities",
            features: [
              "Automated Content Creation",
              "Smart Posting Scheduler",
              "Engagement Automation",
              "Hashtag Optimization",
              "Competitor Analysis",
              "Influencer Identification",
              "Social Listening",
              "Cross-Platform Management",
            ],
            featureIcon: Icons.check_rounded,
            featureIconColor: Colors.green,
            titleColor: Colors.black,
            textColor: Colors.black87,
            tileBackgroundColor: const Color(0xFFF9FAFB),
            borderColor: Colors.grey,
          ),

          AppSpaces.verticalBox(context, 50),
          ResponsiveServiceRow(
            icon: Icons.people_alt_outlined,
            iconColor: Colors.blue,
            title: "AI RECEPTIONIST",
            smallLabelText: "Service 7 of 8",
            smallLabelTextColor: Colors.grey.shade600,
            description:
                "Virtual AI receptionist that handles calls, schedules appointments, provides information, and manages visitor interactions with professional efficiency.",
            titleColor: Colors.black,
            descriptionColor: Colors.black87,
            setupPrice: "800 AED",
            setupSubtitle: "Setup & Customization",
            subscriptionPrice: "4 AED/day",
            subscriptionSubtitle: "Monthly Subscription",
            buttonText: "Get Started",
            implementationText: "Implementation: 2-4 weeks",
            backgroundColor: Colors.white,
            buttonColor: const Color(0xFF0062FF),
            buttonTextColor: Colors.white,
            onButtonTap: () {
              // handle tap
            },
          ),

          AppSpaces.verticalBox(context, 50),
          FeatureGridSection(
            title: "Core Features & Capabilities",
            features: [
              "Intelligent Call Handling",
              "SAppointment Scheduling",
              "Visitor Management",
              "Multi-language Support",
              "Calendar Integration",
              "Call Routing & Transfer",
              "Message Taking & Forwarding",
              "Analytics & Reporting",
            ],
            featureIcon: Icons.check_rounded,
            featureIconColor: Colors.green,
            titleColor: Colors.black,
            textColor: Colors.black87,
            tileBackgroundColor: const Color(0xFFF9FAFB),
            borderColor: Colors.grey,
          ),

          AppSpaces.verticalBox(context, 50),
          ResponsiveServiceRow(
            icon: Icons.people_alt_outlined,
            iconColor: Colors.blue,
            title: "AI AUDIT",
            smallLabelText: "Service 8 of 8",
            smallLabelTextColor: Colors.grey.shade600,
            description:
                "AI-powered auditing system that monitors operations, detects inefficiencies, ensures compliance, and provides actionable insights for continuous improvement.",
            titleColor: Colors.black,
            descriptionColor: Colors.black87,
            setupPrice: "800 AED",
            setupSubtitle: "Setup & Customization",
            subscriptionPrice: "4 AED/day",
            subscriptionSubtitle: "Monthly Subscription",
            buttonText: "Get Started",
            implementationText: "Implementation: 2-4 weeks",
            backgroundColor: Colors.white,
            buttonColor: const Color(0xFF0062FF),
            buttonTextColor: Colors.white,
            onButtonTap: () {
              // handle tap
            },
          ),

          AppSpaces.verticalBox(context, 50),
          FeatureGridSection(
            title: "Core Features & Capabilities",
            features: [
              "Process Analysis & Optimization",
              "Risk Assessment & Management",
              "Compliance Monitoring",
              "Performance Benchmarking",
              "Cost Analysis & Reduction",
              "Quality Control Automation",
              "Predictive Maintenance",
              "Custom Audit Reports",
            ],
            featureIcon: Icons.check_rounded,
            featureIconColor: Colors.green,
            titleColor: Colors.black,
            textColor: Colors.black87,
            tileBackgroundColor: const Color(0xFFF9FAFB),
            borderColor: Colors.grey,
          ),
          AppSpaces.verticalBox(context, 100),
          const TransformBusinessSection(),
        ],
      ),
    );
  }
}
