import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';
import '../widgets/feature_card.dart';
import '../widgets/kpi_card.dart';
import '../widgets/metric_card.dart';
import '../widgets/chart_card.dart';
import '../widgets/media_card.dart';
import '../widgets/implementation_step_card.dart';

class AiSalesPageContent extends StatefulWidget {
  const AiSalesPageContent({super.key});

  @override
  State<AiSalesPageContent> createState() => _AiSalesPageContentState();
}

class _AiSalesPageContentState extends State<AiSalesPageContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30), // Slow animation
    )..repeat(); // Repeat indefinitely
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth <= 1024;
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 4);

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
                  // Title with "AI" in pink and "SALES" in dark
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
                          text: 'SALES',
                          style: TextStyle(color: Color(0xFF424242)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  // Subtitle
                  Text(
                    'Your AI tool to enhance your sales team with Advanced Artificial Intelligence Solutions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 18,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  SizedBox(height: isMobile ? 32 : 48),
                  // Stat Cards in a Responsive Grid Layout
                  _buildStatsGrid(crossAxisCount),
                  SizedBox(height: isMobile ? 48 : 64),
                  // Video Placeholder
                  _buildVideoPlaceholder(isMobile),
                  SizedBox(height: isMobile ? 48 : 64),
                  // Trusted Companies Slider
                  _buildTrustedCompaniesSlider(),
                  SizedBox(height: isMobile ? 48 : 64),
                  // How AI SALES Works Section
                  _buildHowItWorksSection(isMobile, isTablet),
                ],
              ),
            ),
          ),
        ),
        // Statistics Banner - Full Width
        _buildStatisticsBanner(isMobile),
        // Testimonials Section
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
        // Dashboard Section - Full Width
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

  Widget _buildStatsGrid(int crossAxisCount) {
    final stats = [
      const StatCard(
        value: '57',
        label: 'Sales workflows automated',
        accentColor: Color(0xFF0000FF),
      ),
      const StatCard(
        value: '11,023',
        label: 'Cold Calls made',
        accentColor: Color(0xFF008000),
      ),
      const StatCard(
        value: '36,155.44',
        label: 'Minutes spoken',
        accentColor: Color(0xFF800080),
      ),
      const StatCard(
        value: '744',
        label: 'Meetings appointed with sales agents',
        accentColor: Color(0xFFFF4500),
      ),
    ];

    // For mobile (1 column), return a simple column with full-width cards
    if (crossAxisCount == 1) {
      return Column(
        children: stats.asMap().entries.map((entry) {
          final index = entry.key;
          final card = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(width: double.infinity, child: card),
              if (index < stats.length - 1) const SizedBox(height: 16),
            ],
          );
        }).toList(),
      );
    }

    // For tablet and desktop, create rows with equal-width cards
    final List<Widget> rows = [];
    for (int i = 0; i < stats.length; i += crossAxisCount) {
      final List<Widget> rowCards = [];
      for (int j = 0; j < crossAxisCount && (i + j) < stats.length; j++) {
        if (j > 0) {
          rowCards.add(const SizedBox(width: 16));
        }
        rowCards.add(Expanded(child: stats[i + j]));
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

  Widget _buildTrustedCompaniesSlider() {
    final originalCompanies = [
      {
        'initials': 'GI',
        'name': 'Grupo Inmobiliario BCN',
        'color': const Color(0xFF6A5ACD),
      },
      {
        'initials': 'EP',
        'name': 'Estética Premium',
        'color': const Color(0xFF800080),
      },
      {
        'initials': 'SE',
        'name': 'Solaris Energy',
        'color': const Color(0xFFFF6600),
      },
      {
        'initials': 'PV',
        'name': 'Propiedades Valencia',
        'color': const Color(0xFF008B8B),
      },
      {
        'initials': 'WS',
        'name': 'Wellness Spa Group',
        'color': const Color(0xFF228B22),
      },
      {
        'initials': 'IS',
        'name': 'Inmobiliaria Serrano',
        'color': const Color(0xFF1E90FF),
      },
      {
        'initials': 'CB',
        'name': 'Clínica Be',
        'color': const Color(0xFFFF69B4),
      },
    ];

    // Duplicate companies 4 times for smooth infinite looping
    final companies = [
      ...originalCompanies,
      ...originalCompanies,
      ...originalCompanies,
      ...originalCompanies,
    ];

    return Column(
      children: [
        Text(
          'Trusted by leading companies',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 24),
        ClipRect(
          child: SizedBox(
            height: 130,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Stack(
                children: [
                  OverflowBox(
                    alignment: Alignment.centerLeft,
                    maxWidth: double.infinity,
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        // Render 14 cards (2 sets) for smooth looping
                        final visibleCards = companies.take(14).toList();
                        final cardWidth = 180 + 16; // card width + spacing
                        final totalWidth =
                            cardWidth * 7; // animate through 7 cards
                        return Transform.translate(
                          offset: Offset(
                            -_animationController.value * totalWidth,
                            0,
                          ),
                          child: Row(
                            children: visibleCards.map((company) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: _buildCompanyCard(company),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                  // Left fade gradient
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    width: 100,
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.white,
                              Colors.white.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Right fade gradient
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    width: 100,
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Colors.white,
                              Colors.white.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyCard(Map<String, dynamic> company) {
    return Container(
      width: 180,
      height: 102, // Sized to fit within padded container
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: company['color'] as Color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                company['initials'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            company['name'] as String,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksSection(bool isMobile, bool isTablet) {
    final features = [
      {
        'icon': Icons.my_location,
        'title': 'Lead Search with Sales Navigator',
        'description':
            'Filter by an algorithm created per industry to only get results of people who are most likely to buy/invest.',
      },
      {
        'icon': Icons.people,
        'title': 'Lead Enrichment',
        'description':
            'Get validated emails, personal phones, company phone and more!',
      },
      {
        'icon': Icons.chat_bubble_outline,
        'title': 'Lead Engagement',
        'description':
            'AI personalized emails, AI personalized WhatsApp, AI Cold Calling, AI LinkedIn connections, AI LinkedIn messages',
      },
      {
        'icon': Icons.schedule,
        'title': 'Appointment Setter',
        'description':
            'AI set appointments in real time for you once the prospect has gone through the qualification process designed by you, programmed by the OPPERATOR AI team',
      },
      {
        'icon': Icons.bar_chart,
        'title': 'Live Dashboard',
        'description':
            'Control the success of the campaigns, analyze the calls, analyze the effectiveness of the emails and messages',
      },
      {
        'icon': Icons.trending_up,
        'title': 'Self Learning AI',
        'description':
            'Automatically analyze the conversations that convert and self refine the engagement campaigns tailored to you',
      },
    ];

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Column(
      children: [
        // Section Title
        Text(
          'How AI SALES Works',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E3A8A),
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        // Section Subtitle
        Text(
          'Comprehensive AI-powered sales automation from lead generation to conversion',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            color: const Color(0xFF6B7280),
          ),
        ),
        SizedBox(height: isMobile ? 32 : 48),
        // Features Grid
        _buildFeaturesGrid(features, crossAxisCount),
      ],
    );
  }

  Widget _buildFeaturesGrid(
    List<Map<String, dynamic>> features,
    int crossAxisCount,
  ) {
    // For mobile (1 column), return a simple column with full-width cards
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

    // For tablet and desktop, create rows with equal-width cards
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

  Widget _buildStatisticsBanner(bool isMobile) {
    final stats = [
      {'value': '85%', 'label': 'Conversion increase'},
      {'value': '60%', 'label': 'Faster deal closure'},
      {'value': '40%', 'label': 'Revenue growth'},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 24 : 40,
      ),
      decoration: const BoxDecoration(color: Color(0xFF1E3A8A)),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < stats.length; i++) ...[
                  _buildStatItem(
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
                return _buildStatItem(
                  stat['value'] as String,
                  stat['label'] as String,
                  isMobile,
                );
              }).toList(),
            ),
    );
  }

  Widget _buildStatItem(String value, String label, bool isMobile) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: isMobile ? 4 : 8),
        Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }

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
        // Section Title
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
        // Testimonials Grid
        _buildTestimonialsGrid(testimonials, crossAxisCount),
      ],
    );
  }

  Widget _buildTestimonialsGrid(
    List<Map<String, String>> testimonials,
    int crossAxisCount,
  ) {
    // For mobile (1 column), return a simple column
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

    // For tablet and desktop, create rows with equal-width cards
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
        // Charts Row
        _buildChartsRow(isMobile, isTablet),
        SizedBox(height: isMobile ? 24 : 32),
        // Metric Cards Row
        _buildMetricCards(isMobile, isTablet),
        SizedBox(height: isMobile ? 24 : 32),
        // Use Cases Section
        _buildUseCasesSection(isMobile, isTablet),
        SizedBox(height: isMobile ? 48 : 80),
        // Implementation Steps Section
        _buildImplementationStepsSection(isMobile, isTablet),
      ],
    );
  }

  Widget _buildKpiCards(bool isMobile, bool isTablet) {
    final kpis = [
      {
        'icon': Icons.phone,
        'title': 'Total Calls Made',
        'value': '8,947',
        'trend': '+15%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.track_changes,
        'title': 'Successful Calls',
        'value': '2,456',
        'trend': '+18%',
        'color': 0xFF7C3AED,
      },
      {
        'icon': Icons.favorite,
        'title': 'Calls >1min Rate',
        'value': '67%',
        'trend': '+5%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.people,
        'title': 'Direct Contact Calls',
        'value': '3,234',
        'trend': '+12%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.trending_up,
        'title': 'Leads Generated',
        'value': '2,505',
        'trend': '+28%',
        'color': 0xFF1E90FF,
      },
      {
        'icon': Icons.event_available,
        'title': 'Appointments Set',
        'value': '1,968',
        'trend': '+22%',
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

  Widget _buildChartsRow(bool isMobile, bool isTablet) {
    final charts = [
      const ChartCard(title: 'Performance Trends'),
      const ChartCard(title: 'Distribution Analytics'),
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
        // Section Title
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
        // Use Cases Grid
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

    // For mobile (1 column), return a simple column
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

    // For tablet and desktop, create rows with equal-width cards
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

  Widget _buildImplementationStepsSection(bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
      child: Column(
        children: [
          Text(
            'START IMPLEMENTING A.I. TODAY',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF5C4B9B),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Three simple steps to revolutionize your sales process',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: const Color(0xFF666666),
            ),
          ),
          SizedBox(height: isMobile ? 32 : 48),
          // Implementation Steps Cards
          _buildImplementationStepsGrid(isMobile, isTablet),
          const SizedBox(height: 32),
          // CTA Button
          _buildCtaButton(isMobile),
        ],
      ),
    );
  }

  Widget _buildCtaButton(bool isMobile) {
    return _CtaButton(isMobile: isMobile);
  }

  Widget _buildImplementationStepsGrid(bool isMobile, bool isTablet) {
    final steps = [
      {
        'title': 'AI SALES PACKAGE',
        'icon': Icons.bolt,
        'description': '300 \$ one time fee to customize for you:',
        'items': [
          'AI SALES AGENT',
          'AI CLONE VOICE',
          'AI CONVERSATIONAL FLOW',
          'AI CRM',
          'AI EMAIL CAMPAIGNS',
          'AI LEAD SEARCH',
          'AI ALGORITHM FILTER PER INDUSTRY',
          'AI LEAD ENRICHMENT',
          'AI ENGAGEMENT SEQUENCE',
        ],
        'backgroundColor': const Color(0xFF2F6FFF),
        'textColor': Colors.white,
        'iconBackgroundColor': Colors.white.withValues(alpha: 0.2),
      },
      {
        'title': 'BOOK AN APPOINTMENT',
        'icon': Icons.calendar_today,
        'description':
            'Set up an onboarding meeting to help us understand you, your business and how to program a customized AI SALES WORKFLOW just for you',
        'items': [
          'What does your company do?',
          'Which products do you want to sell?',
          'Who is your audience?',
          'How do you do sales everyday?',
          'Do you have specific offers?',
          'Do you want to reactivate databases?',
          'Do you want to find new leads?',
          'How much enrichment do you need?',
          'Do you do email campaigns?',
          'Do you do SMS/WhatsApp campaigns?',
          'Do you do Cold Calling?',
          'What material is available to feed the AI for our LLM to learn about you?',
        ],
        'backgroundColor': Colors.white,
        'textColor': const Color(0xFF333333),
        'iconBackgroundColor': const Color(0xFF2F6FFF),
      },
      {
        'title': 'CONNECT YOUR ACCOUNTS',
        'icon': Icons.phone,
        'description': 'GMAIL, CALENDAR, WHATSAPP, PHONE LINE.',
        'items': [
          'Create your profile',
          'Learn to navigate the platform',
          'Help us set up the metrics that matter to you',
        ],
        'backgroundColor': const Color(0xFF8A2BE2),
        'textColor': Colors.white,
        'iconBackgroundColor': Colors.white.withValues(alpha: 0.2),
      },
    ];

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          return Column(
            children: [
              ImplementationStepCard(
                title: step['title'] as String,
                icon: step['icon'] as IconData,
                description: step['description'] as String,
                items: step['items'] as List<String>,
                backgroundColor: step['backgroundColor'] as Color,
                textColor: step['textColor'] as Color,
                iconBackgroundColor: step['iconBackgroundColor'] as Color,
              ),
              if (index < steps.length - 1) const SizedBox(height: 24),
            ],
          );
        }).toList(),
      );
    }

    // Use responsive grid: 1 column for tablet, 3 for desktop
    // Note: isTablet check handles widths 768-1024 (including iPad Pro)
    final crossAxisCount = isTablet ? 1 : 3;

    if (isTablet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          return Column(
            children: [
              ImplementationStepCard(
                title: step['title'] as String,
                icon: step['icon'] as IconData,
                description: step['description'] as String,
                items: step['items'] as List<String>,
                backgroundColor: step['backgroundColor'] as Color,
                textColor: step['textColor'] as Color,
                iconBackgroundColor: step['iconBackgroundColor'] as Color,
              ),
              if (index < steps.length - 1) const SizedBox(height: 24),
            ],
          );
        }).toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        childAspectRatio: 0.65,
      ),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        return ImplementationStepCard(
          title: steps[index]['title'] as String,
          icon: steps[index]['icon'] as IconData,
          description: steps[index]['description'] as String,
          items: steps[index]['items'] as List<String>,
          backgroundColor: steps[index]['backgroundColor'] as Color,
          textColor: steps[index]['textColor'] as Color,
          iconBackgroundColor: steps[index]['iconBackgroundColor'] as Color,
        );
      },
    );
  }
}

class _CtaButton extends StatefulWidget {
  final bool isMobile;

  const _CtaButton({required this.isMobile});

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: widget.isMobile ? double.infinity : null,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2F6FFF), Color(0xFF8A2BE2)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: _isHovered ? 0.4 : 0.3),
                  blurRadius: _isHovered ? 12 : 8,
                  offset: Offset(0, _isHovered ? 6 : 4),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: widget.isMobile ? 24 : 48,
              vertical: 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'START USING A.I. TODAY',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
