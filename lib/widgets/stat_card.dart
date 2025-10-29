import 'package:flutter/material.dart';

class StatCard extends StatefulWidget {
  final String value;
  final String label;
  final Color accentColor;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.accentColor,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -8.0 : 0.0),
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.accentColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.accentColor.withValues(
                alpha: _isHovered ? 0.25 : 0.15,
              ),
              blurRadius: _isHovered ? 24 : 12,
              offset: Offset(0, _isHovered ? 12 : 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              widget.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 32 : 40,
                fontWeight: FontWeight.bold,
                color: widget.accentColor,
              ),
            ),
            SizedBox(height: isMobile ? 6 : 8),
            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 13 : 14,
                color: const Color(0xFF424242),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
