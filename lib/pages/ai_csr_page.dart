import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../widgets/feature_card.dart';
import '../widgets/media_card.dart';
import '../widgets/kpi_card.dart';
import '../widgets/chart_card.dart';
import '../widgets/metric_card.dart';

class AiCsrPageContent extends StatelessWidget {
  const AiCsrPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth <= 1024;

    return Column(
      children: [
        // Hero + Video + Features
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
                          text: 'CSR',
                          style: TextStyle(color: Color(0xFF424242)),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  _buildVideoPlaceholder(),
                  const SizedBox(height: 16),
                  _buildCsrFeaturesSection(isMobile, isTablet),
                ],
              ),
            ),
          ),
        ),

        // Stats banner
        _buildCsrStatisticsBanner(isMobile),

        // Testimonials
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

        // CTA
        _buildCsrCtaSection(isMobile, isTablet),
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
            color: const Color(0xFF0B1020),
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
                color: Color(0xFF0B1020),
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
        'icon': Icons.headset_mic_outlined,
        'title': '24/7 Support',
        'description':
            'Round-the-clock customer service with human-like interactions',
      },
      {
        'icon': Icons.favorite_border,
        'title': 'Empathetic AI',
        'description':
            'Emotional intelligence that understands customer sentiment',
      },
      {
        'icon': Icons.trending_up,
        'title': 'Issue Resolution',
        'description':
            'Automated problem-solving with escalation to humans when needed',
      },
      {
        'icon': Icons.bar_chart_outlined,
        'title': 'Performance Tracking',
        'description': 'Monitor customer satisfaction and response quality',
      },
      {
        'icon': Icons.chat_bubble_outline,
        'title': 'Multi-Channel',
        'description':
            'Consistent support across chat, email, phone, and social media',
      },
      {
        'icon': Icons.security,
        'title': 'Secure & Compliant',
        'description':
            'Enterprise-grade security with GDPR and CCPA compliance',
      },
    ];

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Column(
      children: [
        SizedBox(height: isMobile ? 24 : 40),
        Text(
          'How AI CSR Works',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E3A8A),
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        Text(
          'AI-powered customer service from intake to resolution',
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

  Widget _buildCsrStatisticsBanner(bool isMobile) {
    final stats = [
      {'value': '95%', 'label': 'Customer satisfaction'},
      {'value': '80%', 'label': 'Faster response times'},
      {'value': '50%', 'label': 'Cost reduction'},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 0,
        vertical: isMobile ? 24 : 40,
      ),
      decoration: const BoxDecoration(color: Color(0xFF059669)),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < stats.length; i++) ...[
                  _buildCsrStatItem(
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
                return _buildCsrStatItem(
                  stat['value'] as String,
                  stat['label'] as String,
                  isMobile,
                );
              }).toList(),
            ),
    );
  }

  Widget _buildCsrStatItem(String value, String label, bool isMobile) {
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
          'LIVE DASHBOARD // CUSTOMER SUPPORT',
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
        'icon': Icons.chat_bubble_outline,
        'title': 'WhatsApp Clients',
        'value': '4,567',
        'trend': '+15%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.people_alt_outlined,
        'title': 'Social Media Support',
        'value': '2,345',
        'trend': '+18%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.call_outlined,
        'title': 'Phone Support',
        'value': '3,789',
        'trend': '+12%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.chat_outlined,
        'title': 'Website Chat',
        'value': '1,892',
        'trend': '+22%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.bar_chart_outlined,
        'title': 'Total Inquiries',
        'value': '12,593',
        'trend': '+16%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.gps_fixed_outlined,
        'title': 'Avg Inquiries/Client',
        'value': '3.2',
        'trend': '+8%',
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
        chart: const _CsrPerformanceChart(),
        height: 302,
      ),
      ChartCard(
        title: 'Distribution Analytics',
        chart: const _CsrDistributionPie(),
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

  Widget _buildCsrCtaSection(bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (isTablet ? 24 : 32),
        vertical: isMobile ? 40 : 56,
      ),
      decoration: const BoxDecoration(color: Color(0xFF059669)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Ready to Transform Customer Service?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Join thousands of companies already using AI for superior customer support',
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
          foregroundColor: const Color(0xFF059669),
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

  // Pricing section (CSR)
  Widget _buildPricingSection(bool isMobile, bool isTablet) {
    final List<Map<String, dynamic>> plans = [
      {
        'title': 'Starter',
        'price': '39',
        'period': '/month',
        'subtitle': 'Perfect for small businesses',
        'features': [
          'Up to 1,000 conversations',
          'Basic chat support',
          'Email integration',
          'Knowledge base',
          'Basic analytics',
        ],
        'highlight': false,
      },
      {
        'title': 'Professional',
        'price': '99',
        'period': '/month',
        'subtitle': 'Ideal for growing companies',
        'features': [
          'Up to 10,000 conversations',
          'Multi-channel support',
          'Sentiment analysis',
          'Advanced escalation',
          'Custom workflows',
          'Priority support',
        ],
        'highlight': true,
      },
      {
        'title': 'Enterprise',
        'price': '299',
        'period': '/month',
        'subtitle': 'For large organizations',
        'features': [
          'Unlimited conversations',
          'Custom AI training',
          'Advanced integrations',
          'Dedicated support',
          'Enterprise security',
          'Custom reporting',
        ],
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
    final Color accent = const Color(0xFF059669);

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
                '\$${plan['price'] as String}',
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
              child: const Text('Get Started'),
            ),
          ),
        ],
      ),
    );
  }
}

