import 'package:flutter/material.dart';

class Responsive {
  // Screen size breakpoints (Industry Standard)
  static const double _mobileBreakpoint = 768;      // Phones
  static const double _tabletBreakpoint = 1024;     // Tablets/iPads
  static const double _desktopBreakpoint = 1200;    // Small Desktop/Laptops
  static const double _largeDesktopBreakpoint = 1440; // Large Desktop/Monitors
  static const double _xlDesktopBreakpoint = 1920;  // Extra Large Screens

  // Device detection
  static bool isMobile(BuildContext context) => 
      MediaQuery.of(context).size.width < _mobileBreakpoint;
  
  static bool isTablet(BuildContext context) => 
      MediaQuery.of(context).size.width >= _mobileBreakpoint && 
      MediaQuery.of(context).size.width < _tabletBreakpoint;
  
  static bool isDesktop(BuildContext context) => 
      MediaQuery.of(context).size.width >= _tabletBreakpoint && 
      MediaQuery.of(context).size.width < _largeDesktopBreakpoint;
  
  static bool isLargeDesktop(BuildContext context) => 
      MediaQuery.of(context).size.width >= _largeDesktopBreakpoint &&
      MediaQuery.of(context).size.width < _xlDesktopBreakpoint;
  
  static bool isXlDesktop(BuildContext context) => 
      MediaQuery.of(context).size.width >= _xlDesktopBreakpoint;

  // ✅ WEB SPECIFIC: Check if it's any desktop (web) device
  static bool isWeb(BuildContext context) => 
      isDesktop(context) || isLargeDesktop(context) || isXlDesktop(context);

  // Screen dimensions
  static double screenWidth(BuildContext context) => 
      MediaQuery.of(context).size.width;
  
  static double screenHeight(BuildContext context) => 
      MediaQuery.of(context).size.height;

  // Responsive width percentage
  static double rw(BuildContext context, double percentage) {
    return screenWidth(context) * (percentage / 100);
  }

  // Responsive height percentage  
  static double rh(BuildContext context, double percentage) {
    return screenHeight(context) * (percentage / 100);
  }

  // ✅ IMPROVED: Responsive font sizes with web scaling
  static double getFontSize(BuildContext context, {
    double mobile = 14,
    double tablet = 16,
    double desktop = 18,
    double largeDesktop = 20,
    double xlDesktop = 22,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    if (isDesktop(context)) return desktop;
    if (isLargeDesktop(context)) return largeDesktop;
    return xlDesktop;
  }

  // ✅ IMPROVED: Layout helpers with web optimization
  static int gridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    if (isDesktop(context)) return 3;
    if (isLargeDesktop(context)) return 4;
    return 4; // XL desktop
  }

  static double gridChildAspectRatio(BuildContext context) {
    if (isMobile(context)) return 0.75;
    if (isTablet(context)) return 0.8;
    if (isDesktop(context)) return 0.85;
    return 0.9; // Large and XL desktop
  }

  static double gridSpacing(BuildContext context) {
    if (isMobile(context)) return 16;
    if (isTablet(context)) return 20;
    if (isDesktop(context)) return 24;
    if (isLargeDesktop(context)) return 28;
    return 32; // XL desktop
  }

  // ✅ FIXED: Text style helpers - removed FontSizes parameter
  static TextStyle heading1(BuildContext context, {Color? color, FontWeight? fontWeight}) => 
      TextStyle(
        fontSize: FontSizes.h1(context), 
        fontWeight: fontWeight ?? FontWeight.bold, 
        color: color,
      );

  static TextStyle heading2(BuildContext context, {Color? color, FontWeight? fontWeight}) => 
      TextStyle(
        fontSize: FontSizes.h2(context), 
        fontWeight: fontWeight ?? FontWeight.w600, 
        color: color,
      );

  static TextStyle heading3(BuildContext context, {Color? color, FontWeight? fontWeight}) => 
      TextStyle(
        fontSize: FontSizes.h3(context), 
        fontWeight: fontWeight ?? FontWeight.w600, 
        color: color,
      );

  static TextStyle heading4(BuildContext context, {Color? color, FontWeight? fontWeight}) => 
      TextStyle(
        fontSize: FontSizes.h4(context), 
        fontWeight: fontWeight ?? FontWeight.w500, 
        color: color,
      );

