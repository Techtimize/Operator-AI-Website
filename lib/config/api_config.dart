class ApiConfig {
  static const String devBaseUrl = 'http://localhost:8000';
  static const String prodBaseUrl = 'https://api.chatbot.opperator.ai';

  static String get baseUrl {
    final isDevelopment = const String.fromEnvironment('DEV_MODE') == 'true';
    return isDevelopment ? devBaseUrl : prodBaseUrl;
  }

  static const String chatEndpoint = '/chat';
}
