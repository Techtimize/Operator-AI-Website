import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_public_website/utils/app_reponsiveness/device_utils.dart';
import 'package:new_public_website/utils/app_reponsiveness/responsive_utils.dart';
import 'package:new_public_website/widgets/news_release.dart';
import '../widgets/hero_section.dart';
import '../widgets/home_feature_card.dart';
import '../widgets/home_features_section.dart';
import '../widgets/company_section.dart';
import '../widgets/content_section.dart';
import 'package:new_public_website/utils/app_reponsiveness/device_utils.dart';
import '../widgets/ctaButton.dart';

import '../widgets/news_section.dart';
import '../widgets/faq_section.dart';
import '../widgets/headingSection.dart';
import '../widgets/generalCard.dart';
import '../widgets/bCard.dart';
import '../widgets/teamMemberCard.dart';
import '../responsiveness/responsive.dart';
import '../widgets/finalSection.dart';
import '../widgets/newsletter_section.dart';
import '../widgets/news_release.dart';



// ignore: depend_on_referenced_packages
// import 'package:OPERATOR-AI-WEBSITE/widgets/bCard.dart'; // Adjust path accordingly

class HomeScreenContent extends StatelessWidget {
   HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildIllustration(IconData icon, List<IconData> badges, Color bg) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [bg.withValues(alpha: 0.1), bg.withValues(alpha: 0.1)],
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
                child: Icon(icon, size: 120, color: const Color.fromARGB(255, 0, 0, 0)),
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
    // final cards = [
    //   HomeFeatureCard(
    //     heading: 'A.1. CRM',
    //     description:
    //         'Powerful customer relationship management with quantum-level',
    //     backgroundColor: const Color(0xFFF0F9FF), // Light blue
    //     illustration: buildIllustration(Icons.hub_outlined, const [
    //       Icons.message,
    //       Icons.calendar_today,
    //       Icons.people_alt_outlined,
    //     ], const Color(0xFF38BDF8)),
    //     subFeatures: [
    //       const SubFeatureCardData(
    //         icon: Icons.message,
    //         text: 'WhatsApp & Telegram integrations',
    //       ),
    //       const SubFeatureCardData(
    //         icon: Icons.calendar_today,
    //         text: 'Calendar Integration',
    //       ),
    //       const SubFeatureCardData(icon: Icons.people, text: 'CRM Integration'),
    //       const SubFeatureCardData(icon: Icons.mail, text: 'Email Automation'),
    //     ],
    //   ),
    //   HomeFeatureCard(
    //     heading: 'A.I. SALES',
    //     description: "The most Intelligent & Smart Sales",
    //     backgroundColor: Color(0xFFE8FAF1), // Light purple
    //     illustration: buildIllustration(Icons.trending_up, const [
    //       Icons.person_add,
    //       Icons.phone,
    //       Icons.analytics_outlined,
    //     ], const Color(0xFFA78BFA)),
    //     subFeatures: [
    //       const SubFeatureCardData(
    //         icon: Icons.phone,
    //         text: 'Voice AI Integration',
    //       ),
    //       const SubFeatureCardData(
    //         icon: Icons.trending_up,
    //         text: 'Sales Analytics',
    //       ),
    //       const SubFeatureCardData(
    //         icon: Icons.person_add,
    //         text: 'Lead Management',
    //       ),
    //       const SubFeatureCardData(icon: Icons.bolt, text: 'Automation Tools'),
    //     ],
    //   ),
    //   HomeFeatureCard(
    //     heading: 'A.I. MKT',
    //     description: 'Transform your marketing with artificial intelligence',
    //     backgroundColor: const Color(0xFFFEFFE6), // Light yellow
    //     illustration: buildIllustration(Icons.campaign_outlined, const [
    //       Icons.public,
    //       Icons.analytics,
    //       Icons.email,
    //     ], const Color(0xFFF59E0B)),
    //     subFeatures: [
    //       const SubFeatureCardData(
    //         icon: Icons.public,
    //         text: 'Social Media Management',
    //       ),
    //       const SubFeatureCardData(
    //         icon: Icons.analytics,
    //         text: 'Campaign Analytics',
    //       ),
    //       const SubFeatureCardData(icon: Icons.email, text: 'Email Marketing'),
    //       const SubFeatureCardData(
    //         icon: Icons.psychology,
    //         text: 'AI Content Creation',
    //       ),
    //     ],
    //   ),
    //   HomeFeatureCard(
    //     heading: 'A.I. CSR',
    //     description: '24/7 intelligent customer support',
    //     backgroundColor: const Color(0xFFEBF5FF), // Light cyan
    //     illustration: buildIllustration(Icons.headset_mic, const [
    //       Icons.chat_bubble_outline,
    //       Icons.security_outlined,
    //     ], const Color(0xFF60A5FA)),
    //     subFeatures: [
    //       const SubFeatureCardData(
    //         icon: Icons.headset_mic,
    //         text: '24/7 Support',
    //       ),
    //       const SubFeatureCardData(
    //         icon: Icons.chat,
    //         text: 'Live Chat Integration',
    //       ),
    //       const SubFeatureCardData(
    //         icon: Icons.people_outline,
    //         text: 'Customer Analytics',
    //       ),
    //       const SubFeatureCardData(
    //         icon: Icons.security,
    //         text: 'Issue Resolution',
    //       ),
    //     ],
    //   ),
    //   // HomeFeatureCard(
    //   //   heading: 'PRICING',
    //   //   description: 'Solutions that scale with your business',
    //   //   backgroundColor: const Color(0xFFFFF5E6), // Light orange
    //   //   illustration: buildIllustration(Icons.payments_outlined, const [
    //   //     Icons.price_change_outlined,
    //   //     Icons.lock_outline,
    //   //   ], const Color(0xFFFBBF24)),
    //   //   subFeatures: [
    //   //     const SubFeatureCardData(
    //   //       icon: Icons.business,
    //   //       text: 'Enterprise Plans',
    //   //     ),
    //   //     const SubFeatureCardData(
    //   //       icon: Icons.storage,
    //   //       text: 'Scalable Solutions',
    //   //     ),
    //   //     const SubFeatureCardData(
    //   //       icon: Icons.payment,
    //   //       text: 'Flexible Billing',
    //   //     ),
    //   //     const SubFeatureCardData(icon: Icons.lock, text: 'Secure Payments'),
    //   //   ],
    //   // ),
    // ];

