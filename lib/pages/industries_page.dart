import 'package:flutter/material.dart';
import 'dart:math' as math;
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
        // Industry Solutions section
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : (isTablet ? 24 : 32),
            vertical: isMobile ? 48 : 64,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1232),
              child: _buildIndustrySolutionsSection(isMobile, isTablet),
            ),
          ),
        ),
        // CTA section
        _buildIndustriesCtaSection(isMobile, isTablet),
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
        chart: const _IndustriesPerformanceChart(),
        height: 302,
      ),
      ChartCard(
        title: 'Distribution Analytics',
        chart: const _IndustriesDistributionPie(),
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

  Widget _buildIndustrySolutionsSection(bool isMobile, bool isTablet) {
    final solutions = [
      {
        'title': 'Healthcare Solutions',
        'description':
            'AI for patient care, diagnostics, and medical operations',
      },
      {
        'title': 'Financial Services',
        'description':
            'Risk assessment, fraud detection, and automated trading',
      },
      {
        'title': 'Manufacturing',
        'description':
            'Predictive maintenance, quality control, and automation',
      },
      {
        'title': 'Retail & E-commerce',
        'description':
            'Personalization, inventory optimization, and customer insights',
      },
      {
        'title': 'Education Technology',
        'description':
            'Personalized learning, assessment, and administrative automation',
      },
      {
        'title': 'Transportation & Logistics',
        'description':
            'Route optimization, fleet management, and supply chain AI',
      },
    ];

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Column(
      children: [
        const Text(
          'Industry Solutions',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: isMobile ? 32 : 48),
        _buildIndustrySolutionsGrid(solutions, crossAxisCount),
      ],
    );
  }

  Widget _buildIndustrySolutionsGrid(
    List<Map<String, String>> solutions,
    int crossAxisCount,
  ) {
    if (crossAxisCount == 1) {
      return Column(
        children: solutions.asMap().entries.map((entry) {
          final index = entry.key;
          final solution = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MediaCard(
                title: solution['title']!,
                description: solution['description']!,
              ),
              if (index < solutions.length - 1) const SizedBox(height: 16),
            ],
          );
        }).toList(),
      );
    }

    final List<Widget> rows = [];
    for (int i = 0; i < solutions.length; i += crossAxisCount) {
      final List<Widget> rowCards = [];
      for (int j = 0; j < crossAxisCount && (i + j) < solutions.length; j++) {
        if (j > 0) rowCards.add(const SizedBox(width: 16));
        final solution = solutions[i + j];
        rowCards.add(
          Expanded(
            child: MediaCard(
              title: solution['title']!,
              description: solution['description']!,
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

  Widget _buildIndustriesCtaSection(bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (isTablet ? 24 : 32),
        vertical: isMobile ? 40 : 56,
      ),
      decoration: const BoxDecoration(color: Color(0xFFFF5A00)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Ready to Transform Your Industry?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Join industry leaders already leveraging AI for competitive advantage',
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
                _buildIndustriesCtaPrimaryButton(fullWidth: true),
                const SizedBox(height: 12),
                _buildIndustriesCtaSecondaryButton(fullWidth: true),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIndustriesCtaPrimaryButton(),
                const SizedBox(width: 16),
                _buildIndustriesCtaSecondaryButton(),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildIndustriesCtaPrimaryButton({bool fullWidth = false}) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFFFF5A00),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          elevation: 0,
        ),
        child: const Text('Get Industry Solution'),
      ),
    );
  }

  Widget _buildIndustriesCtaSecondaryButton({bool fullWidth = false}) {
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
        child: const Text('Schedule Consultation'),
      ),
    );
  }
}

// === Industries Performance Trends line chart (Q1-Q4) ===
class _IndustriesPerformanceChart extends StatefulWidget {
  const _IndustriesPerformanceChart();

  @override
  State<_IndustriesPerformanceChart> createState() =>
      _IndustriesPerformanceChartState();
}