  static TextStyle bodyLarge(BuildContext context, {Color? color, FontWeight? fontWeight}) => 
      TextStyle(
        fontSize: FontSizes.bodyLarge(context), 
        color: color, 
        fontWeight: fontWeight ?? FontWeight.normal,
      );

  static TextStyle bodyMedium(BuildContext context, {Color? color, FontWeight? fontWeight}) => 
      TextStyle(
        fontSize: FontSizes.bodyMedium(context), 
        color: color, 
        fontWeight: fontWeight ?? FontWeight.normal,
      );

  static TextStyle bodySmall(BuildContext context, {Color? color, FontWeight? fontWeight}) => 
      TextStyle(
        fontSize: FontSizes.bodySmall(context), 
        color: color, 
        fontWeight: fontWeight ?? FontWeight.normal,
      );

  // ✅ FIXED: Web optimized text styles
  static TextStyle webHeading(BuildContext context, {Color? color}) => 
      TextStyle(
        fontSize: isWeb(context) ? 48 : FontSizes.h1(context),
        fontWeight: FontWeight.bold,
        color: color,
      );

  static TextStyle webSubheading(BuildContext context, {Color? color}) => 
      TextStyle(
        fontSize: isWeb(context) ? 24 : FontSizes.h3(context),
        fontWeight: FontWeight.w500,
        color: color,
      );

  // ✅ WEB SPECIFIC: Web layout helpers
  static bool shouldShowSidebar(BuildContext context) => isWeb(context);
  
  static double sidebarWidth(BuildContext context) {
    if (isDesktop(context)) return 280;
    if (isLargeDesktop(context)) return 320;
    return 360;
  }

  static double contentWidth(BuildContext context) {
    return screenWidth(context) - (shouldShowSidebar(context) ? sidebarWidth(context) : 0);
  }
}

// Top-level FontSizes class
class FontSizes {
  // Heading sizes - Web optimized
  static double h1(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 28,
    tablet: 32,
    desktop: 36,
    largeDesktop: 40,
    xlDesktop: 44,
  );

  static double h2(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 24,
    tablet: 28,
    desktop: 32,
    largeDesktop: 36,
    xlDesktop: 40,
  );

  static double h3(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 20,
    tablet: 24,
    desktop: 28,
    largeDesktop: 32,
    xlDesktop: 36,
  );

  static double h4(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 18,
    tablet: 20,
    desktop: 24,
    largeDesktop: 28,
    xlDesktop: 32,
  );

  // Body sizes - Web optimized
  static double bodyLarge(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 16,
    tablet: 18,
    desktop: 20,
    largeDesktop: 22,
    xlDesktop: 24,
  );

  static double bodyMedium(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 14,
    tablet: 16,
    desktop: 18,
    largeDesktop: 20,
    xlDesktop: 22,
  );

  static double bodySmall(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 12,
    tablet: 14,
    desktop: 16,
    largeDesktop: 18,
    xlDesktop: 20,
  );

  static double caption(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 10,
    tablet: 12,
    desktop: 14,
    largeDesktop: 16,
    xlDesktop: 18,
  );
}

// Top-level Spacing class
class Spacing {
  static double xs(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 4,
    tablet: 6,
    desktop: 8,
    largeDesktop: 10,
    xlDesktop: 12,
  );

  static double sm(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 8,
    tablet: 12,
    desktop: 16,
    largeDesktop: 20,
    xlDesktop: 24,
  );

  static double md(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 12,
    tablet: 16,
    desktop: 20,
    largeDesktop: 24,
    xlDesktop: 28,
  );

  static double lg(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 16,
    tablet: 20,
    desktop: 24,
    largeDesktop: 28,
    xlDesktop: 32,
  );

  static double xl(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 20,
    tablet: 24,
    desktop: 28,
    largeDesktop: 32,
    xlDesktop: 36,
  );

  static double xxl(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 24,
    tablet: 32,
    desktop: 40,
    largeDesktop: 48,
    xlDesktop: 56,
  );
}

