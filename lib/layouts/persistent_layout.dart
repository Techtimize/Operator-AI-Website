import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/navbar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/footer.dart';
import '../pages/home_screen.dart';
import '../pages/ai_sales_page.dart';
import '../pages/ai_mkt_page.dart';
import '../pages/ai_csr_page.dart';
import '../pages/industries_page.dart';
import '../pages/pricing_page.dart';
import '../pages/faq_page.dart';
import '../widgets/chatbot_widget.dart';
import '../widgets/robot_animation.dart';

// Global keys to preserve navbar and footer state across rebuilds
final _navbarKey = GlobalKey(debugLabel: 'navbar');
final _footerKey = GlobalKey(debugLabel: 'footer');

class PersistentLayout extends StatefulWidget {
  final Widget? child;

  const PersistentLayout({super.key, this.child});

  @override
  State<PersistentLayout> createState() => _PersistentLayoutState();
}

class _PersistentLayoutState extends State<PersistentLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ChatbotWidgetState> _chatbotKey =
      GlobalKey<ChatbotWidgetState>();
  final ValueNotifier<bool> _dummyOpen = ValueNotifier<bool>(false);

  String get _currentRoute => GoRouterState.of(context).fullPath ?? '/';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              // Navbar - wrapped in RepaintBoundary to prevent unnecessary repaints
              RepaintBoundary(
                child: Navbar(
                  key: _navbarKey, // Preserve navbar state across rebuilds
                  activeRoute: _currentRoute,
                  onRouteChanged: _handleRouteChange,
                  onMenuTap: _toggleDrawer,
                ),
              ),

              // Main Content Area - Only the content changes, navbar and footer stay mounted
              Expanded(
                child: SingleChildScrollView(
                  key: PageStorageKey(_currentRoute),
                  child: Column(
                    children: [
                      // Page content (changes on route change)
                      widget.child ?? _buildCurrentPage(),
                      // Footer - wrapped in RepaintBoundary to prevent unnecessary repaints
                      RepaintBoundary(
                        child: Footer(
                          key: _footerKey,
                          onRouteChanged: _handleRouteChange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Floating chatbot overlay across all pages
          Positioned.fill(
            child: IgnorePointer(
              ignoring: false,
              child: Align(
                alignment: Alignment.bottomRight,
                child: ChatbotWidget(
                  key: _chatbotKey,
                  panelRightOffset: 188, // 16 (padding) + 160 (robot) + 12 gap
                  panelBottomOffset: 188, // 16 (padding) + 160 (robot) + 12 gap
                ),
              ),
            ),
          ),

          // Robot avatar animation overlay (tap to open chatbot)
          Positioned.fill(
            child: ValueListenableBuilder<bool>(
              valueListenable:
                  _chatbotKey.currentState?.isOpenListenable ?? _dummyOpen,
              builder: (context, isOpen, _) {
                return IgnorePointer(
                  ignoring: isOpen,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
                      child: Opacity(
                        opacity: isOpen && screenWidth < 1024 ? 0.0 : 1.0,
                        child: RobotAnimation(
                          width: 160,
                          height: 160,
                          onTap: () => _chatbotKey.currentState?.openChatbot(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Use drawer for both mobile and tablet (left side)
      drawer: (isMobile || isTablet)
          ? CustomDrawer(
              currentRoute: _currentRoute,
              onRouteChanged: _handleRouteChange,
              onClose: _closeDrawer,
            )
          : null,
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentRoute) {
      case '/':
        return const HomeScreenContent();
      case '/ai-sales':
        return const AiSalesPageContent();
      case '/ai-mkt':
        return const AiMktPageContent();
      case '/ai-csr':
        return const AiCsrPageContent();
      case '/industries':
        return const IndustriesPageContent();
      case '/pricing':
        return const PricingPageContent();
      case '/faq':
        return const FaqPageContent();
      default:
        return const HomeScreenContent();
    }
  }

  void _handleRouteChange(String route) {
    context.go(route);
  }

  void _toggleDrawer() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    if (isMobile || isTablet) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  void _closeDrawer() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    if (isMobile || isTablet) {
      Navigator.of(context).pop();
    }
  }
}
