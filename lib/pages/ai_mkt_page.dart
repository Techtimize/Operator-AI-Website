import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../widgets/feature_card.dart';
import '../widgets/media_card.dart';
import '../widgets/kpi_card.dart';
import '../widgets/chart_card.dart';
import '../widgets/metric_card.dart';

class AiMktPageContent extends StatelessWidget {
  const AiMktPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth <= 1024;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : (isTablet ? 24 : 32),
            vertical: isMobile ? 24 : 40,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1232),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: isMobile ? 32 : 48,
                        fontWeight: FontWeight.bold,
                      ),
                      children: const [
                        TextSpan(
                          text: 'AI ',
                          style: TextStyle(color: Color(0xFFE91E63)),
                        ),
                        TextSpan(
                          text: 'MKT',
                          style: TextStyle(color: Color(0xFF424242)),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  _buildVideoPlaceholder(),
                  const SizedBox(height: 16),
                  _buildMarketingFeaturesSection(isMobile, isTablet),
                ],
              ),
            ),
          ),
        ),
        _buildMktStatisticsBanner(isMobile),
        // Testimonials Section container (after stats)
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : (isTablet ? 24 : 32),
            vertical: isMobile ? 48 : 64,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1232),
              child: _buildTestimonialsSection(isMobile, isTablet),
            ),
          ),
        ),
        // Marketing Dashboard Section
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : (isTablet ? 24 : 32),
            vertical: isMobile ? 48 : 64,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1232),
              child: _buildDashboardSection(isMobile, isTablet),
            ),
          ),
        ),
        // Full-width CTA (outside constrained container)
        _buildMarketingCtaSection(isMobile, isTablet),
      ],
    );
  }

  Widget _buildVideoPlaceholder() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 896),
      child: AspectRatio(
        aspectRatio: 896 / 504,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.play_arrow,
                size: 40,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMarketingFeaturesSection(bool isMobile, bool isTablet) {
    final features = [
      {
        'icon': Icons.bolt_outlined,
        'title': 'Content Generation',
        'description': 'Create compelling marketing content at scale with AI',
      },
      {
        'icon': Icons.visibility_outlined,
        'title': 'Audience Insights',
        'description': 'Deep customer analysis for targeted campaigns',
      },
      {
        'icon': Icons.show_chart_outlined,
        'title': 'Campaign Optimization',
        'description': 'Real-time optimization for maximum ROI',
      },
      {
        'icon': Icons.bar_chart_outlined,
        'title': 'Performance Analytics',
        'description': 'Advanced metrics and attribution modeling',
      },
      {
        'icon': Icons.person_outline,
        'title': 'Personalization',
        'description': '1:1 personalized experiences for every customer',
      },
      {
        'icon': Icons.autorenew_outlined,
        'title': 'Automation',
        'description': 'Set-and-forget marketing workflows',
      },
    ];

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Column(
      children: [
        SizedBox(height: isMobile ? 24 : 40),
        Text(
          'How AI MKT Works',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E3A8A),
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        Text(
          'End-to-end AI-powered marketing from content to optimization',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            color: const Color(0xFF6B7280),
          ),
        ),
        SizedBox(height: isMobile ? 32 : 48),
        _buildFeaturesGrid(features, crossAxisCount),
      ],
    );
  }

  Widget _buildFeaturesGrid(
    List<Map<String, dynamic>> features,
    int crossAxisCount,
  ) {
    if (crossAxisCount == 1) {
      return Column(
        children: features.asMap().entries.map((entry) {
          final index = entry.key;
          final feature = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FeatureCard(
                icon: feature['icon'] as IconData,
                title: feature['title'] as String,
                description: feature['description'] as String,
              ),
              if (index < features.length - 1) const SizedBox(height: 16),
            ],
          );
        }).toList(),
      );
    }

    final List<Widget> rows = [];
    for (int i = 0; i < features.length; i += crossAxisCount) {
      final List<Widget> rowCards = [];
      for (int j = 0; j < crossAxisCount && (i + j) < features.length; j++) {
        if (j > 0) {
          rowCards.add(const SizedBox(width: 16));
        }
        final feature = features[i + j];
        rowCards.add(
          Expanded(
            child: FeatureCard(
              icon: feature['icon'] as IconData,
              title: feature['title'] as String,
              description: feature['description'] as String,
            ),
          ),
        );
      }
      if (i > 0) {
        rows.add(const SizedBox(height: 16));
      }
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rowCards,
          ),
        ),
      );
    }

    return Column(children: rows);
  }

  Widget _buildMktStatisticsBanner(bool isMobile) {
    final stats = [
      {'value': '300%', 'label': 'Content production increase'},
      {'value': '150%', 'label': 'Campaign performance boost'},
      {'value': '65%', 'label': 'Time savings'},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 0,
        vertical: isMobile ? 24 : 40,
      ),
      decoration: const BoxDecoration(color: Color(0xFF7C3AED)),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < stats.length; i++) ...[
                  _buildMktStatItem(
                    stats[i]['value'] as String,
                    stats[i]['label'] as String,
                    isMobile,
                  ),
                  if (i < stats.length - 1) const SizedBox(height: 16),
                ],
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: stats.map((stat) {
                return _buildMktStatItem(
                  stat['value'] as String,
                  stat['label'] as String,
                  isMobile,
                );
              }).toList(),
            ),
    );
  }

  Widget _buildMktStatItem(String value, String label, bool isMobile) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: isMobile ? 4 : 8),
        Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: Colors.white.withValues(alpha: 0.9),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Testimonials (copied from AI Sales page, adapted for this page)
  Widget _buildTestimonialsSection(bool isMobile, bool isTablet) {
    final testimonials = [
      {'category': 'Real Estate', 'name': 'Sarah Johnson'},
      {'category': 'Technology', 'name': 'Mark Thompson'},
      {'category': 'E-commerce', 'name': 'Alex Chen'},
      {'category': 'Manufacturing', 'name': 'David Rodriguez'},
      {'category': 'Financial Services', 'name': 'Jennifer Kim'},
      {'category': 'Consulting', 'name': 'Michael Park'},
    ];

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Column(
      children: [
        const Text(
          'TESTIMONIALS',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: isMobile ? 32 : 48),
        _buildTestimonialsGrid(testimonials, crossAxisCount),
      ],
    );
  }

  Widget _buildTestimonialsGrid(
    List<Map<String, String>> testimonials,
    int crossAxisCount,
  ) {
    if (crossAxisCount == 1) {
      return Column(
        children: testimonials.asMap().entries.map((entry) {
          final index = entry.key;
          final testimonial = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MediaCard(
                title: testimonial['category']!,
                description: testimonial['name']!,
              ),
              if (index < testimonials.length - 1) const SizedBox(height: 16),
            ],
          );
        }).toList(),
      );
    }

    final List<Widget> rows = [];
    for (int i = 0; i < testimonials.length; i += crossAxisCount) {
      final List<Widget> rowCards = [];
      for (
        int j = 0;
        j < crossAxisCount && (i + j) < testimonials.length;
        j++
      ) {
        if (j > 0) {
          rowCards.add(const SizedBox(width: 16));
        }
        final testimonial = testimonials[i + j];
        rowCards.add(
          Expanded(
            child: MediaCard(
              title: testimonial['category']!,
              description: testimonial['name']!,
            ),
          ),
        );
      }
      if (i > 0) {
        rows.add(const SizedBox(height: 16));
      }
      rows.add(
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: rowCards),
      );
    }

    return Column(children: rows);
  }

  // Marketing Dashboard Section (separate charts for AI MKT)
  Widget _buildDashboardSection(bool isMobile, bool isTablet) {
    return Column(
      children: [
        // Title Section
        const Text(
          'YOU CONTROL THE AI',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7C3AED),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'LIVE DASHBOARD // DATA VISUALIZATION',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Color(0xFF6B7280)),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.circle, color: Color(0xFF10B981), size: 8),
            SizedBox(width: 4),
            Text(
              'Live Data',
              style: TextStyle(color: Color(0xFF10B981), fontSize: 14),
            ),
            SizedBox(width: 4),
            Text('•'),
            SizedBox(width: 4),
            Text('Updated every 30 seconds', style: TextStyle(fontSize: 14)),
          ],
        ),
        SizedBox(height: isMobile ? 32 : 48),
        // KPI Cards Row
        _buildKpiCards(isMobile, isTablet),
        SizedBox(height: isMobile ? 24 : 32),
        // Charts Row (separate for MKT)
        _buildChartsRow(isMobile, isTablet),
        SizedBox(height: isMobile ? 24 : 32),
        // Metric Cards Row
        _buildMetricCards(isMobile, isTablet),
        SizedBox(height: isMobile ? 48 : 80),
        _buildUseCasesSection(isMobile, isTablet),
        SizedBox(height: isMobile ? 48 : 80),
        // Pricing Section
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : (isTablet ? 24 : 32),
            vertical: isMobile ? 48 : 64,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1232),
              child: _buildPricingSection(isMobile, isTablet),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKpiCards(bool isMobile, bool isTablet) {
    final kpis = [
      {
        'icon': Icons.visibility,
        'title': 'Content Posted',
        'value': '847',
        'trend': '+32%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.play_circle_outline,
        'title': 'Videos Created',
        'value': '234',
        'trend': '+28%',
        'color': 0xFF7C3AED,
      },
      {
        'icon': Icons.image_outlined,
        'title': 'Images Generated',
        'value': '1,456',
        'trend': '+45%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.trending_up,
        'title': 'Total Engagement',
        'value': '145.7K',
        'trend': '+67%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.message_outlined,
        'title': 'Messages Received',
        'value': '3,821',
        'trend': '+25%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.podcasts_outlined,
        'title': 'Marketing Leads',
        'value': '892',
        'trend': '+38%',
        'color': 0xFF1E90FF,
      },
    ];

    if (isMobile) {
      return Column(
        children: kpis
            .map(
              (kpi) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: KpiCard(
                  icon: kpi['icon'] as IconData,
                  title: kpi['title'] as String,
                  value: kpi['value'] as String,
                  trend: kpi['trend'] as String,
                  iconColor: Color(kpi['color'] as int),
                ),
              ),
            )
            .toList(),
      );
    }

    final itemsPerRow = isTablet ? 3 : 6;
    final List<Widget> rows = [];
    for (int i = 0; i < kpis.length; i += itemsPerRow) {
      final List<Widget> rowCards = [];
      for (int j = 0; j < itemsPerRow && (i + j) < kpis.length; j++) {
        if (j > 0) rowCards.add(const SizedBox(width: 16));
        final kpi = kpis[i + j];
        rowCards.add(
          Expanded(
            child: KpiCard(
              icon: kpi['icon'] as IconData,
              title: kpi['title'] as String,
              value: kpi['value'] as String,
              trend: kpi['trend'] as String,
              iconColor: Color(kpi['color'] as int),
            ),
          ),
        );
      }
      if (i > 0) rows.add(const SizedBox(height: 16));
      rows.add(
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: rowCards),
      );
    }
    return Column(children: rows);
  }

  Widget _buildMarketingCtaSection(bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (isTablet ? 24 : 32),
        vertical: isMobile ? 40 : 56,
      ),
      decoration: const BoxDecoration(color: Color(0xFF7C3AED)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Ready to Transform Your Marketing?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Join thousands of marketers already using AI to drive better results',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          SizedBox(height: isMobile ? 16 : 24),
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCtaPrimaryButton(fullWidth: true),
                const SizedBox(height: 12),
                _buildCtaSecondaryButton(fullWidth: true),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCtaPrimaryButton(),
                const SizedBox(width: 16),
                _buildCtaSecondaryButton(),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCtaPrimaryButton({bool fullWidth = false}) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF7C3AED),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          elevation: 0,
        ),
        child: const Text('Start Free Trial'),
      ),
    );
  }

  Widget _buildCtaSecondaryButton({bool fullWidth = false}) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        child: const Text('Schedule Demo'),
      ),
    );
  }

  Widget _buildChartsRow(bool isMobile, bool isTablet) {
    final charts = [
      ChartCard(
        title: 'Performance Trends',
        chart: const _MktPerformanceChart(),
        height: 302,
      ),
      ChartCard(
        title: 'Distribution Analytics',
        chart: const _DistributionAnalyticsPie(),
        height: 302,
      ),
    ];

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < charts.length; i++) ...[
            charts[i],
            if (i < charts.length - 1) const SizedBox(height: 16),
          ],
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: charts[0]),
        const SizedBox(width: 16),
        Expanded(child: charts[1]),
      ],
    );
  }

  Widget _buildMetricCards(bool isMobile, bool isTablet) {
    final metrics = [
      {
        'title': 'Conversion Rate',
        'percentage': '+5.2%',
        'desc': '78% vs last month',
        'progress': 0.78,
        'color': 0xFF10B981,
      },
      {
        'title': 'Response Rate',
        'percentage': '+8.1%',
        'desc': '85% avg response',
        'progress': 0.85,
        'color': 0xFF1E90FF,
      },
      {
        'title': 'Success Rate',
        'percentage': '+12%',
        'desc': '92% success rate',
        'progress': 0.92,
        'color': 0xFF7C3AED,
      },
      {
        'title': 'AI Efficiency',
        'percentage': '+15%',
        'desc': '96% automation',
        'progress': 0.96,
        'color': 0xFFFF6600,
      },
    ];

    if (isMobile) {
      return Column(
        children: metrics
            .map(
              (metric) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: MetricCard(
                  title: metric['title'] as String,
                  percentage: metric['percentage'] as String,
                  description: metric['desc'] as String,
                  progress: metric['progress'] as double,
                  indicatorColor: Color(metric['color'] as int),
                ),
              ),
            )
            .toList(),
      );
    }

    final List<Widget> widgets = [];
    metrics.asMap().entries.forEach((entry) {
      final index = entry.key;
      final metric = entry.value;

      if (index > 0) {
        widgets.add(const SizedBox(width: 16));
      }

      widgets.add(
        Expanded(
          child: MetricCard(
            title: metric['title'] as String,
            percentage: metric['percentage'] as String,
            description: metric['desc'] as String,
            progress: metric['progress'] as double,
            indicatorColor: Color(metric['color'] as int),
          ),
        ),
      );
    });

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  Widget _buildUseCasesSection(bool isMobile, bool isTablet) {
    final useCases = [
      {
        'title': 'Lead Generation',
        'description': 'Automated prospect identification and qualification',
      },
      {
        'title': 'Sales Forecasting',
        'description': 'Predictive analytics for accurate revenue projections',
      },
      {
        'title': 'Customer Segmentation',
        'description': 'AI-powered targeting for personalized sales approaches',
      },
      {
        'title': 'Deal Optimization',
        'description': 'Smart pricing and negotiation strategies',
      },
      {
        'title': 'Sales Coaching',
        'description': 'AI-driven training and performance improvement',
      },
      {
        'title': 'Account Management',
        'description': 'Comprehensive customer lifecycle management',
      },
    ];

    return Column(
      children: [
        const Text(
          'Use Cases',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: isMobile ? 32 : 48),
        _buildUseCasesGrid(useCases, isMobile, isTablet),
      ],
    );
  }

  Widget _buildUseCasesGrid(
    List<Map<String, dynamic>> useCases,
    bool isMobile,
    bool isTablet,
  ) {
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    if (crossAxisCount == 1) {
      return Column(
        children: useCases.asMap().entries.map((entry) {
          final index = entry.key;
          final useCase = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MediaCard(
                title: useCase['title'] as String,
                description: useCase['description'] as String,
              ),
              if (index < useCases.length - 1) const SizedBox(height: 16),
            ],
          );
        }).toList(),
      );
    }

    final List<Widget> rows = [];
    for (int i = 0; i < useCases.length; i += crossAxisCount) {
      final List<Widget> rowCards = [];
      for (int j = 0; j < crossAxisCount && (i + j) < useCases.length; j++) {
        if (j > 0) {
          rowCards.add(const SizedBox(width: 16));
        }
        final useCase = useCases[i + j];
        rowCards.add(
          Expanded(
            child: MediaCard(
              title: useCase['title'] as String,
              description: useCase['description'] as String,
            ),
          ),
        );
      }
      if (i > 0) {
        rows.add(const SizedBox(height: 16));
      }
      rows.add(
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: rowCards),
      );
    }

    return Column(children: rows);
  }

  Widget _buildPricingSection(bool isMobile, bool isTablet) {
    final List<Map<String, dynamic>> plans = [
      {
        'title': 'Starter',
        'price': '79',
        'period': '/month',
        'subtitle': 'Perfect for small marketing teams',
        'features': [
          'Up to 10 campaigns',
          'Basic content generation',
          'Social media automation',
          'Email marketing',
          'Basic analytics',
        ],
        'cta': 'Get Started',
        'highlight': false,
      },
      {
        'title': 'Professional',
        'price': '199',
        'period': '/month',
        'subtitle': 'Ideal for growing marketing departments',
        'features': [
          'Unlimited campaigns',
          'Advanced AI content',
          'Multi-channel automation',
          'Audience segmentation',
          'Advanced analytics',
          'A/B testing',
        ],
        'cta': 'Get Started',
        'highlight': true,
      },
      {
        'title': 'Enterprise',
        'price': '499',
        'period': '/month',
        'subtitle': 'For large marketing organizations',
        'features': [
          'Custom AI models',
          'Advanced personalization',
          'Custom integrations',
          'Dedicated support',
          'Advanced security',
          'White-label options',
        ],
        'cta': 'Get Started',
        'highlight': false,
      },
    ];

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Column(
      children: [
        const Text(
          'Choose Your Plan',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: isMobile ? 24 : 32),
        _buildPricingGrid(plans, crossAxisCount, isMobile),
      ],
    );
  }

  Widget _buildPricingGrid(
    List<Map<String, dynamic>> plans,
    int crossAxisCount,
    bool isMobile,
  ) {
    if (crossAxisCount == 1) {
      return Column(
        children: plans.asMap().entries.map((entry) {
          final index = entry.key;
          final plan = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPricingCard(plan, isMobile),
              if (index < plans.length - 1) const SizedBox(height: 24),
            ],
          );
        }).toList(),
      );
    }

    final List<Widget> rows = [];
    for (int i = 0; i < plans.length; i += crossAxisCount) {
      final List<Widget> rowCards = [];
      for (int j = 0; j < crossAxisCount && (i + j) < plans.length; j++) {
        if (j > 0) rowCards.add(const SizedBox(width: 24));
        rowCards.add(
          Expanded(child: _buildPricingCard(plans[i + j], isMobile)),
        );
      }
      if (i > 0) rows.add(const SizedBox(height: 24));
      rows.add(
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: rowCards),
      );
    }
    return Column(children: rows);
  }

  Widget _buildPricingCard(Map<String, dynamic> plan, bool isMobile) {
    final bool highlight = plan['highlight'] as bool;
    final Color accent = const Color(0xFF7C3AED);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: highlight ? accent : const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (highlight)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Center(
                child: Text(
                  'Most Popular',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          if (highlight) const SizedBox(height: 16),
          Text(
            plan['title'] as String,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                ' ${plan['price'] as String}'.trim(),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                plan['period'] as String,
                style: const TextStyle(color: Color(0xFF6B7280)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            plan['subtitle'] as String,
            style: const TextStyle(color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 16),
          ...((plan['features'] as List<String>).map((feature) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF10B981),
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(feature, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            );
          })),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: highlight ? accent : const Color(0xFF0B1020),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: Text(plan['cta'] as String),
            ),
          ),
        ],
      ),
    );
  }
}

