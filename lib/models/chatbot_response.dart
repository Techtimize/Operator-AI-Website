class ChatbotResponse {
  final String text;
  final List<String>? additionalMessages;
  final List<String>? media;

  ChatbotResponse({required this.text, this.additionalMessages, this.media});

  factory ChatbotResponse.fromJson(Map<String, dynamic> json) {
    final responseField = json['response'];
    String textValue = '';
    if (responseField is String) {
      textValue = responseField;
    } else if (responseField is Map<String, dynamic>) {
      textValue = (responseField['text'] ?? '').toString();
    }

    List<String>? additionalMessages;
    final addField = json['additional_messages'];
    if (addField is List) {
      additionalMessages = addField.map((e) => e.toString()).toList();
    }

    List<String>? mediaList;
    final mediaField = json['media'];
    if (mediaField is List) {
      mediaList = mediaField.map((e) => e.toString()).toList();
    }

    return ChatbotResponse(
      text: textValue,
      additionalMessages: additionalMessages,
      media: mediaList,
    );
  }
}