// Top-level Dimensions class
class Dimensions {
  // Card dimensions - Web optimized
  static double cardWidth(BuildContext context) {
    if (Responsive.isMobile(context)) return Responsive.rw(context, 92);
    if (Responsive.isTablet(context)) return Responsive.rw(context, 85);
    if (Responsive.isDesktop(context)) return 300.22; // Standard desktop
    if (Responsive.isLargeDesktop(context)) return 380.0; // Large desktop
    return 400.0; // XL desktop
  }

  static double cardHeight(BuildContext context) {
    if (Responsive.isMobile(context)) return Responsive.rh(context, 60);
    if (Responsive.isTablet(context)) return Responsive.rh(context, 55);
    if (Responsive.isDesktop(context)) return 420; // Standard desktop
    if (Responsive.isLargeDesktop(context)) return 450; // Large desktop
    return 480; // XL desktop
  }

  // Icon sizes - Web optimized
  static double iconSmall(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 16,
    tablet: 20,
    desktop: 24,
    largeDesktop: 28,
    xlDesktop: 32,
  );

  static double iconMedium(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 24,
    tablet: 32,
    desktop: 40,
    largeDesktop: 48,
    xlDesktop: 56,
  );

  static double iconLarge(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 32,
    tablet: 40,
    desktop: 48,
    largeDesktop: 56,
    xlDesktop: 64,
  );

  // Button dimensions - Web optimized
  static double buttonHeight(BuildContext context) => Responsive.getFontSize(
    context,
    mobile: 44,
    tablet: 48,
    desktop: 52,
    largeDesktop: 56,
    xlDesktop: 60,
  );

  // Container dimensions
  static double containerWidth(BuildContext context) {
    if (Responsive.isMobile(context)) return Responsive.rw(context, 95);
    if (Responsive.isTablet(context)) return Responsive.rw(context, 90);
    if (Responsive.isDesktop(context)) return 1200;
    if (Responsive.isLargeDesktop(context)) return 1400;
    return 1600;
  }

  // Max content width for better readability on large screens
  static double maxContentWidth(BuildContext context) {
    if (Responsive.isMobile(context)) return Responsive.rw(context, 100);
    if (Responsive.isTablet(context)) return Responsive.rw(context, 95);
    if (Responsive.isDesktop(context)) return 1200;
    if (Responsive.isLargeDesktop(context)) return 1400;
    return 1600;
  }
}

// Top-level Paddings class
class Paddings {
  static EdgeInsets all(BuildContext context, double value) => 
      EdgeInsets.all(Responsive.getFontSize(context, 
        mobile: value * 0.8, 
        tablet: value * 0.9, 
        desktop: value,
        largeDesktop: value * 1.1,
        xlDesktop: value * 1.2,
      ));

  static EdgeInsets symmetric(BuildContext context, {
    double horizontal = 0,
    double vertical = 0,
  }) => EdgeInsets.symmetric(
    horizontal: Responsive.getFontSize(context, 
      mobile: horizontal * 0.8, 
      tablet: horizontal * 0.9, 
      desktop: horizontal,
      largeDesktop: horizontal * 1.1,
      xlDesktop: horizontal * 1.2,
    ),
    vertical: Responsive.getFontSize(context, 
      mobile: vertical * 0.8, 
      tablet: vertical * 0.9, 
      desktop: vertical,
      largeDesktop: vertical * 1.1,
      xlDesktop: vertical * 1.2,
    ),
  );

  // Predefined padding sets with web optimization
  static EdgeInsets cardPadding(BuildContext context) => symmetric(
    context,
    horizontal: Responsive.isMobile(context) ? 16 : Responsive.isTablet(context) ? 20 : 24,
    vertical: Responsive.isMobile(context) ? 16 : Responsive.isTablet(context) ? 20 : 24,
  );

  static EdgeInsets sectionPadding(BuildContext context) => symmetric(
    context,
    horizontal: Responsive.isMobile(context) ? 20 : Responsive.isTablet(context) ? 32 : 48,
    vertical: Responsive.isMobile(context) ? 20 : Responsive.isTablet(context) ? 32 : 48,
  );

  static EdgeInsets screenPadding(BuildContext context) => symmetric(
    context,
    horizontal: Responsive.isMobile(context) ? 16 : Responsive.isTablet(context) ? 24 : 32,
    vertical: Responsive.isMobile(context) ? 16 : Responsive.isTablet(context) ? 24 : 32,
  );
}