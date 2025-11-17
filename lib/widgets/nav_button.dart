import 'package:flutter/material.dart';
import 'hover_mixin.dart';

class NavButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isActive;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const NavButton({
    super.key,
    required this.text,
    this.onTap,
    this.isActive = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton>
    with SingleTickerProviderStateMixin, HoverMixin {
  @override
  Widget build(BuildContext context) {
    return buildHoverWrapper(
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: colorAnimation,
          builder: (context, child) {
            // Interpolate between normal color and gradient colors
            final normalColor = widget.isActive
                ? const Color(0xFF2563EB)
                : (widget.backgroundColor ?? Colors.white);

            final startColor = Color.lerp(
              normalColor,
              const Color(0xFF2563EB),
              colorAnimation.value,
            )!;
            final endColor = Color.lerp(
              normalColor,
              const Color(0xFF1E3A8A),
              colorAnimation.value,
            )!;

            return Container(
              height: 39.2,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                gradient: colorAnimation.value > 0.0
                    ? LinearGradient(
                        colors: [startColor, endColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: colorAnimation.value > 0.0 ? null : normalColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color.lerp(
                    widget.isActive
                        ? const Color(0xFF1976D2)
                        : const Color(
                            0xFF60A5FA,
                          ), // Default border color (blue-400)
                    const Color(0xFF2563EB), // Hover border color (blue-600)
                    colorAnimation.value,
                  )!,
                  width: 2.0 + (0.5 * colorAnimation.value),
                ),
                boxShadow: colorAnimation.value > 0.0
                    ? [
                        BoxShadow(
                          color: const Color(
                            0xFF2563EB,
                          ).withValues(alpha: 0.3 * colorAnimation.value),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Color.lerp(
                      widget.isActive
                          ? Colors.white
                          : (widget.textColor ?? const Color(0xFF424242)),
                      Colors.white,
                      colorAnimation.value,
                    ),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
