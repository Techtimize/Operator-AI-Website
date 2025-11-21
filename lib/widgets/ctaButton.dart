import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:new_public_website/utils/app_reponsiveness/size_utils.dart';
import 'package:new_public_website/utils/app_reponsiveness/app_spaces.dart';
import 'package:new_public_website/utils/app_reponsiveness/responsive_utils.dart';

class CtaButton extends StatefulWidget {
  final String title;
  final Color? color;
  final Gradient? gradient;
  final VoidCallback onPressed;

  const CtaButton({
     required this.title,
    required this.onPressed,
    this.color,
    this.gradient,
    super.key,
  });

  @override
  State<CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<CtaButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double desiredWidth = _getButtonWidth(context);

        final double? finalWidth =
            desiredWidth.isNaN
                ? null // desktop/tablet = auto width
                : desiredWidth == double.infinity
                    ? constraints.maxWidth // mobile full width
                    : math.min(desiredWidth, constraints.maxWidth);

        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedScale(
            scale: _isHovered ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: GestureDetector(
              onTap: widget.onPressed,
              child: Container(
                width: finalWidth,
                height: _getButtonHeight(context),
                padding: _getButtonPadding(context),

                decoration: BoxDecoration(
                  gradient: widget.gradient ??
                      (widget.color == null
                          ? const LinearGradient(
                              colors: [
                                Color(0xFF2F6FFF),
                                Color(0xFF8A2BE2),
                              ],
                              stops: [0.0, 1.5],
                            )
                          : null),
                  color: widget.gradient == null ? widget.color : null,
                  borderRadius: BorderRadius.circular(_getBorderRadius(context)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(_isHovered ? 0.4 : 0.3),
                      blurRadius: _isHovered ? 12 : 8,
                      offset: Offset(0, _isHovered ? 6 : 4),
                    ),
                  ],
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TEXT — no truncation on desktop/tablet
                    Flexible(
                      child: Text(
                        widget.title,
                        overflow: ResponsiveUtils.isMobile(context)
                            ? TextOverflow.ellipsis
                            : TextOverflow.visible,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: _getFontSize(context),
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(width: _getIconSpacing(context)),

                    AnimatedSlide(
                      offset: _isHovered ? const Offset(0.15, 0) : Offset.zero,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: _getIconSize(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // --------------------------------------------------------
  // RESPONSIVE LOGIC
  // --------------------------------------------------------

  /// WIDTH
  double _getButtonWidth(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return double.infinity; // full width
    }
    return double.nan; // desktop/tablet auto width
  }

  /// HEIGHT
  double _getButtonHeight(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return AppSpaces.vertical(context, 48);
    } else if (ResponsiveUtils.isTablet(context)) {
      return 44.0;
    } else {
      return 48.0;
    }
  }

  /// PADDING
  EdgeInsets _getButtonPadding(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return AppSpaces.customPadding(context, h: 20, v: 14);
    } else if (ResponsiveUtils.isTablet(context)) {
      return AppSpaces.customPadding(context, h: 28, v: 12);
    } else {
      return AppSpaces.customPadding(context, h: 34, v: 0);
    }
  }

  /// FONT SIZE
  double _getFontSize(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) return 14;
    if (ResponsiveUtils.isTablet(context)) return 15;
    return 16;
  }

  /// ICON SIZE
  double _getIconSize(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) return 18;
    if (ResponsiveUtils.isTablet(context)) return 19;
    return 20;
  }

  /// SPACING
  double _getIconSpacing(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) return 6;
    if (ResponsiveUtils.isTablet(context)) return 7;
    return 8;
  }

  /// BORDER RADIUS
  double _getBorderRadius(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) return 10;
    if (ResponsiveUtils.isTablet(context)) return 11;
    return 12;
  }
}