// === CSR Performance Trends line chart (Mon-Sun) ===
class _CsrPerformanceChart extends StatefulWidget {
  const _CsrPerformanceChart();

  @override
  State<_CsrPerformanceChart> createState() => _CsrPerformanceChartState();
}

class _CsrPerformanceChartState extends State<_CsrPerformanceChart> {
  final List<double> blue = [650, 720, 680, 750, 820, 560, 510];
  final List<double> green = [300, 360, 330, 420, 460, 270, 240];
  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

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
    final int idx = ((relativeX / chartWidth) * (days.length - 1)).round();

    // Compute point location for tooltip
    const double minY = 0;
    const double maxY = 1000;
    final double x = leftPadding + (idx / (days.length - 1)) * chartWidth;
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
                    painter: _CsrLineChartPainter(selectedIndex: _hoverIndex),
                  ),
                ),
                if (_hoverIndex != null && _hoverPoint != null)
                  Positioned(
                    left: (_hoverPoint!.dx + 10).clamp(0, size.width - 180),
                    top: (_hoverPoint!.dy - 70).clamp(0, size.height - 80),
                    child: _CsrTooltipCard(
                      day: days[_hoverIndex!],
                      social: blue[_hoverIndex!].toInt(),
                      whatsapp: green[_hoverIndex!].toInt(),
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

class _CsrLineChartPainter extends CustomPainter {
  _CsrLineChartPainter({this.selectedIndex});

  final int? selectedIndex;

  final List<double> blue = [650, 720, 680, 750, 820, 560, 510];
  final List<double> green = [300, 360, 330, 420, 460, 270, 240];
  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void paint(Canvas canvas, Size size) {
    const double leftPadding = 38;
    const double rightPadding = 16;
    const double topPadding = 8;
    const double bottomPadding = 36;

    final double chartWidth = size.width - leftPadding - rightPadding;
    final double chartHeight = size.height - topPadding - bottomPadding;

    const double minY = 0;
    const double maxY = 1000;

    final Paint grid = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFFE5E7EB);

    final TextStyle labelStyle = const TextStyle(
      fontSize: 12,
      color: Color(0xFF6B7280),
    );

    for (int i = 0; i <= 4; i++) {
      final double yValue = i * 250;
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
        text: TextSpan(
          text: yValue == 0 ? '0' : yValue.toStringAsFixed(0),
          style: labelStyle,
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(leftPadding - tp.width - 8, y - tp.height / 2));
    }

    for (int i = 0; i < days.length; i++) {
      final double x = leftPadding + (i / (days.length - 1)) * chartWidth;
      canvas.drawLine(
        Offset(x, topPadding),
        Offset(x, size.height - bottomPadding),
        grid,
      );

      final tp = TextPainter(
        text: TextSpan(text: days[i], style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(x - tp.width / 2, size.height - bottomPadding + 6),
      );
    }

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

    // Highlight selected point if any
    if (selectedIndex != null) {
      final int i = selectedIndex!.clamp(0, blue.length - 1);
      const double minY = 0;
      const double maxY = 1000;
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
  bool shouldRepaint(covariant _CsrLineChartPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex;
  }
}

class _CsrTooltipCard extends StatelessWidget {
  const _CsrTooltipCard({
    required this.day,
    required this.social,
    required this.whatsapp,
  });

  final String day;
  final int social;
  final int whatsapp;

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
          Text(day, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Row(
            children: const [
              Icon(Icons.show_chart, size: 14, color: Color(0xFF3B82F6)),
              SizedBox(width: 6),
              Text(
                'social :',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
            ],
          ),
          Text(
            social.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Row(
            children: const [
              Icon(
                Icons.chat_bubble_outline,
                size: 14,
                color: Color(0xFF10B981),
              ),
              SizedBox(width: 6),
              Text(
                'whatsapp :',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
            ],
          ),
          Text(
            whatsapp.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// === CSR Distribution Analytics Pie Chart ===
class _CsrDistributionPie extends StatefulWidget {
  const _CsrDistributionPie();

  @override
  State<_CsrDistributionPie> createState() => _CsrDistributionPieState();
}

class _CsrDistributionPieState extends State<_CsrDistributionPie> {
  // Data matching the image: 40%, 32%, 18%, 10%
  final List<double> parts = const [40, 32, 18, 10];
  final List<String> labels = const [
    'WhatsApp', // 40%
    'Phone', // 32%
    'Website Chat', // 18%
    'Social Media Support', // 10%
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
                    painter: _CsrPiePainter(selectedIndex: _hoverIndex),
                  ),
                ),
                if (_hoverIndex != null && _hoverPos != null)
                  Positioned(
                    left: (_hoverPos!.dx - 55).clamp(0, size.width - 110),
                    top: (_hoverPos!.dy - 22).clamp(0, size.height - 44),
                    child: _CsrPieTooltip(
                      text:
                          '${labels[_hoverIndex!]} : ${parts[_hoverIndex!].toStringAsFixed(0)}%',
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

class _CsrPiePainter extends CustomPainter {
  _CsrPiePainter({this.selectedIndex});

  final int? selectedIndex;
  final List<double> parts = const [40, 32, 18, 10];
  final List<Color> colors = const [
    Color(0xFF10B981), // green 40%
    Color(0xFF3B82F6), // blue 32%
    Color(0xFFEF4444), // red 18%
    Color(0xFF0EA5E9), // teal 10%
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 10);
    final radius =
        math.min(size.width, size.height) *
        _CsrDistributionPieState.radiusFactor;

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

class _CsrPieTooltip extends StatelessWidget {
  const _CsrPieTooltip({required this.text});

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