class _IndustriesPerformanceChartState
    extends State<_IndustriesPerformanceChart> {
  final List<double> blue = [2450, 2800, 3300, 3600];
  final List<double> green = [0, 22.3, 0, 0];
  final List<String> quarters = ['Q1', 'Q2', 'Q3', 'Q4'];

  static const double leftPadding = 38;
  static const double rightPadding = 16;
  static const double topPadding = 8;
  static const double bottomPadding = 36;

  int? _hoverIndex;
  Offset? _hoverPoint;

  void _handleHover(Offset localPos, Size size) {
    final double chartWidth = size.width - leftPadding - rightPadding;
    final double chartHeight = size.height - topPadding - bottomPadding;
    if (chartWidth <= 0 || chartHeight <= 0) return;

    final double relativeX = (localPos.dx - leftPadding).clamp(0, chartWidth);
    final int idx = ((relativeX / chartWidth) * (quarters.length - 1))
        .round()
        .clamp(0, quarters.length - 1);

    // Compute point location for tooltip
    const double minY = 0;
    const double maxY = 3600;
    final double x = leftPadding + (idx / (quarters.length - 1)) * chartWidth;
    final double normalizedY = (blue[idx] - minY) / (maxY - minY);
    final double y = topPadding + chartHeight - (normalizedY * chartHeight);

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
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return MouseRegion(
          onHover: (e) => _handleHover(e.localPosition, size),
          onExit: (_) => _clearHover(),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (e) => _handleHover(e.localPosition, size),
            onTapCancel: _clearHover,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _IndustriesLineChartPainter(
                      selectedIndex: _hoverIndex,
                    ),
                  ),
                ),
                if (_hoverIndex != null && _hoverPoint != null)
                  Positioned(
                    left: (_hoverPoint!.dx + 10).clamp(0, size.width - 180),
                    top: (_hoverPoint!.dy - 70).clamp(0, size.height - 80),
                    child: _IndustriesTooltipCard(
                      quarter: quarters[_hoverIndex!],
                      leads: blue[_hoverIndex!],
                      sales: green[_hoverIndex!],
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

class _IndustriesLineChartPainter extends CustomPainter {
  _IndustriesLineChartPainter({this.selectedIndex});

  final int? selectedIndex;

  final List<double> blue = [2450, 2800, 3300, 3600];
  final List<double> green = [0, 22.3, 0, 0];
  final List<String> quarters = ['Q1', 'Q2', 'Q3', 'Q4'];

  @override
  void paint(Canvas canvas, Size size) {
    const double leftPadding = 38;
    const double rightPadding = 16;
    const double topPadding = 8;
    const double bottomPadding = 36;

    final double chartWidth = size.width - leftPadding - rightPadding;
    final double chartHeight = size.height - topPadding - bottomPadding;

    const double minY = 0;
    const double maxY = 3600;

    final Paint grid = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFFE5E7EB);

    final TextStyle labelStyle = const TextStyle(
      fontSize: 12,
      color: Color(0xFF6B7280),
    );

    // Draw horizontal grid lines and Y labels (0, 900, 1800, 2700, 3600)
    for (int i = 0; i <= 4; i++) {
      final double yValue = i * 900;
      final double y =
          topPadding +
          chartHeight -
          (yValue - minY) / (maxY - minY) * chartHeight;
      canvas.drawLine(
        Offset(leftPadding, y),
        Offset(size.width - rightPadding, y),
        grid,
      );

      final tp = TextPainter(
        text: TextSpan(text: yValue.toStringAsFixed(0), style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(leftPadding - tp.width - 8, y - tp.height / 2));
    }

    // Draw vertical grid lines and X labels (Q1, Q2, Q3, Q4)
    for (int i = 0; i < quarters.length; i++) {
      final double x = leftPadding + (i / (quarters.length - 1)) * chartWidth;
      canvas.drawLine(
        Offset(x, topPadding),
        Offset(x, size.height - bottomPadding),
        grid,
      );

      final tp = TextPainter(
        text: TextSpan(text: quarters[i], style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(x - tp.width / 2, size.height - bottomPadding + 6),
      );
    }

    // Draw green baseline (all zeros)
    _drawLine(
      canvas,
      green,
      const Color(0xFF10B981),
      leftPadding,
      topPadding,
      chartWidth,
      chartHeight,
      minY,
      maxY,
    );

    // Draw blue performance line
    _drawLine(
      canvas,
      blue,
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
      final int i = selectedIndex!.clamp(0, blue.length - 1);
      const double minY = 0;
      const double maxY = 3600;
      final double x = leftPadding + (i / (blue.length - 1)) * chartWidth;
      final double normalizedY = (blue[i] - minY) / (maxY - minY);
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
    final Path path = Path();
    final Paint line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = color;

    final Paint pointStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white;
    final Paint pointFill = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    for (int i = 0; i < data.length; i++) {
      final double x = leftPadding + (i / (data.length - 1)) * chartWidth;
      final double y =
          topPadding +
          chartHeight -
          ((data[i] - minY) / (maxY - minY)) * chartHeight;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      canvas.drawCircle(Offset(x, y), 6, pointStroke);
      canvas.drawCircle(Offset(x, y), 4, pointFill);
    }
    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant _IndustriesLineChartPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex;
  }
}

class _IndustriesTooltipCard extends StatelessWidget {
  _IndustriesTooltipCard({
    required this.quarter,
    required this.leads,
    required this.sales,
  });

  final String quarter;
  final double leads;
  final double sales;

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
          Text(quarter, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(
            'leads: ${leads.toInt()}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3B82F6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'sales: $sales',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF10B981),
            ),
          ),
        ],
      ),
    );
  }
}

// === Industries Distribution Analytics Pie Chart ===
class _IndustriesDistributionPie extends StatefulWidget {
  const _IndustriesDistributionPie();

  @override
  State<_IndustriesDistributionPie> createState() =>
      _IndustriesDistributionPieState();
}

class _IndustriesDistributionPieState
    extends State<_IndustriesDistributionPie> {
  // Data matching the image: 45%, 30%, 15%, 10%
  final List<double> parts = const [45, 30, 15, 10];
  final List<String> labels = const [
    'Apartments', // 45%
    'Villas', // 30%
    'Townhouses', // 15%
    'Studios', // 10%
  ];

  static const double radiusFactor = 0.35;
  int? _hoverIndex;
  Offset? _hoverPos;

  void _handleHover(Offset localPos, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 10);
    final radius = math.min(size.width, size.height) * radiusFactor;

    final Offset v = localPos - center;
    final double distance = v.distance;
    if (distance < radius * 0.55 || distance > radius + 28) {
      if (_hoverIndex != null) setState(() => _hoverIndex = null);
      return;
    }

    double angle = math.atan2(v.dy, v.dx);
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
                    painter: _IndustriesPiePainter(selectedIndex: _hoverIndex),
                  ),
                ),
                if (_hoverIndex != null && _hoverPos != null)
                  Positioned(
                    left: (_hoverPos!.dx - 55).clamp(0, size.width - 110),
                    top: (_hoverPos!.dy - 22).clamp(0, size.height - 44),
                    child: _IndustriesPieTooltip(
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

class _IndustriesPiePainter extends CustomPainter {
  _IndustriesPiePainter({this.selectedIndex});

  final int? selectedIndex;
  final List<double> parts = const [45, 30, 15, 10];
  final List<Color> colors = const [
    Color(0xFF3B82F6), // blue 45%
    Color(0xFF10B981), // green 30%
    Color(0xFFF59E0B), // yellow/gold 15%
    Color(0xFFF97316), // orange 10%
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 10);
    final radius =
        math.min(size.width, size.height) *
        _IndustriesDistributionPieState.radiusFactor;

    double startRadian = -math.pi / 2;
    for (int i = 0; i < parts.length; i++) {
      final sweepRadian = (parts[i] / 100) * 2 * math.pi;
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = colors[i];
      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, startRadian, sweepRadian, true, paint);

      // Highlight selected slice
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

    canvas.drawLine(startPoint, endPoint, linePaint);

    final bool right = math.cos(midAngle) >= 0;
    final tickEnd = endPoint + Offset(right ? 18 : -18, 0);
    canvas.drawLine(endPoint, tickEnd, linePaint);

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

class _IndustriesPieTooltip extends StatelessWidget {
  _IndustriesPieTooltip({required this.text});

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
