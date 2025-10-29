import 'package:flutter/material.dart';

enum ChatMediaType { image, video, unknown }

ChatMediaType getMediaTypeFromFilename(String path) {
  final lower = path.toLowerCase();
  if (lower.endsWith('.png') ||
      lower.endsWith('.jpg') ||
      lower.endsWith('.jpeg') ||
      lower.endsWith('.gif') ||
      lower.endsWith('.webp')) {
    return ChatMediaType.image;
  }
  if (lower.endsWith('.mp4') ||
      lower.endsWith('.webm') ||
      lower.endsWith('.mov')) {
    return ChatMediaType.video;
  }
  return ChatMediaType.unknown;
}

class ChatMediaCard extends StatelessWidget {
  final ChatMediaType type;
  final String mediaUrl;

  const ChatMediaCard({super.key, required this.type, required this.mediaUrl});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ChatMediaType.image:
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(mediaUrl, fit: BoxFit.cover),
        );
      case ChatMediaType.video:
        // Placeholder thumbnail UI for videos; playing videos can be added later
        return Container(
          height: 160,
          decoration: BoxDecoration(
            color: const Color(0xFF111827),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(Icons.play_circle_fill, size: 48, color: Colors.white),
          ),
        );
      case ChatMediaType.unknown:
        return const SizedBox.shrink();
    }
  }
}
