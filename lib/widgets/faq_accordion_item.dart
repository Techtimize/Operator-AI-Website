import 'package:flutter/material.dart';

class FaqAccordionItem extends StatefulWidget {
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onTap;

  const FaqAccordionItem({
    super.key,
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  State<FaqAccordionItem> createState() => _FaqAccordionItemState();
}

class _FaqAccordionItemState extends State<FaqAccordionItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          constraints: BoxConstraints(
            maxWidth: isMobile ? screenWidth - 32 : 604,
          ),
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -4.0 : 0.0),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFFF0F9FF) // Lighter blue on hover
                : Colors.white, // White default
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _getBorderColor(), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _isHovered ? 0.15 : 0.05),
                blurRadius: _isHovered ? 16 : 8,
                offset: Offset(0, _isHovered ? 8 : 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 16 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuestionRow(),
                if (widget.isExpanded) ...[
                  const SizedBox(height: 16),
                  _buildAnswer(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBorderColor() {
    if (widget.isExpanded && _isHovered) {
      return const Color(0xFF2563EB); // Blue when expanded AND hovered
    } else if (_isHovered) {
      return const Color(0xFF2563EB); // Blue on hover (closed state)
    } else {
      return const Color(0xFFE5E7EB); // Light gray default
    }
  }

  Widget _buildQuestionRow() {
    return Row(
      children: [
        _buildQuestionIcon(),
        const SizedBox(width: 16),
        Expanded(child: _buildQuestionText()),
        const SizedBox(width: 16),
        _buildChevronIcon(),
      ],
    );
  }

  Widget _buildQuestionIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: (widget.isExpanded && _isHovered) || _isHovered
            ? const Color(0xFF2563EB)
            : const Color(0xFFE0F2FE),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.help_outline, color: Colors.white, size: 20),
    );
  }

  Widget _buildQuestionText() {
    return Text(
      widget.question,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: _isHovered
            ? const Color(0xFF1E40AF) // Dark blue on hover
            : const Color(0xFF1F2937), // Default dark gray
        height: 1.4,
      ),
    );
  }

  Widget _buildChevronIcon() {
    return AnimatedRotation(
      duration: const Duration(milliseconds: 200),
      turns: widget.isExpanded ? 0.5 : 0,
      child: Icon(
        Icons.keyboard_arrow_down,
        color: (widget.isExpanded && _isHovered) || _isHovered
            ? const Color(0xFF2563EB)
            : const Color(0xFF6B7280),
        size: 24,
      ),
    );
  }

  Widget _buildAnswer() {
    return Text(
      widget.answer,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF6B7280),
        height: 1.6,
      ),
    );
  }
}
