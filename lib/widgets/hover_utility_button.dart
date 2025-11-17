import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'hover_mixin.dart';
import '../responsiveness/responsive.dart'; // optional if you want responsive sizes

class HoverUtilityButton extends StatefulWidget {
  final String assetPath; // Can be SVG or PNG
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;

  const HoverUtilityButton({
    super.key,
    required this.assetPath,
    this.onTap,
    this.width = 38,
    this.height = 38,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
  });

  @override
  State<HoverUtilityButton> createState() => _HoverUtilityButtonState();
}

class _HoverUtilityButtonState extends State<HoverUtilityButton>
    with SingleTickerProviderStateMixin, HoverMixin {
  @override
  Widget build(BuildContext context) {
    return buildHoverWrapper(
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: colorAnimation,
          builder: (context, child) {
            final normalColor = widget.backgroundColor ?? const Color(0xFFEFF6FF);
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
              width: widget.width,
              height: widget.height,
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
                    widget.borderColor ?? const Color(0xFFBEDBFF),
                    const Color(0xFF2563EB),
                    colorAnimation.value,
                  )!,
                  width: 2.0 + (0.5 * colorAnimation.value),
                ),
                boxShadow: colorAnimation.value > 0.0
                    ? [
                        BoxShadow(
                          color: const Color(0xFF2563EB)
                              .withOpacity(0.3 * colorAnimation.value),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: widget.assetPath.toLowerCase().endsWith('.svg')
                  ? SvgPicture.asset(
                      widget.assetPath,
                      color: Color.lerp(
                        widget.iconColor ?? const Color(0xFF155DFC),
                        Colors.white,
                        colorAnimation.value,
                      ),
                      fit: BoxFit.scaleDown,
                      width: context.rw(10),
                      height: context.rh(10),
                    )
                  : ImageIcon(
                      AssetImage(widget.assetPath),
                      color: Color.lerp(
                        widget.iconColor ?? const Color(0xFF155DFC),
                        Colors.white,
                        colorAnimation.value,
                      ),
                      size: context.rw(10),
                    ),
            );
          },
        ),
      ),
    );
  }
}
