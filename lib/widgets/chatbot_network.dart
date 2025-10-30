import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/chatbot_response.dart';
import '../src/generated/assets/compiled_asset_registry.dart';

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

      final assetRegistryData = _getAssetRegistryData();

      final requestBody = {
        'user_id': userId,
        'message': message,
        'frontend_assets': assetRegistryData,
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

/// Get asset registry data for backend (mirrors public-website structure)
Map<String, dynamic> _getAssetRegistryData() {
  final assetData = compiledAssetRegistryToJson();

  return {
    'registry': assetData,
    'metadata': {
      'total_assets':
          (compiledAssetRegistry['images'] as List).length +
          (compiledAssetRegistry['videos'] as List).length +
          (compiledAssetRegistry['other'] as List).length,
      'image_assets': getAssetsByType('image').length,
      'video_assets': getAssetsByType('video').length,
      'generated_at': DateTime.now().toIso8601String(),
      'source': 'flutter_chatbot',
      'version': '1.0.0',
    },
    'assets_by_type': {
      'images': getAssetsByType('image'),
      'videos': getAssetsByType('video'),
    },
  };
}
