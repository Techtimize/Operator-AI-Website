import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NewsRelease extends StatefulWidget {
  const NewsRelease({super.key});

  @override
  State<NewsRelease> createState() => _NewsReleaseState();
}

class _NewsReleaseState extends State<NewsRelease> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _btnHovered = false;

  // Animation controller for floating dots pattern
  late final AnimationController _dotsController;

  // Your responsive helpers
  bool isMobileRange(double w) => w < 640;
  bool isTabletRange(double w) => w >= 640 && w < 1024;
  bool isDesktopRange(double w) => w >= 1024;

  @override
  void initState() {
    super.initState();
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(); // infinite float animation
  }

  @override
  void dispose() {
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
        ),
      ),
      child: Center(
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF9810FA),
                  Color(0xFFE60076),
                  Color(0xFFFF6900),
                ],
                stops: [0.0, 0.5, 1.0],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(_isHovered ? 0.20 : 0.12),
                  blurRadius: _isHovered ? 40 : 28,
                  spreadRadius: 2,
                  offset: Offset(0, _isHovered ? 14 : 10),
                )
              ],
            ),
            child: Stack(
              children: [
                // ------------------ DOTS PATTERN (replaces the image) ------------------
                // We draw a repeating dot pattern via CustomPainter and animate its offset.
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.20,
                    child: IgnorePointer(
                      // AnimatedBuilder rebuilds the CustomPaint with the changing offset
                      child: AnimatedBuilder(
                        animation: _dotsController,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: _DotPatternPainter(
                              progress: _dotsController.value,
                              dotRadius: 1.5,       // matches CSS sample (1.5px)
                              spacing: 40.0,        // matches CSS sample (40px grid)
                              color: Colors.white.withOpacity(0.95),
                            ),
                            child: const SizedBox.expand(),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Floating circles
                // Positioned(
                //   top: 20,
                //   right: 60,
                //   child: Container(
                //     width: 90,
                //     height: 90,
                //     decoration: BoxDecoration(
                //       color: Colors.white.withOpacity(0.10),
                //       borderRadius: BorderRadius.circular(100),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.white.withOpacity(0.25),
                //           blurRadius: 50,
                //           spreadRadius: 10,
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // Positioned(
                //   bottom: 30,
                //   left: 60,
                //   child: Container(
                //     width: 60,
                //     height: 60,
                //     decoration: BoxDecoration(
                //       color: Colors.yellow.withOpacity(0.20),
                //       borderRadius: BorderRadius.circular(100),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.yellow.withOpacity(0.30),
                //           blurRadius: 40,
                //         )
                //       ],
                //     ),
                //   ),
                // ),

                // Content Row
                Padding(
                padding: const EdgeInsets.fromLTRB(26, 26, 26, 36),
                  child: isMobileRange(w)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildIcon(),
                            const SizedBox(height: 20),
                            _buildTextSection(),
                            const SizedBox(height: 24),
                            _buildButton(),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildIcon(),
                            const SizedBox(width: 20),
                            Expanded(child: _buildTextSection()),
                            const SizedBox(width: 20),
                            _buildButton(),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------ ICON SECTION ------------------------
  Widget _buildIcon() {
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.28),
                borderRadius: BorderRadius.circular(200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.30),
                    blurRadius: 30,
                  )
                ],
              ),
            ),
          ),
          Center(
            child: AnimatedScale(
              scale: _isHovered ? 1.10 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(200),
                  border: Border.all(color: Colors.white.withOpacity(0.40), width: 2),
                ),
                child: Center(
  child: Icon(
    LucideIcons.newspaper,
    size: 34,
    color: Colors.white,
  ),
),

              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------ TEXT SECTION ------------------------
  Widget _buildTextSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category & Date
        Row(
          children: [
            _pill(Icons.label, "Product Launch"),
            const SizedBox(width: 8),
            _date(Icons.calendar_today, "January 15, 2025"),
          ],
        ),

        const SizedBox(height: 24),

        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          style: TextStyle(
            fontSize: 22,
            color: _isHovered ? const Color(0xFFFFF9C4) : Colors.white,
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 1),
                blurRadius: 6,
              )
            ],
          ),
          child: const Text(
            "Latest News: Opperator AI Launches Revolutionary AI Receptionist Suite,",style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          "Dubai-based Opperator AI unveils next-generation AI Receptionist platform with human-like voice interactions",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _pill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.22),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white.withOpacity(0.30)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _date(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.white70),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  // ------------------------ BUTTON SECTION ------------------------
  Widget _buildButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => _btnHovered = true),
      onExit: (_) => setState(() => _btnHovered = false),
      child: AnimatedScale(
        scale: _btnHovered ? 1.05 : 1,
        duration: const Duration(milliseconds: 200),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          decoration: BoxDecoration(
            color: _btnHovered ? const Color(0xFFFFF9C4) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.20), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 30,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Row(
            children: [
              Text(
                "Read More",
                style: TextStyle(
                  color: _btnHovered ? Colors.purple.shade700 : Colors.purple.shade600,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedPadding(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.only(left: _btnHovered ? 6 : 0),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: Colors.purple.shade600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom painter that draws a repeating dot pattern and supports an animated offset.
/// - progress: 0..1 value to shift pattern for smooth floating animation
class _DotPatternPainter extends CustomPainter {
  final double progress;
  final double dotRadius;
  final double spacing;
  final Color color;

  _DotPatternPainter({
    required this.progress,
    this.dotRadius = 1.5,
    this.spacing = 40.0,
    this.color = const Color(0xFFFFFFFF),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    // Offset the pattern by progress so it appears to float/move
    final dx = (progress * spacing) % spacing;
    final dy = (progress * spacing * 0.45) % spacing; // subtle vertical drift

    // Start slightly negative so edge dots fill smoothly
    final startX = -spacing + -dx;
    final startY = -spacing + -dy;

    for (double x = startX; x < size.width + spacing; x += spacing) {
      for (double y = startY; y < size.height + spacing; y += spacing) {
        canvas.drawCircle(Offset(x + dx, y + dy), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotPatternPainter old) {
    return old.progress != progress || old.dotRadius != dotRadius || old.spacing != spacing || old.color != color;
  }
}
