import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_public_website/library/constants/breakpoints.dart';


/// Extensions for BuildContext class
extension ContextExtensions on BuildContext {
  /// Get the current theme
  ThemeData get theme => Theme.of(this);

  /// Get the current color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get the current text theme
  TextTheme get textTheme => theme.textTheme;

  /// Get the current media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get the current screen size
  Size get screenSize => mediaQuery.size;

  /// Get the current screen width
  double get screenWidth => screenSize.width;

  /// Get the current screen height
  double get screenHeight => screenSize.height;

  /// Get the current device pixel ratio
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// Get the current orientation
  Orientation get orientation => mediaQuery.orientation;

  /// Check if the device is in landscape mode
  bool get isLandscape => orientation == Orientation.landscape;

  /// Check if the device is in portrait mode
  bool get isPortrait => orientation == Orientation.portrait;

  /// Get the current device type
  DeviceType get deviceType => Breakpoints.getDeviceTypeFromContext(this);

  /// Check if the current device is mobile
  bool get isMobile => Breakpoints.isMobile(screenWidth);

  /// Check if the current device is tablet
  bool get isTablet => Breakpoints.isTablet(screenWidth);

  /// Check if the current device is desktop
  bool get isDesktop => Breakpoints.isDesktop(screenWidth);

  /// Get responsive value based on screen width
  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    return Breakpoints.responsiveFromContext(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get responsive padding
  EdgeInsets get responsivePadding => Breakpoints.responsivePadding(screenWidth);

  /// Get responsive margin
  EdgeInsets get responsiveMargin => Breakpoints.responsiveMargin(screenWidth);

  /// Get responsive font size
  double responsiveFontSize({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return Breakpoints.responsiveFontSize(
      screenWidth,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get responsive column count
  int get responsiveColumns => Breakpoints.responsiveColumns(screenWidth);

  /// Get responsive spacing
  double get responsiveSpacing => Breakpoints.responsiveSpacing(screenWidth);

  /// Get responsive border radius
  double get responsiveBorderRadius => Breakpoints.responsiveBorderRadius(screenWidth);

  /// Get responsive elevation
  double get responsiveElevation => Breakpoints.responsiveElevation(screenWidth);

  /// Get responsive icon size
  double get responsiveIconSize => Breakpoints.responsiveIconSize(screenWidth);

  /// Get responsive button height
  double get responsiveButtonHeight => Breakpoints.responsiveButtonHeight(screenWidth);

  /// Get responsive app bar height
  double get responsiveAppBarHeight => Breakpoints.responsiveAppBarHeight(screenWidth);

  /// Get responsive drawer width
  double get responsiveDrawerWidth => Breakpoints.responsiveDrawerWidth(screenWidth);

  /// Get responsive sidebar width
  double get responsiveSidebarWidth => Breakpoints.responsiveSidebarWidth(screenWidth);

  /// Get responsive content max width
  double get responsiveContentMaxWidth => Breakpoints.responsiveContentMaxWidth(screenWidth);

  /// Get responsive grid aspect ratio
  double get responsiveGridAspectRatio => Breakpoints.responsiveGridAspectRatio(screenWidth);

  /// Get the current locale
  Locale get locale => Localizations.localeOf(this);

  /// Get the current language code
  String get languageCode => locale.languageCode;

  /// Get the current country code
  String? get countryCode => locale.countryCode;

  /// Check if the current locale is RTL
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;

  /// Check if the current locale is LTR
  bool get isLTR => Directionality.of(this) == TextDirection.ltr;

  /// Get the current text direction
  TextDirection get textDirection => Directionality.of(this);

  /// Get the current focus scope
  FocusScopeNode get focusScope => FocusScope.of(this);

  /// Get the current primary focus
  //FocusNode? get primaryFocus => focusScope.primaryFocus;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => mediaQuery.viewInsets.bottom > 0;

  /// Get keyboard height
  double get keyboardHeight => mediaQuery.viewInsets.bottom;

  /// Get safe area padding
  EdgeInsets get safeAreaPadding => mediaQuery.padding;

  /// Get safe area view padding
  EdgeInsets get safeAreaViewPadding => mediaQuery.viewPadding;

  /// Get the current scaffold
  ScaffoldState? get scaffold => Scaffold.maybeOf(this);

  /// Get the current app bar
  // PreferredSizeWidget? get appBar => scaffold?.appBar;

  // /// Get the current drawer
  // Widget? get drawer => scaffold?.drawer;

  // /// Get the current end drawer
  // Widget? get endDrawer => scaffold?.endDrawer;

  // /// Get the current bottom navigation bar
  // Widget? get bottomNavigationBar => scaffold?.bottomNavigationBar;

  // /// Get the current floating action button
  // Widget? get floatingActionButton => scaffold?.floatingActionButton;

  // /// Get the current floating action button location
  // FloatingActionButtonLocation? get floatingActionButtonLocation => scaffold?.floatingActionButtonLocation;

  // /// Get the current navigation bar
  // NavigationBar? get navigationBar => NavigationBar.maybeOf(this);

  // /// Get the current navigation rail
  // NavigationRail? get navigationRail => NavigationRail.maybeOf(this);

  /// Show a snack bar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
    Color? textColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    SnackBarBehavior? behavior,
    bool? showCloseIcon,
    Color? closeIconColor,
    Duration? actionOverflowThreshold,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
        behavior: behavior ?? SnackBarBehavior.floating,
        margin: margin,
        padding: padding,
        width: width,
        shape: shape,
        elevation: elevation,
        showCloseIcon: showCloseIcon,
        closeIconColor: closeIconColor,
       // actionOverflowThreshold: actionOverflowThreshold,
      ),
    );
  }

  /// Show a success snack bar
  void showSuccessSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  /// Show an error snack bar
  void showErrorSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  /// Show a warning snack bar
  void showWarningSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
    );
  }

  /// Show an info snack bar
  void showInfoSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }

  /// Show a loading dialog
  void showLoadingDialog({String? message}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              const SizedBox(width: 16),
              Expanded(child: Text(message)),
            ],
          ],
        ),
      ),
    );
  }

  /// Hide loading dialog
  void hideLoadingDialog() {
    Navigator.of(this).pop();
  }

  /// Show a confirmation dialog
  Future<bool?> showConfirmDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color? confirmColor,
    Color? cancelColor,
  }) {
    return showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(foregroundColor: cancelColor),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: confirmColor),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  /// Show an alert dialog
  Future<void> showAlertDialog({
    required String title,
    required String message,
    String buttonText = 'OK',
    Color? buttonColor,
  }) {
    return showDialog<void>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(foregroundColor: buttonColor),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  /// Show a bottom sheet
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool useSafeArea = false,
    bool showDragHandle = false,
    bool isDraggable = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      showDragHandle: showDragHandle,
      //isDraggable: isDraggable,
      builder: (context) => child,
    );
  }

  /// Navigate to a route
  Future<T?> navigateTo<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  /// Navigate to a route and replace current route
  Future<T?> navigateToReplacement<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushReplacementNamed<T, T>(routeName, arguments: arguments);
  }

  /// Navigate to a route and clear all previous routes
  Future<T?> navigateToAndClearStack<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Pop the current route
  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Pop until a specific route
  void popUntil(String routeName) {
    Navigator.of(this).popUntil(ModalRoute.withName(routeName));
  }

  /// Check if can pop
  bool get canPop => Navigator.of(this).canPop();

  /// Hide keyboard
  void hideKeyboard() {
    primaryFocus?.unfocus();
  }

  /// Show keyboard
  void showKeyboard() {
    primaryFocus?.requestFocus();
  }

  /// Vibrate the device
  void vibrate({Duration duration = const Duration(milliseconds: 100)}) {
    HapticFeedback.vibrate();
  }

  /// Light impact haptic feedback
  void lightImpact() {
    HapticFeedback.lightImpact();
  }

  /// Medium impact haptic feedback
  void mediumImpact() {
    HapticFeedback.mediumImpact();
  }

  /// Heavy impact haptic feedback
  void heavyImpact() {
    HapticFeedback.heavyImpact();
  }

  /// Selection haptic feedback
  void selectionClick() {
    HapticFeedback.selectionClick();
  }

  /// Get the current route name
  String? get currentRouteName {
    final route = ModalRoute.of(this);
    return route?.settings.name;
  }

  /// Get the current route arguments
  Object? get currentRouteArguments {
    final route = ModalRoute.of(this);
    return route?.settings.arguments;
  }

  /// Check if the current route is the first route
  bool get isFirstRoute {
    return !canPop;
  }

  /// Get the current route depth
  int get routeDepth {
    int depth = 0;
    Navigator.of(this).popUntil((route) {
      depth++;
      return route.isFirst;
    });
    return depth;
  }
}
