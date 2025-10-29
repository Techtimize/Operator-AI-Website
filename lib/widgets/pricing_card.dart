import 'package:flutter/material.dart';
import 'package:new_public_website/utils/app_reponsiveness/app_spaces.dart';

class PricingCard extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final String? description;

  final Color? titleColor;
  final Color? subtitleColor;
  final Color? descriptionColor;

  final Color backgroundColor;
  final Color borderColor;
  final Color focusBorderColor;
  final Color? hoverBorderColor;

  final double width;
  final double height;

  final bool showBadge;
  final String? badgeText;
  final Color? badgeColor;
  final Color? badgeTextColor;

  final VoidCallback? onTap;
  final bool isSelected;

  final Color? hoverColor;
  final bool? isHover;

  const PricingCard({
    super.key,
    this.title,
    this.subtitle,
    this.description,
    this.titleColor,
    this.subtitleColor,
    this.descriptionColor,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFE0E0E0),
    this.focusBorderColor = Colors.blue,
    this.hoverBorderColor,
    this.width = 240,
    this.height = 190,
    this.showBadge = false,
    this.badgeText,
    this.badgeColor,
    this.badgeTextColor = Colors.white,
    this.onTap,
    this.isSelected = false,
    this.hoverColor,
    this.isHover,
  });

  @override
  State<PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<PricingCard> {
  bool _hovering = false;
  bool _selected = false;

  bool get _effectiveHover => widget.isHover ?? _hovering;

  void _handleTap() {
    setState(() => _selected = !_selected);
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.isSelected || _selected;

    final Color effectiveBorderColor = isSelected
        ? widget.focusBorderColor
        : (_effectiveHover
            ? (widget.hoverBorderColor ?? widget.focusBorderColor)
            : widget.borderColor);

    final Color effectiveBgColor = _effectiveHover
        ? (widget.hoverColor ?? widget.focusBorderColor.withOpacity(0.05))
        : widget.backgroundColor;

    return MouseRegion(
      onEnter: (_) {
        if (widget.isHover == null) setState(() => _hovering = true);
      },
      onExit: (_) {
        if (widget.isHover == null) setState(() => _hovering = false);
      },
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedScale(
          scale: _effectiveHover ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            width: widget.width,
            height: widget.height, // 👈 keeps all cards same height
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            decoration: BoxDecoration(
              color: effectiveBgColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: effectiveBorderColor,
                width: 2,
              ),
              boxShadow: [
                if (_effectiveHover || isSelected)
                  BoxShadow(
                    color: effectiveBorderColor.withOpacity(0.18),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Column(
              children: [
                // content area (scrollable but fixed height)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppSpaces.verticalBox(context,10),
                        if (widget.title?.isNotEmpty ?? false)
                          Text(
                            widget.title!,
                            style: TextStyle(
                              color: widget.titleColor ?? Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        if (widget.subtitle?.isNotEmpty ?? false) ...[
                         AppSpaces.verticalBox(context,10),
                          Text(
                            widget.subtitle!,
                            style: TextStyle(
                              color: widget.subtitleColor ?? Colors.grey[700],
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        if (widget.description?.isNotEmpty ?? false) ...[
                           AppSpaces.verticalBox(context,12),
                          Text(
                            widget.description!,
                            style: TextStyle(
                              color:
                                  widget.descriptionColor ?? Colors.grey[600],
                              fontSize: 14,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // badge (fixed at bottom)
                if (widget.showBadge && widget.badgeText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: widget.badgeColor ?? widget.focusBorderColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.badgeText!,
                        style: TextStyle(
                          color: widget.badgeTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
