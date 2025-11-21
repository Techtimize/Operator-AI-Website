import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../responsiveness/app_textstyles.dart';
import '../utils/app_reponsiveness/responsive.dart';

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
        // ✅ RESPONSIVE SPACING
        SizedBox(height: Responsive.getFontSize(context,
          mobile: 24,    // ✅ Mobile: 24
          tablet: 32,    // ✅ Tablet: 32  
          desktop: 40,   // ✅ Desktop: 40 (original)
          largeDesktop: 44,
          xlDesktop: 48,
        )),
        
        // ✅ CENTER WRAPPER FOR SHADERMASK
        Center(
          child: ShaderMask(
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
              textAlign: TextAlign.center, // ✅ ADD TEXT ALIGN CENTER
              style: GoogleFonts.arimo(
                textStyle: AppTextStyles.darkTexttext7(context).copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  // ✅ RESPONSIVE HEADING FONT SIZE
                  fontSize: Responsive.getFontSize(context,
                    mobile: 24,    // ✅ Mobile: 24
                    tablet: 30,    // ✅ Tablet: 30
                    desktop: 36,   // ✅ Desktop: 36 (original)
                    largeDesktop: 38,
                    xlDesktop: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
        
        if (paragraph != null) ...[
          // ✅ RESPONSIVE SPACING BETWEEN HEADING AND PARAGRAPH
          SizedBox(height: Responsive.getFontSize(context,
            mobile: 8,     // ✅ Mobile: 8
            tablet: 10,    // ✅ Tablet: 10
            desktop: 12,   // ✅ Desktop: 12 (original)
            largeDesktop: 14,
            xlDesktop: 16,
          )),
          
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.getFontSize(context,
                mobile: 16,    // ✅ Mobile: 16
                tablet: 24,    // ✅ Tablet: 24  
                desktop: 0,    // ✅ Desktop: 0 (no padding)
                largeDesktop: 0,
                xlDesktop: 0,
              ),
            ),
            child: Text( 
              paragraph!,
              textAlign: TextAlign.center,
              style: GoogleFonts.arimo(
                textStyle: AppTextStyles.mediumDarkText3(context).copyWith(
                  // ✅ RESPONSIVE PARAGRAPH FONT SIZE
                  fontSize: Responsive.getFontSize(context,
                    mobile: 14,    // ✅ Mobile: 14
                    tablet: 16,    // ✅ Tablet: 16
                    desktop: 20,   // ✅ Desktop: 20 (original)
                    largeDesktop: 22,
                    xlDesktop: 24,
                  ),
                  fontWeight: FontWeight.normal,
                  color: const Color(0xff4A5565),
                  // ✅ RESPONSIVE LINE HEIGHT
                  height: Responsive.getFontSize(context,
                    mobile: 1.4,   // ✅ Mobile: 1.4
                    tablet: 1.5,   // ✅ Tablet: 1.5
                    desktop: 1.6,  // ✅ Desktop: 1.6
                    largeDesktop: 1.6,
                    xlDesktop: 1.6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}