class _MktPerformanceChart extends StatefulWidget {
  const _MktPerformanceChart();

  @override
  State<_MktPerformanceChart> createState() => _MktPerformanceChartState();
}

class _MktPerformanceChartState extends State<_MktPerformanceChart> {
  // Data used in the mock dashboard
  final List<double> engagement = [45000, 38000, 28000, 22000, 14000];
  final List<int> posts = [60, 52, 48, 45, 26];
  final List<String> platforms = const [
    'Instagram',
    'TikTok',
    'LinkedIn',
    'YouTube',
    'Facebook',
  ];

  // Padding must match painter's values to keep coordinates consistent
  static const double _leftPadding = 50;
  static const double _rightPadding = 20;
  static const double _topPadding = 10;
  static const double _bottomPadding = 40;

  int? _hoverIndex;
  Offset? _hoverPoint; // Canvas coordinates for tooltip position

  void _updateHover(Offset localPosition, Size size) {
    final double chartWidth = size.width - _leftPadding - _rightPadding;
    final double chartHeight = size.height - _topPadding - _bottomPadding;
    if (chartWidth <= 0 || chartHeight <= 0) return;

    final double relativeX = (localPosition.dx - _leftPadding).clamp(
      0,
      chartWidth,
    );
    final int idx = ((relativeX / chartWidth) * (engagement.length - 1))
        .round();

    // Compute the point location for tooltip
    const double minY = 0;
    const double maxY = 60000;
    final double x =
        _leftPadding + (idx / (engagement.length - 1)) * chartWidth;
    final double normalizedY = (engagement[idx] - minY) / (maxY - minY);
    final double y = _topPadding + chartHeight - (normalizedY * chartHeight);

    setState(() {
      _hoverIndex = idx;
      _hoverPoint = Offset(x, y);
    });
  }

