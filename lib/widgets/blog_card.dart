import 'package:flutter/material.dart';
import '../models/content_item.dart';

class ContentCard extends StatefulWidget {
  final ContentItem contentItem;

  const ContentCard({super.key, required this.contentItem});

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
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
        width: isMobile ? screenWidth - 32 : 389.33, // Responsive width
        height: isMobile ? 500 : 538, // Slightly shorter on mobile
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.2 : 0.1),
              blurRadius: _isHovered ? 20 : 10,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -8.0 : 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(isMobile),
            Expanded(child: _buildContentSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(bool isMobile) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: _buildImage(isMobile),
        ),
        _buildCategoryTag(),
      ],
    );
  }

  Widget _buildImage(bool isMobile) {
    final String path = widget.contentItem.imagePath.trim();
    final double h = isMobile ? 200 : 250;

    if (path.isNotEmpty && path.startsWith('http')) {
      return Image.network(
        path,
        width: double.infinity,
        height: h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildRandomImage(h),
      );
    }

    if (path.isNotEmpty) {
      return Image.asset(
        path,
        width: double.infinity,
        height: h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildRandomImage(h),
      );
    }

    return _buildRandomImage(h);
  }

  Widget _buildRandomImage(double height) {
    // Use a seeded random image so it remains consistent per card
    final seed = widget.contentItem.title.hashCode & 0x7fffffff;
    final url = 'https://picsum.photos/seed/$seed/800/500';
    return Image.network(
      url,
      width: double.infinity,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          _buildImagePlaceholder(height <= 200),
    );
  }

  Widget _buildCategoryTag() {
    return Positioned(
      top: 12,
      left: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF2563EB),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          widget.contentItem.category,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(bool isMobile) {
    return Container(
      width: double.infinity,
      height: isMobile ? 200 : 250, // Match image height
      decoration: const BoxDecoration(
        color: Color(0xFFF3F4F6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: const Center(
        child: Icon(Icons.image, size: 48, color: Color(0xFF9CA3AF)),
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMetadata(),
          const SizedBox(height: 12),
          _buildTitle(),
          const SizedBox(height: 12),
          Expanded(child: _buildDescription()),
          const SizedBox(height: 16),
          _buildReadButton(),
        ],
      ),
    );
  }

  Widget _buildMetadata() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_today,
              size: 14,
              color: Color(0xFF9CA3AF),
            ),
            const SizedBox(width: 6),
            Text(
              widget.contentItem.date,
              style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.person, size: 14, color: Color(0xFF9CA3AF)),
            const SizedBox(width: 6),
            Text(
              widget.contentItem.author,
              style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.contentItem.title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1F2937),
        height: 1.3,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      widget.contentItem.description,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF6B7280),
        height: 1.5,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildReadButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        gradient: _isHovered
            ? const LinearGradient(
                colors: [Color(0xFF1D4ED8), Color(0xFF1E40AF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'Read Full Article',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
