// extensions/responsive_context_enhanced.dart
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../constants/breakpoints.dart';

extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  EdgeInsets get screenPadding => MediaQuery.paddingOf(this);

  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  Orientation get orientation => MediaQuery.orientationOf(this);

  bool get isMobile => screenSize.shortestSide < kMobileBreakpoint;

  bool get isTabletDevice =>
      screenSize.shortestSide >= kMobileBreakpoint &&
      screenSize.shortestSide < kTabletBreakpoint;

  bool get isDesktop => screenWidth >= kTabletBreakpoint;

  bool get isPortrait => orientation == Orientation.portrait;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isKeyboardVisible => viewInsets.bottom > 0;

  T selectResponsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTabletDevice && tablet != null) return tablet;
    return mobile;
  }

  T selectByOrientation<T>({
    required T portrait,
    required T landscape,
  }) {
    return isPortrait ? portrait : landscape;
  }

  AppLocalizations get tr => AppLocalizations.of(this)!;
}
