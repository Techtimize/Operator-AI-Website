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

  // Fallback HeyGen streaming embed URL for hero section (web iframe)
  static const String fallbackEmbedUrl =
      'https://labs.heygen.com/guest/streaming-embed?share=eyJxdWFsaXR5IjoiaGlnaCIsImF2YXRhck5hbWUiOiIxNDRkYTdmYzY3Y2E0MmNmOTc5NDQyOGY0\nMmJmNmZiMCIsInByZXZpZXdJbWciOiJodHRwczovL2ZpbGVzMi5oZXlnZW4uYWkvYXZhdGFyL3Yz\nLzE0NGRhN2ZjNjdjYTQyY2Y5Nzk0NDI4ZjQyYmY2ZmIwL2Z1bGwvMi4yL3ByZXZpZXdfdGFyZ2V0\nLndlYnAiLCJuZWVkUmVtb3ZlQmFja2dyb3VuZCI6ZmFsc2UsImtub3dsZWRnZUJhc2VJZCI6ImY3\nYWMxNDM0MzhmYTQ3MjM4OWNhYWVkZTJlOGE3ZDM0IiwidXNlcm5hbWUiOiI4MGE5ZTJjYWViN2Q0\nNWMwYWNlZjI1MGQwZDgzZDY4MSJ9&inIFrame=1';
}
