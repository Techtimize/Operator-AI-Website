import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool showNavbar;
  final bool showFooter;
  final Widget? endDrawer;
  final Widget? drawer;
  final String? currentRoute;

  const MainLayout({
    super.key,
    required this.child,
    this.title,
    this.showNavbar = true,
    this.showFooter = true,
    this.endDrawer,
    this.drawer,
    this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Navbar
          if (showNavbar) Navbar(activeRoute: currentRoute),

          // Main Content
          Expanded(child: child),

          // Footer
          if (showFooter) const Footer(),
        ],
      ),
      endDrawer: endDrawer,
      drawer: drawer,
    );
  }
}

// Convenience widget for pages that need the main layout
class MainLayoutPage extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool showNavbar;
  final bool showFooter;

  const MainLayoutPage({
    super.key,
    required this.child,
    this.title,
    this.showNavbar = true,
    this.showFooter = true,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: title,
      showNavbar: showNavbar,
      showFooter: showFooter,
      child: child,
    );
  }
}
