import 'package:flutter/material.dart';
import 'nav_button.dart';
import 'hover_utility_button.dart';
import 'hover_language_selector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Navbar extends StatelessWidget {
  final String? activeRoute;
  final Function(String)? onRouteChanged;
  final VoidCallback? onMenuTap;

  const Navbar({
    super.key,
    this.activeRoute,
    this.onRouteChanged,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000), // 10% black opacity
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      clipBehavior: Clip.none,
      child: Center(
        child: Container(
          height: 56.8,
          width: MediaQuery.of(context).size.width > 1280
              ? 1280
              : MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          clipBehavior: Clip.none,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Check if screen width is less than 1024px (tablet/mobile)
              bool isTabletOrMobile = MediaQuery.of(context).size.width < 1024;

              if (isTabletOrMobile) {
                return Row(
                  children: [
                    // Logo Section (Left)
                    LogoWidget(onRouteChanged: onRouteChanged),

                    // Spacer
                    const Spacer(),

                    // Mobile Menu Button
                    MobileMenuButton(onMenuTap: onMenuTap),
                  ],
                );
              } else {
                return Row(
                  children: [
                    // Logo Section (Left)
                    LogoWidget(onRouteChanged: onRouteChanged),

                    // Spacer to push navigation to center
                    const Spacer(),

                    // Navigation Links (Center) - Hidden on tablet/mobile
                    NavigationLinks(
                      activeItem: activeRoute,
                      onItemTap: onRouteChanged,
                    ),

                    // Spacer to push utility icons to right
                    const Spacer(),

                    // Utility Icons (Right)
                    const UtilityIcons(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  final Function(String)? onRouteChanged;

  const LogoWidget({super.key, this.onRouteChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onRouteChanged?.call('/'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Image.asset('assets/images/logo.png', height: 30),
      ),
    );
  }
}

class NavigationLinks extends StatelessWidget {
  final List<NavigationItem> navigationItems;
  final String? activeItem;
  final Function(String)? onItemTap;

  const NavigationLinks({
    super.key,
    this.navigationItems = const [
      NavigationItem(text: 'AI SALES', route: '/ai-sales'),
      NavigationItem(text: 'AI MKT', route: '/ai-mkt'),
      NavigationItem(text: 'AI CSR', route: '/ai-csr'),
      NavigationItem(text: 'INDUSTRIES', route: '/industries'),
      NavigationItem(text: 'PRICING', route: '/pricing'),
    ],
    this.activeItem,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: navigationItems.map((item) {
        return Row(
          children: [
            NavButton(
              text: item.text,
              isActive: activeItem == item.route,
              onTap: () {
                onItemTap?.call(item.route);
              },
            ),
            if (navigationItems.last != item) const SizedBox(width: 8),
          ],
        );
      }).toList(),
    );
  }
}

class NavigationItem {
  final String text;
  final String route;

  const NavigationItem({required this.text, required this.route});
}

class UtilityIcons extends StatelessWidget {
  const UtilityIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildUtilityButton('assets/Icons/searchIcon.svg', () {}),
        const SizedBox(width: 8),
        _buildUtilityButton('assets/Icons/personIcon.svg', () {}),
        const SizedBox(width: 8),
        _buildLanguageSelector(),
        const SizedBox(width: 8),
        _buildUtilityButton(  'assets/Icons/cartIcon.svg', (){})
      ],
    );
  }

  Widget _buildUtilityButton(String assetPath, VoidCallback onTap) {
  return HoverUtilityButton(
    assetPath: assetPath,
    onTap: onTap,
  );
}


  Widget _buildLanguageSelector() {
    return HoverLanguageSelector(
      onLanguageChanged: (String language) {
        // Handle language change
        debugPrint('Language changed to: $language');
      },
    );
  }
}

class MobileMenuButton extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const MobileMenuButton({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Only use the callback approach
        onMenuTap?.call();
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        ),
        child: const Icon(Icons.menu, color: Color(0xFF424242), size: 20),
      ),
    );
  }
}
