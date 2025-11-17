import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../responsiveness/app_textstyles.dart';
import '../responsiveness/responsive.dart';

class HeadingSection extends StatelessWidget {
  final String heading;
  final String? paragraph;

  const HeadingSection({
    super.key,
    required this.heading,
    this.paragraph,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: context.rh(40)),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xFF155DFC), // 0%
              Color(0xFF193CB8), // 100%
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: Text(
            heading,
            style: GoogleFonts.arimo(
              textStyle: AppTextStyles.darkTexttext7(context).copyWith(
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: 36,
              ),
            ),
          ),
        ),
        if (paragraph != null) ...[
          const SizedBox(height: 12),
          Text( 
            paragraph!,
  textAlign: TextAlign.center, // ✅ This centers the paragraph
  style: GoogleFonts.arimo(
    textStyle: AppTextStyles.mediumDarkText3(context).copyWith(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: const Color(0xff4A5565),
    ),
  ),
),

        ],
      ],
    );
  }
}
