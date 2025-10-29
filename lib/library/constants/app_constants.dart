/// Application-wide constants
class AppConstants {
  AppConstants._();

  // App Information
  static const String appName = 'PAPS.ai Platform';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Multi-tenant SaaS platform for client administration and management';

  // API Configuration
  static const String defaultApiBaseUrl = 'https://api.paps.ai';
  static const int apiTimeoutSeconds = 30;
  static const int apiRetryAttempts = 3;

  // Authentication
  static const String tokenStorageKey = 'auth_token';
  static const String refreshTokenStorageKey = 'refresh_token';
  static const String userStorageKey = 'user_data';
  static const int tokenRefreshBufferMinutes = 5;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  static const int minPageSize = 5;

  // File Upload
  static const int maxFileSizeBytes = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
  ];
  static const List<String> allowedDocumentTypes = [
    'pdf',
    'doc',
    'docx',
    'txt',
  ];

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minNameLength = 2;
  static const int maxNameLength = 100;
  static const int maxEmailLength = 254;
  static const int maxPhoneLength = 20;

  // UI Constants
  static const double defaultBorderRadius = 8.0;
  static const double defaultElevation = 2.0;
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 8.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Debounce Delays
  static const Duration searchDebounceDelay = Duration(milliseconds: 300);
  static const Duration inputDebounceDelay = Duration(milliseconds: 500);

  // Cache Durations
  static const Duration shortCacheDuration = Duration(minutes: 5);
  static const Duration mediumCacheDuration = Duration(minutes: 30);
  static const Duration longCacheDuration = Duration(hours: 1);

  // Error Messages
  static const String networkErrorMessage =
      'Network error. Please check your connection.';
  static const String serverErrorMessage =
      'Server error. Please try again later.';
  static const String unknownErrorMessage = 'An unknown error occurred.';
  static const String validationErrorMessage =
      'Please check your input and try again.';

  // Success Messages
  static const String saveSuccessMessage = 'Changes saved successfully.';
  static const String deleteSuccessMessage = 'Item deleted successfully.';
  static const String updateSuccessMessage = 'Updated successfully.';

  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm:ss';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayDateTimeFormat = 'MMM dd, yyyy HH:mm';

  // Regular Expressions
  static const String emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phoneRegex = r'^\+?[1-9]\d{1,14}$';
  static const String urlRegex =
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$';

  // Feature Flags
  static const bool enableDebugMode = true;
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enablePerformanceMonitoring = true;

  // Storage Keys
  static const String settingsStorageKey = 'app_settings';
  static const String themeStorageKey = 'app_theme';
  static const String languageStorageKey = 'app_language';
  static const String onboardingStorageKey = 'onboarding_completed';

  // Navigation
  static const String homeRoute = '/';
  static const String loginRoute = '/login';
  static const String dashboardRoute = '/dashboard';
  // static const String marktRoute = '/markt'
  static const String settingsRoute = '/settings';
  static const String profileRoute = '/profile';

  // Permissions
  static const String cameraPermission = 'camera';
  static const String storagePermission = 'storage';
  static const String locationPermission = 'location';
  static const String microphonePermission = 'microphone';

  // Social Media
  static const String twitterUrl = 'https://twitter.com/papsai';
  static const String linkedinUrl = 'https://linkedin.com/company/papsai';
  static const String githubUrl = 'https://github.com/papsai';
  static const String supportEmail = 'support@paps.ai';

  // Legal
  static const String privacyPolicyUrl = 'https://paps.ai/privacy';
  static const String termsOfServiceUrl = 'https://paps.ai/terms';
  static const String cookiePolicyUrl = 'https://paps.ai/cookies';

  // Development
  static const bool isDevelopment =
      bool.fromEnvironment('dart.vm.product') == false;
  static const bool isProduction =
      bool.fromEnvironment('dart.vm.product') == true;
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );
}
