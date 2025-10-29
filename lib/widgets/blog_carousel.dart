import 'package:flutter/material.dart';
import '../models/content_item.dart';
import 'content_card.dart';

class ContentCarousel extends StatefulWidget {
  final List<ContentItem> contentItems;

  const ContentCarousel({super.key, required this.contentItems});

  @override
  State<ContentCarousel> createState() => _ContentCarouselState();
}

class _ContentCarouselState extends State<ContentCarousel> {
  int _currentIndex = 0;
  late PageController _pageController;
  double _lastScreenWidth = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    // Reset PageController when screen size changes
    if (_lastScreenWidth != screenWidth) {
      _lastScreenWidth = screenWidth;
      _currentIndex = 0;
      _pageController.dispose();
      _pageController = PageController();
    }

    return Column(
      children: [
        _buildCarousel(isMobile, isTablet),
        const SizedBox(height: 24),
        _buildNavigationControls(),
      ],
    );
  }

  Widget _buildCarousel(bool isMobile, bool isTablet) {
    int cardsPerView;
    int maxIndex;

    if (isMobile) {
      cardsPerView = 1;
      maxIndex = widget.contentItems.length - 1;
    } else if (isTablet) {
      cardsPerView = 2;
      maxIndex = widget.contentItems.length - 2;
    } else {
      cardsPerView = 3;
      maxIndex = widget.contentItems.length - 3;
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 1232),
      padding: EdgeInsets.only(
        bottom: isMobile
            ? 60
            : 30, // Much more bottom padding for mobile shadow visibility
      ),
      child: SizedBox(
        height: isMobile ? 560 : 600, // Increased height to accommodate padding
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemCount: maxIndex + 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 16),
              child: isMobile
                  ? ContentCard(
                      contentItem: widget.contentItems[index],
                    ) // Single card on mobile
                  : Row(
                      children: List.generate(cardsPerView, (cardIndex) {
                        final postIndex = index + cardIndex;
                        if (postIndex >= widget.contentItems.length) {
                          return const SizedBox.shrink();
                        }

                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ContentCard(
                              contentItem: widget.contentItems[postIndex],
                            ),
                          ),
                        );
                      }),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavigationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPreviousButton(),
        const SizedBox(width: 16),
        _buildPaginationDots(),
        const SizedBox(width: 16),
        _buildNextButton(),
      ],
    );
  }

  Widget _buildPreviousButton() {
    final isFirstPage = _currentIndex == 0;

    return GestureDetector(
      onTap: isFirstPage
          ? null
          : () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isFirstPage ? const Color(0xFFF3F4F6) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isFirstPage
                ? const Color(0xFFE5E7EB)
                : const Color(0xFF2563EB),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chevron_left,
              size: 16,
              color: isFirstPage
                  ? const Color(0xFF9CA3AF)
                  : const Color(0xFF2563EB),
            ),
            const SizedBox(width: 4),
            Text(
              'Previous',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isFirstPage
                    ? const Color(0xFF9CA3AF)
                    : const Color(0xFF2563EB),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    int maxIndex;
    if (isMobile) {
      maxIndex = widget.contentItems.length - 1;
    } else if (isTablet) {
      maxIndex = widget.contentItems.length - 2;
    } else {
      maxIndex = widget.contentItems.length - 3;
    }

    final isLastPage = _currentIndex >= maxIndex;

    return GestureDetector(
      onTap: isLastPage
          ? null
          : () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isLastPage ? const Color(0xFFF3F4F6) : const Color(0xFF2563EB),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isLastPage
                ? const Color(0xFFE5E7EB)
                : const Color(0xFF2563EB),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Next',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isLastPage ? const Color(0xFF9CA3AF) : Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right,
              size: 16,
              color: isLastPage ? const Color(0xFF9CA3AF) : Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaginationDots() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    int totalPages;
    if (isMobile) {
      totalPages = widget.contentItems.length;
    } else if (isTablet) {
      totalPages = widget.contentItems.length - 1;
    } else {
      totalPages = widget.contentItems.length - 2;
    }

    return Row(
      children: List.generate(totalPages, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: index == _currentIndex
                ? const Color(0xFF2563EB)
                : const Color(0xFFE5E7EB),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
