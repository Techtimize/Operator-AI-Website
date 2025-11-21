import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// adjust these imports if your project path differs
import 'package:new_public_website/utils/app_reponsiveness/app_spaces.dart';
import 'package:new_public_website/utils/app_reponsiveness/responsive_utils.dart';
import 'package:new_public_website/utils/app_reponsiveness/size_utils.dart';

class NewsletterSection extends StatefulWidget {
  const NewsletterSection({super.key});

  @override
  State<NewsletterSection> createState() => _NewsletterSectionState();
}

class _NewsletterSectionState extends State<NewsletterSection> {
  final TextEditingController _emailController = TextEditingController();
  bool _btnHovered = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool get _isMobile => ResponsiveUtils.isMobile(context);
  bool get _isTablet => ResponsiveUtils.isTablet(context);
  bool get _isDesktop => ResponsiveUtils.isDesktop(context);

  double _titleSize() {
    final base = 28.0;
    return ResponsiveUtils.getResponsiveFontSize(context, base);
  }

  double _subSize() {
    final base = 16.0;
    return ResponsiveUtils.getResponsiveFontSize(context, base);
  }

  @override
  Widget build(BuildContext context) {
    final hPad = AppSpaces.horizontal(context, 24);
    final vPad = AppSpaces.vertical(context, 24);

    // DESKTOP: width 1216, height 324 per request
    final containerMaxWidth = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: MediaQuery.of(context).size.width * 0.96,
      tablet: 920,
      desktop: 1500,
    );

    // determine explicit height only for desktop
    final double? containerHeight = ResponsiveUtils.isDesktop(context) ? 324.0 : null;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: vPad),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: containerMaxWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Container(
                // FIXED HEIGHT on desktop, auto on mobile/tablet
                height: containerHeight,

                // match screenshot gradient
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF2C7BFF), // top-left
                      Color(0xFF1E61D9), // mid
                      Color(0xFF1A4FC2), // bottom-right
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),

                // Use a Stack so Positioned.fill is valid and the shadow can overlap content
                child: Stack(
                  children: [
                    // main centered content
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppSpaces.vertical(context, 32),
                          horizontal: AppSpaces.horizontal(context, 28),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // mail icon circle
                            SizedBox(
                              width: 54,
                              height: 54,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 54,
                                    height: 54,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.14),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.08),
                                      ),
                                    ),
                                  ),
                                  ClipOval(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                      child: Container(width: 54, height: 54, color: Colors.transparent),
                                    ),
                                  ),
                                  const Icon(
  LucideIcons.mail,
  color: Colors.white,
  size: 22,
),
                                ],
                              ),
                            ),

                            SizedBox(height: AppSpaces.vertical(context, 12)),

                            // title
                            Text(
                              'Stay Ahead with AI Innovation',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: _titleSize(),
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                height: 1.0,
                                shadows: [
                                  Shadow(color: Colors.black.withOpacity(0.25), blurRadius: 8),
                                ],
                              ),
                            ),

                            SizedBox(height: AppSpaces.vertical(context, 2)),

                            // subtitle
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 760),
                              child: Text(
                                'Get exclusive insights, latest updates, and expert tips delivered straight to your inbox.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: _subSize(),
                                  color: Colors.white.withOpacity(0.95),
                                  height: 1.5,
                                  shadows: [
                                    Shadow(color: Colors.black.withOpacity(0.12), blurRadius: 6),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: AppSpaces.vertical(context, 18)),

                            // input + button (row on wide screens, stacked on mobile)
                            LayoutBuilder(builder: (context, constraints) {
                              final stacked = _isMobile || constraints.maxWidth < 560;
                              final inputHeight = _isMobile ? 50.0 : 56.0;
                              final buttonHeight = inputHeight;

                              return ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 920),
                                child: Flex(
                                  direction: stacked ? Axis.vertical : Axis.horizontal,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // input
                                    Flexible(
                                      flex: stacked ? 0 : 1,
                                      child: Container(
                                        height: inputHeight,
                                        margin: EdgeInsets.only(right: stacked ? 0 : 14, bottom: stacked ? 12 : 0),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.98),
                                          borderRadius: BorderRadius.circular(999),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.14),
                                              blurRadius: 22,
                                              offset: const Offset(0, 8),
                                            )
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  controller: _emailController,
                                                  keyboardType: TextInputType.emailAddress,
                                                  style: const TextStyle(color: Colors.black87, fontSize: 15),
                                                  decoration: const InputDecoration(
                                                    hintText: 'Enter your email address',
                                                    hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                                                    border: InputBorder.none,
                                                    isCollapsed: true,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    // button
                                    SizedBox(
                                      height: buttonHeight,
                                      child: MouseRegion(
                                        onEnter: (_) => setState(() => _btnHovered = true),
                                        onExit: (_) => setState(() => _btnHovered = false),
                                        cursor: SystemMouseCursors.click,
                                        child: AnimatedScale(
                                          duration: const Duration(milliseconds: 160),
                                          scale: _btnHovered && !_isMobile ? 1.05 : 1.0,
                                          child: Container(
                                            margin: EdgeInsets.only(left: stacked ? 0 : 12),
                                            padding: EdgeInsets.symmetric(horizontal: _isMobile ? 18 : 24),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(999),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.16),
                                                  blurRadius: 22,
                                                  offset: const Offset(0, 8),
                                                )
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Subscribe Now',
                                                style: TextStyle(
                                                  color: const Color(0xFF1E60D9),
                                                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 15),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),

                            SizedBox(height: AppSpaces.vertical(context, 10)),

                            // small helper text below
                            Text(
                              'Join 10,000+ professionals staying updated on AI trends',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                                color: Colors.white.withOpacity(0.80),
                              ),
                            ),

                            SizedBox(height: AppSpaces.vertical(context, 6)),
                          ],
                        ),
                      ),
                    ),

                    // bottom soft drop shadow (to mimic screenshot's dark vignette)
                    // Keep Positioned.fill inside Stack (last so it overlays on top)
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: IgnorePointer(
                          child: Container(
                            height: 36,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black.withOpacity(0.02)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
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
        ),
      ),
    );
  }

  void _onSubscribe() {
    final email = _emailController.text.trim();
    if (email.isEmpty || !RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$").hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Subscribed with $email')),
    );

    _emailController.clear();
  }
}
