import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String currentRoute;
  final Function(String) onRouteChanged;
  final VoidCallback onClose;

  const CustomDrawer({
    super.key,
    required this.currentRoute,
    required this.onRouteChanged,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 320, // Fixed width for consistent experience
      child: Column(
        children: [
          _buildDrawerHeader(),
          Expanded(child: _buildDrawerContent()),
          _buildDrawerFooter(),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
      ),
      child: Row(
        children: [
          // Logo
          Image.asset(
            'assets/images/logo.png',
            height: 32,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          // Close button
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, color: Color(0xFF6B7280), size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerContent() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _navigationItems.length,
      itemBuilder: (context, index) {
        final item = _navigationItems[index];
        final isActive = currentRoute == item.route;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isActive ? const Color.fromARGB(26, 37, 99, 235) : null,
          ),
          child: ListTile(
            leading: Icon(
              item.icon,
              color: isActive
                  ? const Color(0xFF2563EB)
                  : const Color(0xFF6B7280),
              size: 22,
            ),
            title: Text(
              item.text,
              style: TextStyle(
                color: isActive
                    ? const Color(0xFF2563EB)
                    : const Color(0xFF374151),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                fontSize: 16,
              ),
            ),
            onTap: () => _handleNavigation(item.route),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hoverColor: const Color.fromARGB(13, 37, 99, 235),
          ),
        );
      },
    );
  }

  Widget _buildDrawerFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 1),
        ),
      ),
      child: Column(
        children: [
          // Utility buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFooterButton(
                icon: Icons.search,
                label: 'Search',
                onTap: () {
                  onClose();
                  // Handle search
                },
              ),
              _buildFooterButton(
                icon: Icons.person,
                label: 'Profile',
                onTap: () {
                  onClose();
                  // Handle profile
                },
              ),
              _buildFooterButton(
                icon: Icons.language,
                label: 'Language',
                onTap: () {
                  onClose();
                  // Handle language
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Copyright
          Text(
            '© 2024 OperatorAI. All rights reserved.',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFF6B7280), size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(String route) {
    onRouteChanged(route);
    onClose();
  }

  // Navigation items for the drawer
  static const List<NavigationItem> _navigationItems = [
    NavigationItem(text: 'Home', route: '/', icon: Icons.home),
    NavigationItem(
      text: 'AI SALES',
      route: '/ai-sales',
      icon: Icons.trending_up,
    ),
    NavigationItem(text: 'AI MKT', route: '/ai-mkt', icon: Icons.campaign),
    NavigationItem(text: 'AI CSR', route: '/ai-csr', icon: Icons.support_agent),
    NavigationItem(
      text: 'Industries',
      route: '/industries',
      icon: Icons.business,
    ),
    NavigationItem(
      text: 'Pricing',
      route: '/pricing',
      icon: Icons.attach_money,
    ),
  ];
}

// Navigation item class for drawer
class NavigationItem {
  final String text;
  final String route;
  final IconData icon;

  const NavigationItem({
    required this.text,
    required this.route,
    required this.icon,
  });
}
