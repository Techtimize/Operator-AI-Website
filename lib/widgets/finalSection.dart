import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Use the responsive utilities you provided earlier
import '../utils/app_reponsiveness/responsive_utils.dart';
import '../utils/app_reponsiveness/app_spaces.dart';
import '../utils/app_reponsiveness/size_utils.dart';

class FinalSections extends StatefulWidget {
  const FinalSections({super.key});

  @override
  State<FinalSections> createState() => _FinalSectionsState();
}

class _FinalSectionsState extends State<FinalSections> {
  int? flippedCard;
  int? hoveredDept;

  // track hovered stat index
  int? hoveredStat;

  final executiveTeam = [
    {
      'name': 'Ignacio Kindelan',
      'role': 'Chief Executive Officer',
      'avatar': 'https://i.pravatar.cc/200?img=12',
      'about':
          'Leading Opperator AI with a vision to revolutionize business operations through cutting-edge AI solutions. 15+ years of experience in technology and strategic growth.'
    },
    {
      'name': 'Alfonso Suarez',
      'role': 'Chief AI Technology Officer',
      'avatar': 'https://i.pravatar.cc/200?img=33',
      'about':
          'Architecting innovative AI systems and leading our technical excellence. Expert in machine learning, cloud infrastructure, and scalable enterprise solutions.'
    }
  ];

