import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/chatbot_response.dart';

class ChatbotNetworkService {
  static Future<ChatbotResponse?> sendMessage({
    required String userId,
    required String message,
  }) async {
    try {
      debugPrint('=== CHATBOT NETWORK REQUEST DEBUG ===');
      debugPrint('URL: ${ApiConfig.baseUrl}${ApiConfig.chatEndpoint}');
      debugPrint('User ID: $userId');
      debugPrint('Message: $message');

      final requestBody = {
        'user_id': userId,
        'message': message,
        'frontend_assets': {},
      };

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.chatEndpoint}'),
        headers: const {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json; charset=utf-8',
        },
        body: json.encode(requestBody),
      );

      debugPrint('Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final responseData = json.decode(responseBody);
        return ChatbotResponse.fromJson(responseData as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint('Network error: $e');
    }
    return null;
  }
}
