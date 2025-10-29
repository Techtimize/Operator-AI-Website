import 'package:flutter/material.dart';
import '../widgets/feature_card.dart';
import '../widgets/media_card.dart';
import '../widgets/kpi_card.dart';
import '../widgets/chart_card.dart';
import '../widgets/metric_card.dart';

class IndustriesPageContent extends StatelessWidget {
  const IndustriesPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth <= 1024;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 32,
            vertical: isMobile ? 24 : 40,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1232),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Heading styled like in ai_sales_page.dart (accent + dark)
                  RichText(
                    textAlign: TextAlign.center,
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
                          text: 'INDUSTRIES',
                          style: TextStyle(color: Color(0xFF424242)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  Text(
                    'Explore how Operator AI transforms industries with tailored AI solutions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 18,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  SizedBox(height: isMobile ? 32 : 48),
                  _buildVideoPlaceholder(isMobile),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  _buildCsrFeaturesSection(isMobile, isTablet),
                  const SizedBox(height: 32),
                  _buildIndustriesListSection(isMobile, isTablet),
                ],
              ),
            ),
          ),
        ),
        _buildIndustriesStatsBanner(isMobile),
        // Testimonials section
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
        // Dashboard section
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
      ],
    );
  }

  Widget _buildVideoPlaceholder(bool isMobile) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 896),
      child: AspectRatio(
        aspectRatio: 896 / 504,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
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

  Widget _buildCsrFeaturesSection(bool isMobile, bool isTablet) {
    final features = [
      {
        'icon': Icons.domain,
        'title': 'Industry-Specific AI',
        'description':
            'Tailored AI solutions for your specific business sector',
      },
      {
        'icon': Icons.badge_outlined,
        'title': 'Sector Expertise',
        'description':
            'Deep understanding of industry workflows and challenges',
      },
      {
        'icon': Icons.trending_up,
        'title': 'Scalable Solutions',
        'description': 'AI that grows with your business across all verticals',
      },
      {
        'icon': Icons.rule,
        'title': 'Compliance Ready',
        'description': 'Industry-standard compliance and regulatory adherence',
      },
      {
        'icon': Icons.security,
        'title': 'Secure Integration',
        'description': 'Enterprise-grade security for sensitive industry data',
      },
      {
        'icon': Icons.support_agent,
        'title': 'Expert Support',
        'description': 'Industry specialists providing dedicated guidance',
      },
    ];

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Column(
      children: [
        SizedBox(height: isMobile ? 24 : 40),
        Text(
          'How AI Works For Industries',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E3A8A),
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        Text(
          'Tailored AI solutions across sectors from intake to resolution',
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
        if (j > 0) rowCards.add(const SizedBox(width: 16));
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
      if (i > 0) rows.add(const SizedBox(height: 16));
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

  Widget _buildIndustriesListSection(bool isMobile, bool isTablet) {
    final industries = [
      {
        'icon': Icons.local_hospital,
        'title': 'Healthcare',
        'description': 'AI for patient care and medical operations',
      },
      {
        'icon': Icons.attach_money,
        'title': 'Finance',
        'description': 'Risk assessment and automated trading',
      },
      {
        'icon': Icons.factory,
        'title': 'Manufacturing',
        'description': 'Predictive maintenance and quality control',
      },
      {
        'icon': Icons.shopping_bag,
        'title': 'Retail',
        'description': 'Personalization and inventory optimization',
      },
      {
        'icon': Icons.school,
        'title': 'Education',
        'description': 'Personalized learning and assessment',
      },
      {
        'icon': Icons.local_shipping,
        'title': 'Transportation',
        'description': 'Route optimization and fleet management',
      },
      {
        'icon': Icons.apartment,
        'title': 'Real Estate',
        'description': 'Property analytics and market insights',
      },
      {
        'icon': Icons.gavel,
        'title': 'Legal',
        'description': 'Document analysis and case management',
      },
      {
        'icon': Icons.agriculture,
        'title': 'Agriculture',
        'description': 'Crop monitoring and yield optimization',
      },
      {
        'icon': Icons.bolt,
        'title': 'Energy',
        'description': 'Grid optimization and demand forecasting',
      },
      {
        'icon': Icons.hotel,
        'title': 'Hospitality',
        'description': 'Guest experience and operations management',
      },
      {
        'icon': Icons.security,
        'title': 'Insurance',
        'description': 'Claims processing and risk assessment',
      },
    ];

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Column(
      children: [
        SizedBox(height: isMobile ? 24 : 40),
        Text(
          'Industries We Serve',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: isMobile ? 24 : 32),
        _buildFeaturesGrid(industries, crossAxisCount),
      ],
    );
  }

  Widget _buildIndustriesStatsBanner(bool isMobile) {
    final stats = [
      {'value': '50+', 'label': 'Industries served'},
      {'value': '95%', 'label': 'Client satisfaction'},
      {'value': '200%', 'label': 'Average ROI increase'},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 0,
        vertical: isMobile ? 24 : 40,
      ),
      decoration: const BoxDecoration(color: Color(0xFFFF5A00)),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < stats.length; i++) ...[
                  _buildIndustryStatItem(
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
                return _buildIndustryStatItem(
                  stat['value'] as String,
                  stat['label'] as String,
                  isMobile,
                );
              }).toList(),
            ),
    );
  }

  Widget _buildIndustryStatItem(String value, String label, bool isMobile) {
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

  Widget _buildTestimonialsSection(bool isMobile, bool isTablet) {
    final testimonials = [
      {'category': 'E‑commerce', 'name': 'Nina Patel'},
      {'category': 'Telecom', 'name': 'Rashid Ali'},
      {'category': 'SaaS', 'name': 'Julia Park'},
      {'category': 'Healthcare', 'name': 'Laura Smith'},
      {'category': 'Logistics', 'name': 'Tomas Rivera'},
      {'category': 'Travel', 'name': 'Ibrahim Khan'},
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
        if (j > 0) rowCards.add(const SizedBox(width: 16));
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
      if (i > 0) rows.add(const SizedBox(height: 16));
      rows.add(
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: rowCards),
      );
    }

    return Column(children: rows);
  }

  Widget _buildDashboardSection(bool isMobile, bool isTablet) {
    return Column(
      children: [
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
        _buildKpiCards(isMobile, isTablet),
        SizedBox(height: isMobile ? 24 : 32),
        _buildChartsRow(isMobile),
        SizedBox(height: isMobile ? 24 : 32),
        _buildMetricCards(isMobile, isTablet),
      ],
    );
  }

  Widget _buildKpiCards(bool isMobile, bool isTablet) {
    final kpis = [
      {
        'icon': Icons.store_mall_directory_outlined,
        'title': 'Stands Attended',
        'value': '47',
        'trend': '+8%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.person_add_alt,
        'title': 'Leads Generated',
        'value': '2,847',
        'trend': '+25%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.call_outlined,
        'title': 'Calls Attended',
        'value': '8,923',
        'trend': '+15%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.monitor_heart_outlined,
        'title': 'Database Reactivated',
        'value': '1,567',
        'trend': '+18%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.phone_in_talk_outlined,
        'title': 'Cold Calls Made',
        'value': '12,456',
        'trend': '+22%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.attach_money,
        'title': 'Sales Volume',
        'value': '85.3M AED',
        'trend': '+32%',
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

  Widget _buildChartsRow(bool isMobile) {
    final charts = [
      ChartCard(
        title: 'Performance Trends',
        chart: const _IndustriesPerformanceChartPlaceholder(),
        height: 302,
      ),
      ChartCard(
        title: 'Distribution Analytics',
        chart: const _IndustriesDistributionPiePlaceholder(),
        height: 302,
      ),
    ];

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [charts[0], const SizedBox(height: 16), charts[1]],
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
        'title': 'First Contact Resolution',
        'percentage': '+9%',
        'desc': '76% vs last month',
        'progress': 0.76,
        'color': 0xFF10B981,
      },
      {
        'title': 'SLA Compliance',
        'percentage': '+6%',
        'desc': '88% within SLA',
        'progress': 0.88,
        'color': 0xFF1E90FF,
      },
      {
        'title': 'Automation Rate',
        'percentage': '+12%',
        'desc': '61% handled by bots',
        'progress': 0.61,
        'color': 0xFF059669,
      },
      {
        'title': 'NPS',
        'percentage': '+4',
        'desc': 'Net Promoter Score',
        'progress': 0.72,
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

      if (index > 0) widgets.add(const SizedBox(width: 16));

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
}

// Placeholder charts; replace with real ones if needed later
class _IndustriesPerformanceChartPlaceholder extends StatelessWidget {
  const _IndustriesPerformanceChartPlaceholder();
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Performance chart here'));
  }
}

class _IndustriesDistributionPiePlaceholder extends StatelessWidget {
  const _IndustriesDistributionPiePlaceholder();
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Distribution pie here'));
  }
}
