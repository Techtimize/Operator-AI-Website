import 'package:go_router/go_router.dart';
import '../layouts/persistent_layout.dart';
import '../pages/home_screen.dart';
import '../pages/ai_sales_page.dart';
import '../pages/ai_mkt_page.dart';
import '../pages/ai_csr_page.dart';
import '../pages/industries_page.dart';
import '../pages/pricing_page.dart';
import '../pages/faq_page.dart';
import '../pages/privacy_policy_page.dart';
import '../pages/terms_of_service_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => PersistentLayout(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreenContent(),
        ),
        GoRoute(
          path: '/ai-sales',
          builder: (context, state) => const AiSalesPageContent(),
        ),
        GoRoute(
          path: '/ai-mkt',
          builder: (context, state) => const AiMktPageContent(),
        ),
        GoRoute(
          path: '/ai-csr',
          builder: (context, state) => const AiCsrPageContent(),
        ),
        GoRoute(
          path: '/industries',
          builder: (context, state) => const IndustriesPageContent(),
        ),
        GoRoute(
          path: '/pricing',
          builder: (context, state) => const PricingPageContent(),
        ),
        GoRoute(
          path: '/faq',
          builder: (context, state) => const FaqPageContent(),
        ),
        GoRoute(
          path: '/privacy-policy',
          builder: (context, state) => const PrivacyPolicyPageContent(),
        ),
        GoRoute(
          path: '/terms-of-service',
          builder: (context, state) => const TermsOfServicePageContent(),
        ),
      ],
    ),
  ],
);
