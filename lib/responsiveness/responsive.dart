import 'package:flutter/widgets.dart';

/// ✅ Universal Responsive Helper Class
/// Works for Mobile, Web, and Desktop — scales width, height, and font sizes.
class Responsive {
  static const double baseWidth = 375.0;  // Reference iPhone 11 width
  static const double baseHeight = 812.0; // Reference iPhone 11 height

  /// Responsive Width
  static double w(BuildContext context, double width) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * (width / baseWidth);
  }

  /// Responsive Height
  static double h(BuildContext context, double height) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * (height / baseHeight);
  }

  /// Responsive Font Size (auto clamps between min & max)
  static double f(BuildContext context, double fontSize,
      {double min = 12, double max = 24}) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    final screenWidth = MediaQuery.of(context).size.width;
    final scaled = (screenWidth / baseWidth) * fontSize / scaleFactor;
    return scaled.clamp(min, max);
  }
}

/// ✅ Extension for cleaner usage
extension ResponsiveExtension on BuildContext {
  double rw(double width) => Responsive.w(this, width);
  double rh(double height) => Responsive.h(this, height);
  double rf(double fontSize, {double min = 12, double max = 24}) =>
      Responsive.f(this, fontSize, min: min, max: max);
}

/// ✅ Usage Example how I use this in my project
// Container(
//   width: context.rw(120),
//   height: context.rh(60),
//   child: Text(
//     'Hello',
//     style: TextStyle(fontSize: context.rf(16)),
//   ),
// )
