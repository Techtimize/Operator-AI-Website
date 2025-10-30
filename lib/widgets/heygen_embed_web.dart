import 'dart:html' as html;
import 'package:flutter/material.dart';

// Builds an iframe embed for HeyGen on web (no manual view factory needed)
Widget buildHeygenEmbed(String url, {double? width, double? height}) {
  final String viewKey =
      'heygen-iframe-${url.hashCode}-${DateTime.now().millisecondsSinceEpoch}';

  return HtmlElementView.fromTagName(
    key: ValueKey(viewKey),
    tagName: 'iframe',
    onElementCreated: (element) {
      final iframe = element as html.IFrameElement;
      iframe
        ..src = url
        ..style.border = '0'
        ..allow =
            'camera; microphone; autoplay; clipboard-read; clipboard-write;'
        ..allowFullscreen = true
        ..style.width = '100%'
        ..style.height = '100%';
    },
  );
}