    return Column(
      children: [
        const HeroSection(),
        HeadingSection(
          heading: 'Transform Your Business with AI Agents',
          paragraph:
              'Capture every sales opportunity, scale marketing impact without added costs,\n and deliver exceptional customer experiences while optimizing support operations.', 
        ),
        SizedBox(height: context.rh(90),),
        // Responsive layout using Column for mobile and Row for larger screens
// ✅ UPDATED RESPONSIVE LAYOUT
ResponsiveUtils.isMobile(context) 
    ? Column(
        children: [
          SizedBox(height: 16),
          GeneralCard(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF6339A),
                Color(0xFFE60076),
                Color(0xFF9810FA),
              ],
              stops: [0.0, 0.5, 1.0],
            ), 
            topIconPath: 'assets/icons/target.svg', 
            cardTitle: 'Sales with AI', 
            videoDescription: 'AI Sales Demo: Lead qualification in',
            question: 'Struggling with manual lead follow-ups and countless lost opportunities?', 
            answer: 'Your AI Sales Agent works 24/7 to qualify leads, book meetings, and close the deals while you sleep.',
            iconColor: Colors.pink, 
            buttonColor: Color(0xFF155DFC), 
            buttonTitle: 'Explore Sales with AI', 
            featureIcons: [
              'assets/Icons/outreach.svg',
              'assets/Icons/crm.svg',
              'assets/Icons/schedule.svg',
              'assets/Icons/lead.svg',
              'assets/Icons/analytics.svg',
              'assets/Icons/scoring.svg',
            ],
            featureTitles: [
              'Automated lead generation & qualification workflows',
              'Personalized outreach campaigns at massive scale',
              'Instant meeting scheduling & intelligent follow-ups',
              'Smart CRM integration  &  real-time data sync',
              'Real-time pipeline analytics & sales forecasting',
              'AI-powered lead scoring & priority management',
            ],
          ),
          SizedBox(height: 20),
          GeneralCard(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2B7FFF),
                Color(0xFF155DFC),
                Color(0xFF0092B8),
              ],
              stops: [0.0, 0.5, 1.0],
            ), 
            topIconPath: 'assets/icons/mktLogo.svg', 
            cardTitle: 'Marketing with AI', 
            videoDescription: 'AI Marketing Demo: Content generation flow',
            question: 'Overwhelmed by content creation and complex campaign management?', 
            answer: 'Your AI Marketing Agent creates engaging content, optimizes campaigns, and delivers ROI insights automatically.',
            iconColor: Color(0xff2B7FFF), 
            buttonColor: Color(0xFF155DFC), 
            buttonTitle: 'Explore Marketing with AI', 
            featureIcons: [
              'assets/Icons/mkt1.svg',
              'assets/Icons/mkt2.svg',
              'assets/Icons/mkt3.svg',
              'assets/Icons/mkt4.svg',
              'assets/Icons/mkt5.svg',
              'assets/Icons/mkt6.svg',
            ],
            featureTitles: [
              'AI-powered content creation for all the channels',
              'Real-time campaign optimization & adjustments',
              'Comprehensive ROI analytics & performance reports',
              'Precision audience targeting & smart segmentation',
              'Automated social media management & posting',
              '24/7 campaign monitoring & instant notifications',
            ],
          ),
          SizedBox(height: 20),
          GeneralCard(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF00C950),
                Color(0xFF00A63E),
                Color(0xFF009966),
              ],
              stops: [0.0, 0.5, 1.0],
            ), 
            topIconPath: 'assets/icons/csrLogo.svg', 
            cardTitle: 'CSR with AI', 
            videoDescription: 'AI CSR Demo: Multi-language support',
            question: 'Can\'t afford 24/7 support but customers expect instant responses?', 
            answer: 'Your AI Customer Service Agent handles inquiries instantly in multiple languages, escalating only when needed.',
            iconColor: Color(0xff00C950), 
            buttonColor: Color(0xFF155DFC), 
            buttonTitle: 'Explore CSR with AI', 
            featureIcons: [
              'assets/Icons/csr1.svg',
              'assets/Icons/csr2.svg',
              'assets/Icons/csr3.svg',
              'assets/Icons/csr4.svg',
              'assets/Icons/csr5.svg',
              'assets/Icons/csr6.svg',
            ],
            featureTitles: [
              'Round-the-clock multilingual support coverage',
              'Real-time sentiment analysis & customer insights',
              'Seamless human hand-off when expertise is needed',
              'Intelligent ticket routing & priority assignment',
              'Customer satisfaction tracking & detailed reports',
              'Instant response times & automated resolutions',
            ],
          ),
          SizedBox(height: 16),
        ],
      )
    : ResponsiveUtils.isTablet(context)
        ? Column(
            children: [
              SizedBox(height: 16),
              // ✅ TABLET LAYOUT: First row with 2 cards
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.rw(1.5)),
                      child: GeneralCard(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFF6339A),
                            Color(0xFFE60076),
                            Color(0xFF9810FA),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ), 
                        topIconPath: 'assets/icons/target.svg', 
                        cardTitle: 'Sales with AI', 
                        videoDescription: 'AI Sales Demo: Lead qualification in',
                        question: 'Struggling with manual lead follow-ups and countless lost opportunities?', 
                        answer: 'Your AI Sales Agent works 24/7 to qualify leads, book meetings, and close the deals while you sleep.',
                        iconColor: Colors.pink, 
                        buttonColor: Color(0xFF155DFC), 
                        buttonTitle: 'Explore Sales with AI', 
                        featureIcons: [
                          'assets/Icons/outreach.svg',
                          'assets/Icons/crm.svg',
                          'assets/Icons/schedule.svg',
                          'assets/Icons/lead.svg',
                          'assets/Icons/analytics.svg',
                          'assets/Icons/scoring.svg',
                        ],
                        featureTitles: [
                          'Automated lead generation & qualification workflows',
                          'Personalized outreach campaigns at massive scale',
                          'Instant meeting scheduling & intelligent follow-ups',
                          'Smart CRM integration  &  real-time data sync',
                          'Real-time pipeline analytics & sales forecasting',
                          'AI-powered lead scoring & priority management',
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.rw(1.5)),
                      child: GeneralCard(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF2B7FFF),
                            Color(0xFF155DFC),
                            Color(0xFF0092B8),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ), 
                        topIconPath: 'assets/icons/mktLogo.svg', 
                        cardTitle: 'Marketing with AI', 
                        videoDescription: 'AI Marketing Demo: Content generation flow',
                        question: 'Overwhelmed by content creation and complex campaign management?', 
                        answer: 'Your AI Marketing Agent creates engaging content, optimizes campaigns, and delivers ROI insights automatically.',
                        iconColor: Color(0xff2B7FFF), 
                        buttonColor: Color(0xFF155DFC), 
                        buttonTitle: 'Explore Marketing with AI', 
                        featureIcons: [
                          'assets/Icons/mkt1.svg',
                          'assets/Icons/mkt2.svg',
                          'assets/Icons/mkt3.svg',
                          'assets/Icons/mkt4.svg',
                          'assets/Icons/mkt5.svg',
                          'assets/Icons/mkt6.svg',
                        ],
                        featureTitles: [
                          'AI-powered content creation for all the channels',
                          'Real-time campaign optimization & adjustments',
                          'Comprehensive ROI analytics & performance reports',
                          'Precision audience targeting & smart segmentation',
                          'Automated social media management & posting',
                          '24/7 campaign monitoring & instant notifications',
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // ✅ TABLET LAYOUT: Third card shifted down
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.rw(1.5)),
                child: GeneralCard(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF00C950),
                      Color(0xFF00A63E),
                      Color(0xFF009966),
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ), 
                  topIconPath: 'assets/icons/csrLogo.svg', 
                  cardTitle: 'CSR with AI', 
                  videoDescription: 'AI CSR Demo: Multi-language support',
                  question: 'Can\'t afford 24/7 support but customers expect instant responses?', 
                  answer: 'Your AI Customer Service Agent handles inquiries instantly in multiple languages, escalating only when needed.',
                  iconColor: Color(0xff00C950), 
                  buttonColor: Color(0xFF155DFC), 
                  buttonTitle: 'Explore CSR with AI', 
                  featureIcons: [
                    'assets/Icons/csr1.svg',
                    'assets/Icons/csr2.svg',
                    'assets/Icons/csr3.svg',
                    'assets/Icons/csr4.svg',
                    'assets/Icons/csr5.svg',
                    'assets/Icons/csr6.svg',
                  ],
                  featureTitles: [
                    'Round-the-clock multilingual support coverage',
                    'Real-time sentiment analysis & customer insights',
                    'Seamless human hand-off when expertise is needed',
                    'Intelligent ticket routing & priority assignment',
                    'Customer satisfaction tracking & detailed reports',
                    'Instant response times & automated resolutions',
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          )
        : Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.rw(5)),
                  child: GeneralCard(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFF6339A),
                    Color(0xFFE60076),
                    Color(0xFF9810FA),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ), 
                topIconPath: 'assets/icons/target.svg', 
                cardTitle: 'Sales with AI', 
                videoDescription: 'AI Sales Demo: Lead qualification in',
                question: 'Struggling with manual lead follow-ups and countless lost opportunities?', 
                answer: 'Your AI Sales Agent works 24/7 to qualify leads, book meetings, and close the deals while you sleep.',
                iconColor: Colors.pink, 
                buttonColor: Color(0xFF155DFC), 
                buttonTitle: 'Explore Sales with AI', 
                featureIcons: [
                  'assets/Icons/outreach.svg',
                  'assets/Icons/crm.svg',
                  'assets/Icons/schedule.svg',
                  'assets/Icons/lead.svg',
                  'assets/Icons/analytics.svg',
                  'assets/Icons/scoring.svg',
                ],
                featureTitles: [
                  'Automated lead generation & qualification workflows',
                  'Personalized outreach campaigns at massive scale',
                  'Instant meeting scheduling & intelligent follow-ups',
                  'Smart CRM integration  &  real-time data sync',
                  'Real-time pipeline analytics & sales forecasting',
                  'AI-powered lead scoring & priority management',
                ],
              ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.rw(5)),
                  child: GeneralCard(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2B7FFF),
                    Color(0xFF155DFC),
                    Color(0xFF0092B8),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ), 
                topIconPath: 'assets/icons/mktLogo.svg', 
                cardTitle: 'Marketing with AI', 
                videoDescription: 'AI Marketing Demo: Content generation flow',
                question: 'Overwhelmed by content creation and complex campaign management?', 
                answer: 'Your AI Marketing Agent creates engaging content, optimizes campaigns, and delivers ROI insights automatically.',
                iconColor: Color(0xff2B7FFF), 
                buttonColor: Color(0xFF155DFC), 
                buttonTitle: 'Explore Marketing with AI', 
                featureIcons: [
                  'assets/Icons/mkt1.svg',
                  'assets/Icons/mkt2.svg',
                  'assets/Icons/mkt3.svg',
                  'assets/Icons/mkt4.svg',
                  'assets/Icons/mkt5.svg',
                  'assets/Icons/mkt6.svg',
                ],
                featureTitles: [
                  'AI-powered content creation for all the channels',
                  'Real-time campaign optimization & adjustments',
                  'Comprehensive ROI analytics & performance reports',
                  'Precision audience targeting & smart segmentation',
                  'Automated social media management & posting',
                  '24/7 campaign monitoring & instant notifications',
                ],
              )
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.rw(5)),
                  child: GeneralCard(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF00C950),
                    Color(0xFF00A63E),
                    Color(0xFF009966),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ), 
                topIconPath: 'assets/icons/csrLogo.svg', 
                cardTitle: 'CSR with AI', 
                videoDescription: 'AI CSR Demo: Multi-language support',
                question: 'Can\'t afford 24/7 support but customers expect instant responses?', 
                answer: 'Your AI Customer Service Agent handles inquiries instantly in multiple languages, escalating only when needed.',
                iconColor: Color(0xff00C950), 
                buttonColor: Color(0xFF155DFC), 
                buttonTitle: 'Explore CSR with AI', 
                featureIcons: [
                  'assets/Icons/csr1.svg',
                  'assets/Icons/csr2.svg',
                  'assets/Icons/csr3.svg',
                  'assets/Icons/csr4.svg',
                  'assets/Icons/csr5.svg',
                  'assets/Icons/csr6.svg',
                ],
                featureTitles: [
                  'Round-the-clock multilingual support coverage',
                  'Real-time sentiment analysis & customer insights',
                  'Seamless human hand-off when expertise is needed',
                  'Intelligent ticket routing & priority assignment',
                  'Customer satisfaction tracking & detailed reports',
                  'Instant response times & automated resolutions',
                ],
              ),
                ),
              ),
            ],
          ),
        SizedBox(height: 40),
        BCard(),
        // HomeFeaturesSection(cards: cards),
        // const CompanySection(),
        SizedBox(height: 40),
//         SizedBox(
//   width: 320,
//   height: 420,
//   child: TeamMemberFlipCard(
//     imagePath: 'https://picsum.photos/id/1005/300/300',
//     name: 'Alfonso Suarez', 
//     title: 'Chief Technology Officer', 
//     description: 'Architecting innovative AI systems and leading our technical excellence. Expert in machine learning, cloud infrastructure, and scalable enterprise solutions.',
//   ),
// ),
     SizedBox(height: 40),
     FinalSections(),
     SizedBox(height: 40),

    const ContentSection(),
        // const NewsSection(),
        const NewsletterSection(),
        const NewsRelease(),
        const FaqSection(
          title: 'FAQ',
          subtitle:
              'Find answers to common questions about our AI services and solutions',
        ),
        const SizedBox(height: 10),
        CtaButton(
          title: 'View All FAQs', 
          onPressed: () { 
              context.go('/faq');
           },
          gradient: const LinearGradient(
            colors: [
              Color(0xFF155DFC),
              Color(0xFF1447E6),
            ],
            stops: [0.0, 1.0],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

