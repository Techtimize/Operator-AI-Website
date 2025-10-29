// HeyGen Configuration Constants
class HeyGenConfig {
  // Replace these with your actual HeyGen credentials
  static const String apiKey =
      'ODBhOWUyY2FlYjdkNDVjMGFjZWYyNTBkMGQ4M2Q2ODEtMTc0Mjg5OTU4Mw==';
  static const String avatarId = '93b3692a9e454338a65768a0df023eea';
  static const String voiceId = 'YOUR_VOICE_ID_HERE'; // Optional

  // Available languages
  static const Map<String, String> languages = {
    'en': 'English',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'zh': 'Chinese',
    'ja': 'Japanese',
    'ko': 'Korean',
  };

  // Default settings
  static const String defaultLanguage = 'en';
  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration retryDelay = Duration(seconds: 3);
  static const int maxRetryAttempts = 3;
}
