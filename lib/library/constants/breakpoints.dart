import 'package:flutter/material.dart';

/// Responsive breakpoints for the application
class Breakpoints {
  Breakpoints._();

  // Mobile breakpoints
  static const double mobileSmall = 320;
  static const double mobileMedium = 375;
  static const double mobileLarge = 414;

  // Tablet breakpoints
  static const double tabletSmall = 768;
  static const double tabletLarge = 1024;

  // Desktop breakpoints
  static const double desktopSmall = 1280;
  static const double desktopMedium = 1440;
  static const double desktopLarge = 1920;

  // Custom breakpoints
  static const double mobileMax = 767;
  static const double tabletMax = 1023;
  static const double desktopMin = 1024;

  /// Check if the screen width is mobile
  static bool isMobile(double width) {
    return width <= mobileMax;
  }

  /// Check if the screen width is tablet
  static bool isTablet(double width) {
    return width > mobileMax && width <= tabletMax;
  }

  /// Check if the screen width is desktop
  static bool isDesktop(double width) {
    return width >= desktopMin;
  }

  /// Get the device type based on screen width
  static DeviceType getDeviceType(double width) {
    if (isMobile(width)) return DeviceType.mobile;
    if (isTablet(width)) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  /// Get the device type from MediaQuery
  static DeviceType getDeviceTypeFromContext(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return getDeviceType(width);
  }

  /// Get responsive value based on screen width
  static T responsive<T>(
    double width, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(width)) {
      return desktop ?? tablet ?? mobile;
    } else if (isTablet(width)) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }

  /// Get responsive value from BuildContext
  static T responsiveFromContext<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final width = MediaQuery.of(context).size.width;
    return responsive(width, mobile: mobile, tablet: tablet, desktop: desktop);
  }

  /// Get responsive padding based on screen width
  static EdgeInsets responsivePadding(double width) {
    return responsive(
      width,
      mobile: const EdgeInsets.all(16),
      tablet: const EdgeInsets.all(24),
      desktop: const EdgeInsets.all(32),
    );
  }

  /// Get responsive margin based on screen width
  static EdgeInsets responsiveMargin(double width) {
    return responsive(
      width,
      mobile: const EdgeInsets.all(8),
      tablet: const EdgeInsets.all(12),
      desktop: const EdgeInsets.all(16),
    );
  }

  /// Get responsive font size based on screen width
  static double responsiveFontSize(double width, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return responsive(
      width,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.1,
      desktop: desktop ?? mobile * 1.2,
    );
  }

  /// Get responsive column count for grid layouts
  static int responsiveColumns(double width) {
    return responsive(
      width,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
  }

  /// Get responsive spacing based on screen width
  static double responsiveSpacing(double width) {
    return responsive(
      width,
      mobile: 8.0,
      tablet: 12.0,
      desktop: 16.0,
    );
  }

  /// Get responsive border radius based on screen width
  static double responsiveBorderRadius(double width) {
    return responsive(
      width,
      mobile: 8.0,
      tablet: 12.0,
      desktop: 16.0,
    );
  }

  /// Get responsive elevation based on screen width
  static double responsiveElevation(double width) {
    return responsive(
      width,
      mobile: 2.0,
      tablet: 4.0,
      desktop: 6.0,
    );
  }

  /// Get responsive icon size based on screen width
  static double responsiveIconSize(double width) {
    return responsive(
      width,
      mobile: 20.0,
      tablet: 24.0,
      desktop: 28.0,
    );
  }

  /// Get responsive button height based on screen width
  static double responsiveButtonHeight(double width) {
    return responsive(
      width,
      mobile: 40.0,
      tablet: 44.0,
      desktop: 48.0,
    );
  }

  /// Get responsive app bar height based on screen width
  static double responsiveAppBarHeight(double width) {
    return responsive(
      width,
      mobile: 56.0,
      tablet: 64.0,
      desktop: 72.0,
    );
  }

  /// Get responsive drawer width based on screen width
  static double responsiveDrawerWidth(double width) {
    return responsive(
      width,
      mobile: 280.0,
      tablet: 320.0,
      desktop: 360.0,
    );
  }

  /// Get responsive sidebar width based on screen width
  static double responsiveSidebarWidth(double width) {
    return responsive(
      width,
      mobile: 0.0, // No sidebar on mobile
      tablet: 200.0,
      desktop: 240.0,
    );
  }

  /// Get responsive content max width based on screen width
  static double responsiveContentMaxWidth(double width) {
    return responsive(
      width,
      mobile: double.infinity,
      tablet: 768.0,
      desktop: 1200.0,
    );
  }

  /// Get responsive grid aspect ratio based on screen width
  static double responsiveGridAspectRatio(double width) {
    return responsive(
      width,
      mobile: 1.0,
      tablet: 1.2,
      desktop: 1.5,
    );
  }
}

/// Device type enumeration
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

/// Responsive helper mixin
mixin ResponsiveMixin {
  /// Get device type from context
  DeviceType getDeviceType(BuildContext context) {
    return Breakpoints.getDeviceTypeFromContext(context);
  }

  /// Check if current device is mobile
  bool isMobile(BuildContext context) {
    return Breakpoints.isMobile(MediaQuery.of(context).size.width);
  }

  /// Check if current device is tablet
  bool isTablet(BuildContext context) {
    return Breakpoints.isTablet(MediaQuery.of(context).size.width);
  }

  /// Check if current device is desktop
  bool isDesktop(BuildContext context) {
    return Breakpoints.isDesktop(MediaQuery.of(context).size.width);
  }

  /// Get responsive value from context
  T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    return Breakpoints.responsiveFromContext(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}
