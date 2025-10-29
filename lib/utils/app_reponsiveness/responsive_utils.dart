import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

enum ScreenSize {
  xs, // Extra small: < 576px
  sm, // Small: >= 576px
  md, // Medium: >= 768px
  lg, // Large: >= 992px
  xl, // Extra large: >= 1200px
}

// class ResponsiveBreakpoints {
//   static const double xs = 0;
//   static const double sm = 576;
//   static const double md = 768;
//   static const double lg = 992;
//   static const double xl = 1200;
// }

class ResponsiveBreakpoints {
  static const double xs = 0;     // Extra small devices
  static const double sm = 440;   // Small phones
  static const double md = 570;   // Large phones
  static const double lg = 720;   // Tablets / small laptops
  static const double xl = 880;   // Large tablets
  static const double xxl = 1200; // Desktops
  static const double xxxl = 1440; // Large desktops
}

class ResponsiveUtils {
  
  static DeviceType getDeviceType(double width) {
    if (width < ResponsiveBreakpoints.md) {
      return DeviceType.mobile;
    } else if (width < ResponsiveBreakpoints.lg) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  static ScreenSize getScreenSize(double width) {
    if (width < ResponsiveBreakpoints.sm) {
      return ScreenSize.xs;
    } else if (width < ResponsiveBreakpoints.md) {
      return ScreenSize.sm;
    } else if (width < ResponsiveBreakpoints.lg) {
      return ScreenSize.md;
    } else if (width < ResponsiveBreakpoints.xl) {
      return ScreenSize.lg;
    } else {
      return ScreenSize.xl;
    }
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < ResponsiveBreakpoints.md;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= ResponsiveBreakpoints.md &&
        width < ResponsiveBreakpoints.lg;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= ResponsiveBreakpoints.lg;
  }

  static double getResponsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < ResponsiveBreakpoints.sm) {
      return 16.0;
    } else if (width < ResponsiveBreakpoints.md) {
      return 24.0;
    } else if (width < ResponsiveBreakpoints.lg) {
      return 32.0;
    } else {
      return 48.0;
    }
  }

  static double getResponsiveWidth(
    BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (isMobile(context)) {
      return mobile ?? screenWidth * 0.9;
    } else if (isTablet(context)) {
      return tablet ?? screenWidth * 0.7;
    } else {
      return desktop ?? 600.0;
    }
  }

  static int getResponsiveColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < ResponsiveBreakpoints.sm) {
      return 1;
    } else if (width < ResponsiveBreakpoints.md) {
      return 2;
    } else if (width < ResponsiveBreakpoints.lg) {
      return 3;
    } else if (width < ResponsiveBreakpoints.xl) {
      return 4;
    } else {
      return 6;
    }
  }

  // static double getResponsiveFontSize(
  //   BuildContext context,
  //   double baseFontSize,
  // ) {
  //   final width = MediaQuery.of(context).size.width;
  //   if (width < ResponsiveBreakpoints.sm) {
  //     return baseFontSize * 0.85;
  //   } else if (width < ResponsiveBreakpoints.md) {
  //     return baseFontSize * 0.9;
  //   } else if (width < ResponsiveBreakpoints.lg) {
  //     return baseFontSize;
  //   } else {
  //     return baseFontSize * 1.1;
  //   }
  // }

  static double getResponsiveFontSize(
  BuildContext context,
  double baseFontSize,
) {
  final width = MediaQuery.of(context).size.width;

  if (width < 440) {
    return baseFontSize * 0.75; // very small devices
  } else if (width < 570) {
    return baseFontSize * 0.85; // small phones
  } else if (width < 720) {
    return baseFontSize * 0.9; // large phones
  } else if (width < 880) {
    return baseFontSize * 0.95; // small tablets
  } else if (width < 1200) {
    return baseFontSize * 0.85; // normal desktops
  } else if (width < 1440) {
    return baseFontSize * 1.05; // large desktops
  } else {
    return baseFontSize * 1.1; // extra-large screens
  }
}

  
}
