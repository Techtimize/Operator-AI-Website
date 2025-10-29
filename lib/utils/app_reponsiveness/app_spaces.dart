import 'package:flutter/material.dart';
import 'package:new_public_website/utils/app_reponsiveness/responsive_utils.dart';


class AppSpaces {
  /// Base vertical spacing that scales with screen height
 static double vertical(BuildContext context, [double baseValue = 16.0]) {
    final height = MediaQuery.of(context).size.height;

    if (height < ResponsiveBreakpoints.sm) {
      return baseValue * 0.75;
    } else if (height < ResponsiveBreakpoints.md) {
      return baseValue;
    } else if (height < ResponsiveBreakpoints.lg) {
      return baseValue * 1.25;
    } else {
      return baseValue * 1.5;
    }
  }

  ///  Base horizontal spacing that scales with screen width
  static double horizontal(BuildContext context, [double baseValue = 16.0]) {
    final width = MediaQuery.of(context).size.width;

    if (width < ResponsiveBreakpoints.sm) {
      return baseValue * 0.75;
    } else if (width < ResponsiveBreakpoints.md) {
      return baseValue;
    } else if (width < ResponsiveBreakpoints.lg) {
      return baseValue * 1.25;
    } else {
      return baseValue * 1.5;
    }
  }

  ///  Ready-to-use vertical `SizedBox`
  static SizedBox verticalBox(BuildContext context, [double baseValue = 16.0]) {
    return SizedBox(height: vertical(context, baseValue));
  }

  ///  Ready-to-use horizontal `SizedBox`
  static SizedBox horizontalBox(
    BuildContext context, [
    double baseValue = 16.0,
  ]) {
    return SizedBox(width: horizontal(context, baseValue));
  }

  ///  Optional: Common paddings
  static EdgeInsets screenPadding(BuildContext context) {
    final h = horizontal(context, 24);
    final v = vertical(context, 20);
    return EdgeInsets.symmetric(horizontal: h, vertical: v);
  }

  ///  Optional: Custom responsive padding with parameters
static EdgeInsets customPadding(
  BuildContext context, {
  double h = 24,
  double v = 20,
}) {
  final horizontalPadding = horizontal(context, h);
  final verticalPadding = vertical(context, v);
  return EdgeInsets.symmetric(
    horizontal: horizontalPadding,
    vertical: verticalPadding,
  );
}

static EdgeInsets only(
  BuildContext context, {
  double left = 0,
  double right = 0,
  double top = 0,
  double bottom = 0,
}) {
  return EdgeInsets.only(
    left: horizontal(context, left),
    right: horizontal(context, right),
    top: vertical(context, top),
    bottom: vertical(context, bottom),
  );
}

///  Responsive padding applied equally to all sides
static EdgeInsets all(BuildContext context, double value) {
  final horizontalPadding = horizontal(context, value);
  final verticalPadding = vertical(context, value);
  return EdgeInsets.symmetric(
    horizontal: horizontalPadding,
    vertical: verticalPadding,
  );
}

///  Responsive symmetric margin helper
static EdgeInsets marginSymmetric(
  BuildContext context, {
  double horizontal = 0,
  double vertical = 0,
}) {
  return EdgeInsets.symmetric(
    horizontal: horizontal == 0 ? 0 : AppSpaces.horizontal(context, horizontal),
    vertical: vertical == 0 ? 0 : AppSpaces.vertical(context, vertical),
  );
}

}
