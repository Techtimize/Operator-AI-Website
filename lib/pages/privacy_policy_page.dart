import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyPolicyPageContent extends StatelessWidget {
  const PrivacyPolicyPageContent({super.key});

  static const String _assetPath = 'assets/legal/privacy_policy.md';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 768;
    // Calculate minimum height to push footer to bottom
    // Navbar ~57px, Footer ~100px (estimated), padding ~64px
    final minHeight = screenHeight - 57 - 100 - 64;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 24 : 32,
      ),
      child: FutureBuilder<String>(
        future: rootBundle.loadString(_assetPath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: minHeight > 200 ? minHeight : 200,
              width: double.infinity,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          // For loaded content, wrap in Center and ConstrainedBox
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: _buildContent(snapshot),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(AsyncSnapshot<String> snapshot) {
    if (snapshot.hasError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Failed to load Privacy Policy.',
            style: TextStyle(fontSize: 16, color: Colors.redAccent),
          ),
          const SizedBox(height: 8),
          Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      );
    }
    final data = snapshot.data ?? '';
    if (data.isEmpty) {
      return const Center(
        child: Text(
          'Privacy Policy content is empty.',
          style: TextStyle(fontSize: 16, color: Colors.redAccent),
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Privacy Policy',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          MarkdownBody(
            data: data,
            selectable: true,
            styleSheet: MarkdownStyleSheet(
              p: const TextStyle(fontSize: 16, height: 1.6),
              h1: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              h2: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              h3: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              a: const TextStyle(color: Color(0xFF2563EB)),
              blockquotePadding: const EdgeInsets.all(12),
              blockquoteDecoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              codeblockDecoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
