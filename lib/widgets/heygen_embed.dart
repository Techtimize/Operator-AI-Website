// Conditional export of HeyGen embed for web vs non-web
export 'heygen_embed_stub.dart' if (dart.library.html) 'heygen_embed_web.dart';
