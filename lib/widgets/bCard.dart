import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_public_website/utils/app_reponsiveness/responsive_utils.dart';
import 'package:new_public_website/utils/app_reponsiveness/app_spaces.dart';
import 'package:new_public_website/utils/colors_util.dart';
import '../responsiveness/app_textstyles.dart';

class BCard extends StatefulWidget {
  const BCard({Key? key}) : super(key: key);

  @override
  State<BCard> createState() => _BCardState();
}

class _BCardState extends State<BCard> {
  bool _hoverPricing = false;
  bool _hoverDemo = false;

  @override
  Widget build(BuildContext context) {
    // Responsive dimensions
    final double responsiveWidth = ResponsiveUtils.isMobile(context)
        ? MediaQuery.of(context).size.width * 0.95
        : ResponsiveUtils.isTablet(context)
            ? MediaQuery.of(context).size.width * 0.9
            : 1216.67;

    final double responsiveHeight = ResponsiveUtils.isMobile(context)
        ? 420.0
        : ResponsiveUtils.isTablet(context)
            ? 380.0
            : 350.0;

    // Gradient with exact stops
    final gradient = LinearGradient(
      colors: [
        const Color(0xFF2B7FFF),
        const Color(0xFF155DFC),
        const Color(0xFF193CB8),
      ],
      stops: const [0.0, 0.5, 1.0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Container(
      width: responsiveWidth,
      height: responsiveHeight,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.isMobile(context) ? 24.0 : 40.0,
          vertical: ResponsiveUtils.isMobile(context) ? 32.0 : 40.0,
        ),
        child: _buildContentLayout(context),
      ),
    );
  }

  Widget _buildContentLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ready to automate your business?',
                style: GoogleFonts.arimo(
                  color: Colors.white,
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 32),
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              AppSpaces.verticalBox(context, 16),
              Text(
                'Join hundreds of businesses using AI agents to scale faster, work smarter, and delight customers.',
                style: GoogleFonts.arimo(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        AppSpaces.verticalBox(context, 32),

        // Buttons
        _buildButtonsRow(context),
      ],
    );
  }

  Widget _buildButtonsRow(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPricingButton(context),
          AppSpaces.verticalBox(context, 12),
          _buildDemoButton(context),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPricingButton(context),
          AppSpaces.horizontalBox(context, 16),
          _buildDemoButton(context),
        ],
      );
    }
  }

  Widget _buildPricingButton(BuildContext context) {
  final double buttonWidth = ResponsiveUtils.isMobile(context) 
      ? 140.0
      : 146.28;
  final double buttonHeight = ResponsiveUtils.isMobile(context)
      ? 50.0
      : 56.0;

  return MouseRegion(
    onEnter: (_) => setState(() => _hoverPricing = true),
    onExit: (_) => setState(() => _hoverPricing = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      width: buttonWidth,
      height: buttonHeight,
      transform: Matrix4.identity()..scale(_hoverPricing ? 1.05 : 1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: _hoverPricing 
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.6), // 🎨 COLOR CHANGE HERE
                  blurRadius: 12, // 🔧 BLUR AMOUNT CHANGE HERE
                  spreadRadius: 2, // 🔧 SPREAD AMOUNT CHANGE HERE
                  offset: const Offset(3, 3), // 🎯 POSITION CHANGE HERE
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF155DFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'See Pricing',
              style: GoogleFonts.arimo(
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 13),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              transform: Matrix4.translationValues(
                _hoverPricing ? 4.0 : 0.0, 
                0.0, 
                0.0
              ),
              child: Icon(
                Icons.arrow_forward,
                size: ResponsiveUtils.getResponsiveFontSize(context, 16),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildDemoButton(BuildContext context) {
  final double buttonWidth = ResponsiveUtils.isMobile(context)
      ? 190.0
      : 212.03;
  final double buttonHeight = ResponsiveUtils.isMobile(context)
      ? 50.0
      : 60.0;

  return MouseRegion(
    onEnter: (_) => setState(() => _hoverDemo = true),
    onExit: (_) => setState(() => _hoverDemo = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      width: buttonWidth,
      height: buttonHeight,
      transform: Matrix4.identity()..scale(_hoverDemo ? 1.05 : 1.0), // ✅ ZOOM EFFECT
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: _hoverDemo 
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2), // ✅ LIGHT WHITE SHADOW
                  blurRadius: 8, // ✅ SMALL BLUR
                  spreadRadius: 1, // ✅ MINIMAL SPREAD
                  offset: const Offset(0, 2), // ✅ SUBTLE OFFSET
                ),
              ]
            : [],
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent, // ✅ NO BACKGROUND CHANGE
        ),
        onPressed: () {},
        child: Text(
          'Schedule Demo',
          style: GoogleFonts.arimo(
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
}