  final departments = [
    {
      'name': 'AI Engineering',
      'icon': LucideIcons.code,
      'color': [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)],
      'bgColor': const Color(0xFFF3F4F6).withOpacity(0.5),
      'dotColor': const Color(0xFF8B5CF6),
      'totalMembers': 10,
      'roles': [
        {'title': 'AI Backend Developers', 'count': 4},
        {'title': 'AI Frontend Developers', 'count': 3},
        {'title': 'AI Full Stack Developers', 'count': 2},
        {'title': 'AI Project Managers', 'count': 1}
      ]
    },
    {
      'name': 'AI-Powered Design',
      'icon': LucideIcons.palette,
      'color': [const Color(0xFFEC4899), const Color(0xFFDB2777)],
      'bgColor': const Color(0xFFFCE7F3).withOpacity(0.5),
      'dotColor': const Color(0xFFEC4899),
      'totalMembers': 7,
      'roles': [
        {'title': 'AI Designers', 'count': 3},
        {'title': 'AI Content Creators', 'count': 2},
        {'title': 'AI Visual Artists', 'count': 2}
      ]
    },
    {
      'name': 'AI & Research',
      'icon': LucideIcons.brain,
      'color': [const Color(0xFF06B6D4), const Color(0xFF0891B2)],
      'bgColor': const Color(0xFFECFEFF).withOpacity(0.5),
      'dotColor': const Color(0xFF06B6D4),
      'totalMembers': 7,
      'roles': [
        {'title': 'AI ML Engineers', 'count': 3},
        {'title': 'AI Data Scientists', 'count': 2},
        {'title': 'AI Researchers', 'count': 2}
      ]
    },
    {
      'name': 'AI Customer Success',
      'icon': LucideIcons.headphones,
      'color': [const Color(0xFFF97316), const Color(0xFFEA580C)],
      'bgColor': const Color(0xFFFFF7ED).withOpacity(0.5),
      'dotColor': const Color(0xFFF97316),
      'totalMembers': 6,
      'roles': [
        {'title': 'AI Support Specialists', 'count': 4},
        {'title': 'AI Success Managers', 'count': 2}
      ]
    }
  ];

  // Helper to replace the previous Responsive.getFontSize(...) behavior
  double _rFont(BuildContext context,
      {required double mobile, required double tablet, required double desktop}) {
    final width = MediaQuery.of(context).size.width;
    if (width < ResponsiveBreakpoints.md) return mobile;
    if (width < ResponsiveBreakpoints.lg) return tablet;
    return desktop;
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    // Custom breakpoints you provided:
    final bool isMobileRange = w < ResponsiveBreakpoints.md; // < 570
    final bool isLargePhoneRange = w >= ResponsiveBreakpoints.md && w < ResponsiveBreakpoints.lg; // 570-720
    final bool isTabletRange = w >= ResponsiveBreakpoints.lg && w < ResponsiveBreakpoints.xl; // 720-880
    final bool isDesktopRange = w >= ResponsiveBreakpoints.xl; // >= 880

    // paddings & fonts smaller for mobile
    final double sectionVerticalPadding = isMobileRange ? 20 : 40;
    final double sectionHorizontalPadding = isMobileRange ? 12 : 32;

    // Executive card width rules
    final double execWidthTablet = 240;
    final double execWidthDesktop = 280;

    int departmentCrossAxis;
    if (isMobileRange) departmentCrossAxis = 1;
    else if (isLargePhoneRange) departmentCrossAxis = 2;
    else if (isTabletRange) {
      departmentCrossAxis = (w > 820) ? 3 : 2;
    } else {
      departmentCrossAxis = 2;
    }

    int statsCrossAxis;
    if (isMobileRange) statsCrossAxis = 2;
    else if (isLargePhoneRange) statsCrossAxis = 3;
    else if (isTabletRange) {
      statsCrossAxis = (w > 820) ? 4 : 3;
    } else {
      statsCrossAxis = 4;
    }

    int execPerRow;
    if (isMobileRange) execPerRow = 1;
    else if (isLargePhoneRange) execPerRow = 1;
    else if (isTabletRange) execPerRow = 2;
    else execPerRow = 2;

    // circle constants
    final double cornerCircleSize = 12.0;
    final double cornerOffset = isMobileRange ? 12 : 4.5;

    final Widget sectionContainer = Container(
      padding: EdgeInsets.symmetric(vertical: sectionVerticalPadding),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
        ),
      ),
      child: Column(
        children: [
          // Title block
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sectionHorizontalPadding),
            child: Column(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF1D4ED8), Color(0xFF1E40AF)],
                  ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: Text(
                    'Leadership & Team',
                    style: TextStyle(
                        fontSize: _rFont(context, mobile: 22, tablet: 28, desktop: 40),
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: AppSpaces.vertical(context, AppSize.xs)),
                Text(
                  'Experienced leaders and dedicated professionals driving innovation at Opperator AI',
                  style: TextStyle(
                      fontSize: _rFont(context, mobile: 11, tablet: 14, desktop: 20),
                      color: const Color(0xFF6B7280)),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Executive Team — use LayoutBuilder to compute exact available width and prevent overflow
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sectionHorizontalPadding),
            child: LayoutBuilder(builder: (context, constraints) {
              final double available = constraints.maxWidth;
              final double spacing = execPerRow == 1 ? 0 : 20;
              double execCardWidth;
              if (execPerRow == 1) {
                execCardWidth = available;
              } else {
                final attempt = isDesktopRange ? execWidthDesktop : execWidthTablet;
                final totalNeeded = attempt * execPerRow + spacing * (execPerRow - 1);
                if (totalNeeded <= available) {
                  execCardWidth = attempt;
                } else {
                  execCardWidth = (available - spacing * (execPerRow - 1)) / execPerRow;
                }
              }

              return Wrap(
                spacing: execPerRow == 1 ? 0 : 20,
                runSpacing: 16,
                alignment: execPerRow == 1 ? WrapAlignment.start : WrapAlignment.center,
                children: executiveTeam.asMap().entries.map((entry) {
                  final index = entry.key;
                  final member = entry.value;
                  final bool allowHover = !isMobileRange;

                  // target flip value: 0 => front, 1 => back
                  final double targetFlip = (flippedCard == index) ? 1.0 : 0.0;

                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: execCardWidth,
                      minWidth: execCardWidth,
                    ),
                    child: MouseRegion(
                      onEnter: (event) {
                        if (allowHover) setState(() => flippedCard = index);
                      },
                      onExit: (event) {
                        if (allowHover) setState(() => flippedCard = null);
                      },
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: targetFlip),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        builder: (context, val, child) {
                          // val goes 0..1, map to rotation angle 0..pi
                          final angle = val * math.pi;

                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001) // perspective
                              ..rotateY(-angle),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 360),
                              margin: EdgeInsets.symmetric(vertical: isMobileRange ? 8 : 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: const Color(0xFFBFDBFE), width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 18,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              height: isMobileRange ? null : 320,
                              child: Stack(
                                children: [
                                  // ---------------- FRONT ----------------
                                  // Wrap front content in a Stack so we can place corner circle(s)
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity: flippedCard == index ? 0 : 1,
                                    child: Padding(
                                      padding: EdgeInsets.all(isMobileRange ? 14 : 24),
                                      child: Stack(
                                        children: [
                                          // main column content (keeps original layout)
                                          Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(bottom: 12),
                                                width: isMobileRange ? 76 : 96,
                                                height: isMobileRange ? 76 : 96,
                                                decoration: BoxDecoration(
                                                  gradient: const LinearGradient(
                                                    colors: [Color(0xFF2563EB), Color(0xFF1E40AF)],
                                                  ),
                                                  borderRadius: BorderRadius.circular(48),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.16),
                                                      blurRadius: 8,
                                                      offset: const Offset(0, 4),
                                                    )
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(2),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(48),
                                                  child: Image.network(
                                                    member['avatar']!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                member['name']!,
                                                style: TextStyle(
                                                  fontSize: _rFont(context, mobile: 14, tablet: 16, desktop: 20),
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(0xFF111827),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                member['role']!,
                                                style: TextStyle(
                                                  fontSize: _rFont(context, mobile: 11, tablet: 13, desktop: 14),
                                                  color: const Color(0xFF6B7280),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              isMobileRange ? SizedBox(height: 12) : isMobileRange ? SizedBox(height: 12) : const Spacer(),
                                              // keep the small corner indicators visually present (they will be repositioned)
                                              Row(
                                                children: [
                                                  // preserved for spacing; actual corner circles are positioned
                                                  Container(width: cornerCircleSize, height: cornerCircleSize, color: Colors.transparent),
                                                  isMobileRange ? SizedBox(height: 12) : isMobileRange ? SizedBox(height: 12) : const Spacer(),
                                                  Container(width: cornerCircleSize, height: cornerCircleSize, color: Colors.transparent),
                                                ],
                                              )
                                            ],
                                          ),

                                          // FRONT: bottom-right circle (stays bottom-right on both sides)
                                          // FRONT: bottom-right circle (same)
Positioned(
  bottom: cornerOffset - 4,
  right: cornerOffset - 4,
  child: Container(
    width: cornerCircleSize,
    height: cornerCircleSize,
    decoration: BoxDecoration(
      color: const Color(0xFF93C5FD),
      shape: BoxShape.circle,
    ),
  ),
),

// FRONT: second circle — MOVE FROM bottom-left → TO top-left
Positioned(
  top: cornerOffset - 4,
  left: cornerOffset - 4,
  child: Container(
    width: cornerCircleSize,
    height: cornerCircleSize,
    decoration: BoxDecoration(
      color: const Color(0xFF93C5FD),
      shape: BoxShape.circle,
    ),
  ),
),

                                        ],
                                      ),
                                    ),
                                  ),

                                  // ---------------- BACK ----------------
                                  // Wrap back content in an extra 180deg rotation so it reads upright
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity: flippedCard == index ? 1 : 0,
                                    child: Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.identity()..rotateY(-math.pi),
                                      child: Container(
                                        padding: EdgeInsets.all(isMobileRange ? 14 : 24),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [Color(0xFF2563EB), Color(0xFF1E40AF)],
                                          ),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(
                                            color: const Color(0xFF3B82F6),
                                            width: 3,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  member['name']!,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  member['role']!,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFFDBEAFE),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 10),
                                                Container(
                                                  height: 1,
                                                  color: Colors.white.withOpacity(0.25),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  member['about']!,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    height: 1.5,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                isMobileRange ? SizedBox(height: 12) : isMobileRange ? SizedBox(height: 12) : const Spacer(),
                                                // preserved placeholder row (actual corner circles are positioned)
                                                Row(
                                                  children: [
                                                    Container(width: cornerCircleSize, height: cornerCircleSize, color: Colors.transparent),
                                                    isMobileRange ? SizedBox(height: 12) : isMobileRange ? SizedBox(height: 12) : const Spacer(),
                                                    Container(width: cornerCircleSize, height: cornerCircleSize, color: Colors.transparent),
                                                  ],
                                                ),
                                              ],
                                            ),

                                            // BACK: bottom-right circle (same as front)
                                            Positioned(
                                              bottom: cornerOffset - 4,
                                              right: cornerOffset - 4,
                                              child: Container(
                                                width: cornerCircleSize,
                                                height: cornerCircleSize,
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.5),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),

                                            // BACK: second circle moved to TOP-LEFT (as requested)
                                            Positioned(
                                              top: cornerOffset - 4,
                                              left: cornerOffset - 4,
                                              child: Container(
                                                width: cornerCircleSize,
                                                height: cornerCircleSize,
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.5),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ),
//--------------------------------------------------------//
          const SizedBox(height: 22),

          // Arrow
          const Icon(LucideIcons.arrowDown, size: 20, color: Color(0xFF8B5CF6)),

          const SizedBox(height: 18),

          // Team Structure title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sectionHorizontalPadding),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(colors: [Color(0xFF9333EA), Color(0xFFDB2777)]).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: Text(
                'Our Team Structure',
                style: TextStyle(
                  fontSize: _rFont(context, mobile: 18, tablet: 22, desktop: 32),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Main Card: departments + stats
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sectionHorizontalPadding),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_rFont(context, mobile: 10, tablet: 14, desktop: 24)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 18, offset: const Offset(0, 8))],
                border: Border.all(color: const Color(0xFFE5E7EB).withOpacity(0.8)),
              ),
              padding: EdgeInsets.all(isMobileRange ? 20 : (isTabletRange ? 24 : 28)),
              child: Column(
                children: [
                  // Departments grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: departments.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: departmentCrossAxis,
  crossAxisSpacing: isMobileRange ? 10 : 20,
  mainAxisSpacing: isMobileRange ? 10 : 20,
  childAspectRatio: isMobileRange
      ? 1.0
      : (isLargePhoneRange ? 1.2 : (isTabletRange ? 1.4 : 2.2)),
),

                    itemBuilder: (context, index) {
                      final dept = departments[index];
                      final bool allowHover = !isMobileRange;
                      final bool isHovered = hoveredDept == index && allowHover;
                      return MouseRegion(
                        onEnter: (_) {
                          if (allowHover) setState(() => hoveredDept = index);
                        },
                        onExit: (_) {
                          if (allowHover) setState(() => hoveredDept = null);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  transform: isHovered ? (Matrix4.identity()..scale(1.12)) : Matrix4.identity()..scale(1.0),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(gradient: LinearGradient(colors: dept['color'] as List<Color>), borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6, offset: const Offset(0, 2))]),
                                  child: Icon(dept['icon'] as IconData, color: Colors.white, size: AppSize.iconSm),
                                ),
                                SizedBox(width: AppSpaces.horizontal(context, AppSize.md)),
                                Flexible(
                                  child: Text(
                                    dept['name'].toString(),
                                    style: TextStyle(fontSize: _rFont(context, mobile: 12, tablet: 14, desktop: 16), fontWeight: FontWeight.w600, color: const Color(0xFF111827)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppSpaces.vertical(context, AppSize.xs)),
                            Column(
                              children: (dept['roles'] as List).map<Widget>((role) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 6),
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: hoveredDept == index ? dept['bgColor'] as Color : const Color(0xFFF9FAFB).withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(width: 6, height: 6, decoration: BoxDecoration(color: dept['dotColor'] as Color, borderRadius: BorderRadius.circular(3))),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          role['title']!,
                                          style: TextStyle(fontSize: _rFont(context, mobile: 11, tablet: 13, desktop: 14), color: const Color(0xFF374151)),
                                        ),
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          gradient: hoveredDept == index ? LinearGradient(colors: dept['color'] as List<Color>) : null,
                                          color: hoveredDept == index ? null : const Color(0xFFE5E7EB),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(child: Text(role['count'].toString(), style: TextStyle(fontSize: 10, color: hoveredDept == index ? Colors.white : const Color(0xFF6B7280), fontWeight: FontWeight.bold))),
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // divider
                  Container(height: 1, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, const Color(0xFFD1D5DB), Colors.transparent]))),

                  const SizedBox(height: 16),

                  // Global Team Distribution title + subtitle
                  Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF9333EA), Color(0xFFDB2777)]).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                        child: Text(
                          'Global Team Distribution',
                          style: TextStyle(fontSize: _rFont(context, mobile: 14, tablet: 16, desktop: 24), fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text('Working together across continents', style: TextStyle(fontSize: _rFont(context, mobile: 11, tablet: 12, desktop: 14), color: const Color(0xFF6B7280))),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Stats Grid (adaptive columns)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: statsCrossAxis,
                      crossAxisSpacing: isMobileRange ? 10 : 20,
                      mainAxisSpacing: isMobileRange ? 18 : (isTabletRange ? 20 : 14),
childAspectRatio: isMobileRange ? 1.2 : (isLargePhoneRange ? 1.2 : (isTabletRange ? 1.2 : 1.2)),
                    ),
                    itemBuilder: (context, index) {
                      final stats = [
                        {
                          'icon': LucideIcons.users,
                          'value': '${departments.fold<int>(0, (sum, dept) => sum + (dept['totalMembers'] as int)) + 2}+',
                          'label': 'Total Members',
                          'color': const Color(0xFF2563EB),
                          'bgColor': [const Color(0xFFDBEAFE), const Color(0xFFBFDBFE)],
                        },
                        {
                          'icon': LucideIcons.mapPin,
                          'value': '5+',
                          'label': 'Countries',
                          'color': const Color(0xFF9333EA),
                          'bgColor': [const Color(0xFFF3E8FF), const Color(0xFFE9D5FF)],
                        },
                        {
                          'icon': LucideIcons.brain,
                          'value': '15+',
                          'label': 'Specializations',
                          'color': const Color(0xFFDB2777),
                          'bgColor': [const Color(0xFFFCE7F3), const Color(0xFFFBCFE8)],
                        },
                        {
                          'icon': Icons.public,
                          'value': '24/7',
                          'label': 'Global Coverage',
                          'color': const Color(0xFF06B6D4),
                          'bgColor': [const Color(0xFFCFFAFE), const Color(0xFFA5F3FC)],
                        },
                      ];

                      final stat = stats[index];
                      final bool allowHover = !isMobileRange;
                      final bool isHovered = hoveredStat == index && allowHover;

                      return MouseRegion(
                        onEnter: (_) {
                          if (allowHover) setState(() => hoveredStat = index);
                        },
                        onExit: (_) {
                          if (allowHover) setState(() => hoveredStat = null);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          transform: isHovered ? (Matrix4.identity()..scale(1.06)) : Matrix4.identity()..scale(1.0),
                          padding: EdgeInsets.symmetric(vertical: AppSpaces.vertical(context, AppSize.xs)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: isMobileRange ? 46 : 56,
                                height: isMobileRange ? 46 : 56,
                                decoration: BoxDecoration(gradient: LinearGradient(colors: stat['bgColor'] as List<Color>), borderRadius: BorderRadius.circular(28), boxShadow: isHovered ? [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 6))] : null),
                                child: Icon(stat['icon'] as IconData, color: stat['color'] as Color, size: isMobileRange ? AppSize.iconSm : AppSize.iconMd),
                              ),
                              SizedBox(height: AppSpaces.vertical(context, AppSize.sm)),
                              Text(
                                stat['value'].toString(),
                                style: TextStyle(
                                  fontSize: _rFont(context, mobile: 16, tablet: 18, desktop: 24),
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()..shader = LinearGradient(colors: [stat['color'] as Color, _getNextColor(stat['color'] as Color)]).createShader(const Rect.fromLTWH(0, 0, 50, 30)),
                                ),
                              ),
                              SizedBox(height: AppSpaces.vertical(context, AppSize.xs)),
                              Text(stat['label'].toString(), style: TextStyle(fontSize: _rFont(context, mobile: 10, tablet: 11, desktop: 12), color: const Color(0xFF6B7280))),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    // If mobile, wrap the whole section in a scrollable to prevent overflow on small screens
    if (isMobileRange) {
      return SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: sectionContainer,
        ),
      );
    }

    return sectionContainer;
  }

  Color _getNextColor(Color baseColor) {
    // Slightly darker shade for gradient
    return Color.fromARGB(
      baseColor.alpha,
      (baseColor.red * 0.8).clamp(0, 255).toInt(),
      (baseColor.green * 0.8).clamp(0, 255).toInt(),
      (baseColor.blue * 0.8).clamp(0, 255).toInt(),
    );
  }
}
