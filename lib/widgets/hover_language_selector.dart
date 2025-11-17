import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'hover_mixin.dart';

class HoverLanguageSelector extends StatefulWidget {
  final String selectedLanguageCode;
  final Function(String)? onLanguageChanged;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const HoverLanguageSelector({
    super.key,
    this.selectedLanguageCode = 'GB',
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

  final Map<String, String> _languageMap = {
    'GB': 'English',
    'ES': 'Spanish',
    'FR': 'French',
    'DE': 'German',
    'IT': 'Italian',
  };

  late String _selectedCode;

  @override
  void initState() {
    super.initState();
    _selectedCode = widget.selectedLanguageCode;
  }

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
  final screenWidth = MediaQuery.of(context).size.width;

  double dropdownWidth = size.width; // initial width
  double leftPosition = offset.dx-60;

  // agar dropdown screen ke right edge se bahar ja raha ho to adjust kar do
  if (leftPosition + dropdownWidth > screenWidth - 10) {
    leftPosition = screenWidth - dropdownWidth - 10;
  }

  _overlayEntry = OverlayEntry(
    builder: (context) => GestureDetector(
      onTap: _hideOverlay,
      child: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.transparent)),
          Positioned(
            top: offset.dy + size.height + 5,
            left: leftPosition,
            child: Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              child: Container(
                width: dropdownWidth,
                constraints: const BoxConstraints(minWidth: 140, maxWidth: 220),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFF60A5FA),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _languageMap.entries.map((entry) {
                    final isSelected = entry.key == _selectedCode;
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _selectLanguage(entry.key),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFF3F4F6)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/flags/${entry.key.toLowerCase()}.svg',
                                width: 24,
                                height: 16,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                entry.value,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: isSelected
                                      ? const Color(0xFF2563EB)
                                      : const Color(0xFF424242),
                                ),
                              ),
                            ],
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

  void _selectLanguage(String code) {
    _hideOverlay();
    setState(() {
      _selectedCode = code;
    });
    widget.onLanguageChanged?.call(code);
  }

  @override
  void onHoverExit() {
    super.onHoverExit();
  }

  @override
  Widget build(BuildContext context) {
    return buildHoverWrapper(
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: AnimatedBuilder(
          animation: colorAnimation,
          builder: (context, child) {
            final normalColor =
                widget.backgroundColor ?? const Color(0xFFEFF6FF);
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                    widget.borderColor ?? const Color(0xFFDBEAFE),
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/flags/${_selectedCode.toLowerCase()}.svg',
                    width: 24,
                    height: 16,
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _isDropdownOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Color.lerp(
                      const Color(0xFF155DFC),
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
