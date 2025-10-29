import 'package:flutter/material.dart';
import 'hover_mixin.dart';

class HoverLanguageSelector extends StatefulWidget {
  final String selectedLanguage;
  final Function(String)? onLanguageChanged;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const HoverLanguageSelector({
    super.key,
    this.selectedLanguage = 'English',
    this.onLanguageChanged,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  State<HoverLanguageSelector> createState() => _HoverLanguageSelectorState();
}

class _HoverLanguageSelectorState extends State<HoverLanguageSelector>
    with SingleTickerProviderStateMixin, HoverMixin {
  bool _isDropdownOpen = false;
  OverlayEntry? _overlayEntry;
  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Italian',
  ];

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _hideOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _hideOverlay,
        child: Stack(
          children: [
            // Invisible overlay to catch taps
            Positioned.fill(child: Container(color: Colors.transparent)),
            // Dropdown positioned relative to the button
            Positioned(
              top: offset.dy + size.height + 5,
              left: offset.dx,
              child: Material(
                elevation: 20,
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF60A5FA),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _languages.map((language) {
                      final isSelected = language == widget.selectedLanguage;
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _selectLanguage(language),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFF3F4F6)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              language,
                              style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFF2563EB)
                                    : const Color(0xFF424242),
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  @override
  void onHoverExit() {
    // Always allow hover exit - the lift effect should disappear when mouse leaves the button
    super.onHoverExit();
  }

  void _selectLanguage(String language) {
    _hideOverlay();
    widget.onLanguageChanged?.call(language);
  }

  @override
  Widget build(BuildContext context) {
    return buildHoverWrapper(
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: AnimatedBuilder(
          animation: colorAnimation,
          builder: (context, child) {
            final normalColor = widget.backgroundColor ?? Colors.white;
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                    widget.borderColor ??
                        const Color(
                          0xFF60A5FA,
                        ), // Default border color (blue-400)
                    const Color(0xFF2563EB), // Hover border color (blue-600)
                    colorAnimation.value,
                  )!,
                  width: 1.0 + (0.5 * colorAnimation.value),
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.language,
                    color: Color.lerp(
                      const Color(0xFF424242),
                      Colors.white,
                      colorAnimation.value,
                    ),
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    widget.selectedLanguage,
                    style: TextStyle(
                      color: Color.lerp(
                        widget.textColor ?? const Color(0xFF424242),
                        Colors.white,
                        colorAnimation.value,
                      ),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _isDropdownOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Color.lerp(
                      const Color(0xFF424242),
                      Colors.white,
                      colorAnimation.value,
                    ),
                    size: 16,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