  void _clearHover() {
    setState(() {
      _hoverIndex = null;
      _hoverPoint = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size size = Size(constraints.maxWidth, constraints.maxHeight);
        return MouseRegion(
          onHover: (evt) => _updateHover(evt.localPosition, size),
          onExit: (_) => _clearHover(),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (details) => _updateHover(details.localPosition, size),
            onTapCancel: _clearHover,
            child: Stack(
              children: [
                // Chart
                Positioned.fill(
                  child: CustomPaint(
                    painter: _MktLineChartPainter(selectedIndex: _hoverIndex),
                  ),
                ),
                if (_hoverIndex != null && _hoverPoint != null)
                  Positioned(
                    left: (_hoverPoint!.dx + 10).clamp(0, size.width - 180),
                    top: (_hoverPoint!.dy - 70).clamp(0, size.height - 80),
                    child: _TooltipCard(
                      title: platforms[_hoverIndex!],
                      engagement: engagement[_hoverIndex!].toInt(),
                      posts: posts[_hoverIndex!],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MktLineChartPainter extends CustomPainter {
  _MktLineChartPainter({this.selectedIndex});

  final int? selectedIndex;

  final List<double> blueLineData = [45000, 38000, 28000, 22000, 14000];
  final List<double> greenLineData = [0, 0, 0, 0, 0];
  final List<String> platforms = [
    'Instagram',
    'TikTok',
    'LinkedIn',
    'YouTube',
    'Facebook',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFFE5E7EB);

    final labelStyle = const TextStyle(fontSize: 12, color: Color(0xFF6B7280));

    const double leftPadding = 50;
    const double rightPadding = 20;
    const double topPadding = 10;
    const double bottomPadding = 40;

    final double chartWidth = size.width - leftPadding - rightPadding;
    final double chartHeight = size.height - topPadding - bottomPadding;

    final double minY = 0;
    final double maxY = 60000;

    // Horizontal grid and Y labels (0..60000 step 15000)
    for (int i = 0; i <= 4; i++) {
      final yValue = i * 15000;
      final normalizedY = (yValue - minY) / (maxY - minY);
      final y = topPadding + chartHeight - (normalizedY * chartHeight);

      canvas.drawLine(
        Offset(leftPadding, y),
        Offset(size.width - rightPadding, y),
        gridPaint,
      );

      final tp = TextPainter(
        text: TextSpan(text: yValue.toString(), style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(leftPadding - tp.width - 10, y - tp.height / 2));
    }

    // Vertical grid and X labels
    for (int i = 0; i < platforms.length; i++) {
      final x = leftPadding + (i / (platforms.length - 1)) * chartWidth;
      canvas.drawLine(
        Offset(x, topPadding),
        Offset(x, size.height - bottomPadding),
        gridPaint,
      );

      final tp = TextPainter(
        text: TextSpan(text: platforms[i], style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(x - tp.width / 2, size.height - bottomPadding + 5),
      );
    }

    // Draw green baseline (zeros)
    _drawLine(
      canvas,
      greenLineData,
      const Color(0xFF10B981),
      leftPadding,
      topPadding,
      chartWidth,
      chartHeight,
      minY,
      maxY,
    );

    // Draw blue line with markers
    _drawLine(
      canvas,
      blueLineData,
      const Color(0xFF3B82F6),
      leftPadding,
      topPadding,
      chartWidth,
      chartHeight,
      minY,
      maxY,
    );

    // Highlight selected point if any
    if (selectedIndex != null) {
      final int i = selectedIndex!.clamp(0, blueLineData.length - 1);
      final double x =
          leftPadding + (i / (blueLineData.length - 1)) * chartWidth;
      final double normalizedY = (blueLineData[i] - minY) / (maxY - minY);
      final double y = topPadding + chartHeight - (normalizedY * chartHeight);

      final Paint halo = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..color = const Color(0xFF3B82F6).withOpacity(0.2);
      final Paint center = Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF3B82F6);
      canvas.drawCircle(Offset(x, y), 10, halo);
      canvas.drawCircle(Offset(x, y), 5, center);
    }
  }

  void _drawLine(
    Canvas canvas,
    List<double> data,
    Color color,
    double leftPadding,
    double topPadding,
    double chartWidth,
    double chartHeight,
    double minY,
    double maxY,
  ) {
    final path = Path();
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = color;

    final pointStrokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white;

    final pointFillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    for (int i = 0; i < data.length; i++) {
      final x = leftPadding + (i / (data.length - 1)) * chartWidth;
      final normalizedY = (data[i] - minY) / (maxY - minY);
      final y = topPadding + chartHeight - (normalizedY * chartHeight);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      canvas.drawCircle(Offset(x, y), 6, pointStrokePaint);
      canvas.drawCircle(Offset(x, y), 4, pointFillPaint);
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _MktLineChartPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex;
  }
}

class _TooltipCard extends StatelessWidget {
  const _TooltipCard({
    required this.title,
    required this.engagement,
    required this.posts,
  });

  final String title;
  final int engagement;
  final int posts;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Row(
            children: const [
              Icon(Icons.show_chart, size: 14, color: Color(0xFF3B82F6)),
              SizedBox(width: 6),
              Text(
                'engagement :',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
            ],
          ),
          Text(
            engagement.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Row(
            children: const [
              Icon(Icons.article_outlined, size: 14, color: Color(0xFF10B981)),
              SizedBox(width: 6),
              Text(
                'posts :',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
            ],
          ),
          Text(
            posts.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// ===== Distribution Analytics (Pie Chart) =====
class _DistributionAnalyticsPie extends StatefulWidget {
  const _DistributionAnalyticsPie();

  @override
  State<_DistributionAnalyticsPie> createState() =>
      _DistributionAnalyticsPieState();
}

class _DistributionAnalyticsPieState extends State<_DistributionAnalyticsPie> {
  // Data and labels matching the visual
  final List<double> parts = const [32, 8, 15, 19, 26];
  final List<String> labels = const [
    'Instagram', // 32%
    'YouTube', // 8%
    'LinkedIn', // 15%
    'Facebook', // 19%
    'TikTok', // 26%
  ];

  static const double radiusFactor = 0.35; // slightly larger within 302px card
  int? _hoverIndex;
  Offset? _hoverPos;

  void _handleHover(Offset localPos, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 10);
    final radius = math.min(size.width, size.height) * radiusFactor;

    final Offset v = localPos - center;
    final double distance = v.distance;
    if (distance < radius * 0.55 || distance > radius + 28) {
      // Ignore hover too close to center or far outside pie
      if (_hoverIndex != null) setState(() => _hoverIndex = null);
      return;
    }

    double angle = math.atan2(v.dy, v.dx); // [-pi, pi]
    // Normalize to [0, 2pi) with same start as painter (-pi/2 at top)
    angle -= (-math.pi / 2);
    while (angle < 0) angle += 2 * math.pi;
    while (angle >= 2 * math.pi) angle -= 2 * math.pi;

    double acc = 0;
    int found = 0;
    for (int i = 0; i < parts.length; i++) {
      final sweep = (parts[i] / 100) * 2 * math.pi;
      if (angle >= acc && angle < acc + sweep) {
        found = i;
        break;
      }
      acc += sweep;
    }

    setState(() {
      _hoverIndex = found;
      _hoverPos = localPos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return MouseRegion(
          onHover: (e) => _handleHover(e.localPosition, size),
          onExit: (_) => setState(() => _hoverIndex = null),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (e) => _handleHover(e.localPosition, size),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _PiePainter(selectedIndex: _hoverIndex),
                  ),
                ),
                if (_hoverIndex != null && _hoverPos != null)
                  Positioned(
                    left: (_hoverPos!.dx - 55).clamp(0, size.width - 110),
                    top: (_hoverPos!.dy - 22).clamp(0, size.height - 44),
                    child: _CenterTooltip(
                      text:
                          '${labels[_hoverIndex!]} : ${parts[_hoverIndex!].toStringAsFixed(0)}',
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PiePainter extends CustomPainter {
  _PiePainter({this.selectedIndex});

  final int? selectedIndex;
  // Percentages from the mock: 32, 8, 15, 19, 26 (sum 100)
  final List<double> parts = const [32, 8, 15, 19, 26];
  final List<Color> colors = const [
    Color(0xFFE35174), // pink 32%
    Color(0xFF3B82F6), // blue 8%
    Color(0xFFEF4444), // red 15%
    Color(0xFF0EA5E9), // teal/blue 19%
    Color(0xFF111827), // black 26%
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 10);
    final radius =
        math.min(size.width, size.height) *
        _DistributionAnalyticsPieState.radiusFactor;

    double startRadian = -math.pi / 2;
    for (int i = 0; i < parts.length; i++) {
      final sweepRadian = (parts[i] / 100) * 2 * math.pi;
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = colors[i];
      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, startRadian, sweepRadian, true, paint);

      // Highlight selected slice with thin white stroke and slight ring
      if (selectedIndex == i) {
        final Paint stroke = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Colors.white;
        canvas.drawArc(rect, startRadian, sweepRadian, true, stroke);
      }

      _drawLeaderAndLabel(
        canvas,
        size,
        center,
        radius,
        startRadian,
        sweepRadian,
        parts[i],
        colors[i],
      );
      startRadian += sweepRadian;
    }
  }

  void _drawLeaderAndLabel(
    Canvas canvas,
    Size size,
    Offset center,
    double radius,
    double start,
    double sweep,
    double percent,
    Color color,
  ) {
    final midAngle = start + sweep / 2;
    final startPoint =
        center + Offset(math.cos(midAngle), math.sin(midAngle)) * (radius + 6);
    final endPoint =
        center + Offset(math.cos(midAngle), math.sin(midAngle)) * (radius + 26);

    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = color;

    // radial line
    canvas.drawLine(startPoint, endPoint, linePaint);

    // horizontal tick
    final bool right = math.cos(midAngle) >= 0;
    final tickEnd = endPoint + Offset(right ? 18 : -18, 0);
    canvas.drawLine(endPoint, tickEnd, linePaint);

    // label
    final tp = TextPainter(
      text: TextSpan(
        text: '${percent.toStringAsFixed(0)}%',
        style: TextStyle(
          fontSize: 14,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final labelOffset = Offset(
      right ? tickEnd.dx + 4 : tickEnd.dx - tp.width - 4,
      tickEnd.dy - tp.height / 2,
    );
    tp.paint(canvas, labelOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CenterTooltip extends StatelessWidget {
  const _CenterTooltip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
