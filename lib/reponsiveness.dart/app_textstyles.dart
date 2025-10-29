import 'package:flutter/material.dart';
import 'package:new_public_website/utils/app_reponsiveness/responsive_utils.dart';
import 'package:new_public_website/utils/colors_util.dart';
// ✅ Import your responsive helper

class AppTextStyles {
  
  static const String _fontFamily = 'Mulish';
  static double _scaleFontSize(BuildContext context, double baseSize) {
    return ResponsiveUtils.getResponsiveFontSize(context, baseSize);
  }

   static TextStyle text0(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.textWhite,
      fontSize: _scaleFontSize(context, 10),
    );
  }

   static TextStyle mediumDarkText0(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.secondaryLighterTextColor,
      fontSize: _scaleFontSize(context, 10),
    );
  }


  static TextStyle darkText0(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.darkTextColor,
      fontSize: _scaleFontSize(context, 10),
    );
  }


  static TextStyle text1(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.textWhite,
      fontSize: _scaleFontSize(context, 12),
    );
  }

   static TextStyle mediumDarkText1(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.secondaryLighterTextColor,
      fontSize: _scaleFontSize(context, 12),
    );
  }

    static TextStyle darkText1(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.darkTextColor,
      fontSize: _scaleFontSize(context, 12),
    );
  }

   static TextStyle text2(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.textWhite,
      fontSize: _scaleFontSize(context, 14),
    );
  }
    static TextStyle mediumDarkText2(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.secondaryLighterTextColor,
      fontSize: _scaleFontSize(context, 14),
    );
  }

  static TextStyle darkText2(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.darkTextColor,
      fontSize: _scaleFontSize(context, 14),
    );
  }

  static TextStyle text3(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.textWhite,
      fontSize: _scaleFontSize(context, 16),
    );
  }

   static TextStyle mediumDarkText3(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.secondaryLighterTextColor,
      fontSize: _scaleFontSize(context, 18),
    );
  }


  static TextStyle darkText3(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.darkTextColor,
      fontSize: _scaleFontSize(context, 16),
    );
  }

  static TextStyle text4(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.textWhite,
      fontSize: _scaleFontSize(context, 18),
      fontWeight: FontWeight.bold,
    );
  }

    static TextStyle darkText(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.darkTextColor,
      fontSize: _scaleFontSize(context, 18),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle text5(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.textWhite,
      fontSize: _scaleFontSize(context, 20),
      fontWeight: FontWeight.bold,
    );
  }

    static TextStyle darkTexttext5(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.darkTextColor,
      fontSize: _scaleFontSize(context, 20),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle text6(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.textWhite,
      fontSize: _scaleFontSize(context, 22),
      fontWeight: FontWeight.bold,
    );
  }

static TextStyle text7(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.textWhite,
      fontSize: _scaleFontSize(context, 24),
      fontWeight: FontWeight.bold,
    );
  }

  
    static TextStyle darkTexttext7(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.darkTextColor,
      fontSize: _scaleFontSize(context, 28),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle text8(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.textWhite,
      fontSize: _scaleFontSize(context, 30),
      fontWeight: FontWeight.bold,
    );
  }


  static TextStyle darkTexttext9(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.darkTextColor,
      fontSize: _scaleFontSize(context,32),
      fontWeight: FontWeight.bold,
    );
  }

  
  static TextStyle darkTexttext10(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.darkTextColor,
      fontSize: _scaleFontSize(context,36),
      fontWeight: FontWeight.bold,
    );
  }

  /// Optional: You can add new styles for subtitles, captions, or buttons
  static TextStyle caption(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: AppColor.textWhite.withOpacity(0.7),
      fontSize: _scaleFontSize(context, 10),
    );
  }

  static TextStyle button(BuildContext context) {
    return TextStyle(
      fontFamily: _fontFamily,
      color: Colors.white,
      fontSize: _scaleFontSize(context, 14),
      fontWeight: FontWeight.w600,
    );
  }
}





