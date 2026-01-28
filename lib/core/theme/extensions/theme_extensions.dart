// lib/theme/app_theme_access.dart
import 'package:flutter/material.dart';

// --- Import your custom theme extension classes ---
// Adjust paths as per your project structure
import '../colors/app_colors.dart';
import 'app_color_theme.dart';
import 'app_spacing_theme.dart';
import 'app_border_radius_theme.dart';
import 'app_shadow_theme.dart';
import 'app_gradient_theme.dart';
import 'app_text_style_theme.dart';
import 'dart:ui' show lerpDouble;
// Import other custom themes if you have them (e.g., AppAnimationTheme)

/// Extension on BuildContext to provide easy access to custom theme extensions
/// and common ThemeData properties like ColorScheme and TextTheme.
///
/// Instead of writing `context.extension<AppSpacingTheme>()!`,
/// you can simply use `context.spacing`.
///
/// Assumes that the required theme extensions are registered in the [ThemeData]
/// provided by an ancestor [Theme] widget.
extension AppThemeAccess on BuildContext {
  /// Provides access to the app's spacing theme values.
  /// Assumes [AppSpacingTheme] is registered in the [ThemeData].
  AppSpacingTheme get spacing => Theme.of(this).extension<AppSpacingTheme>()!;

  /// Provides access to the app's border radius theme values.
  /// Assumes [AppBorderRadiusTheme] is registered in the [ThemeData].
  AppBorderRadiusTheme get borders =>
      Theme.of(this).extension<AppBorderRadiusTheme>()!;

  /// Provides access to the app's shadow theme values.
  /// Assumes [AppShadowTheme] is registered in the [ThemeData].
  AppShadowTheme get shadows => Theme.of(this).extension<AppShadowTheme>()!;
  AppColors get colors => Theme.of(this).extension<AppColorTheme>()!.colors;

  /// Provides access to the app's gradient theme values.
  /// Assumes [AppGradientTheme] is registered in the [ThemeData].
  AppGradientTheme get gradients =>
      Theme.of(this).extension<AppGradientTheme>()!;

  // --- Optional: Add access to other custom extensions ---
  // AppAnimationTheme get animations => Theme.of(this).extension<AppAnimationTheme>()!;

  // --- Optional but convenient: Access to standard theme parts ---

  /// Provides easy access to the current theme's [ColorScheme].
  /// Equivalent to `Theme.of(this).colorScheme`.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Provides easy access to the current theme's Brightness (light/dark).
  /// Equivalent to `Theme.of(this).brightness`.
  Brightness get brightness => Theme.of(this).brightness;

  /// Checks if the current theme brightness is Dark.
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  AppTextStyleTheme get appTextTheme =>
      Theme.of(this).extension<AppTextStyleTheme>()!;

  @override
  TextTheme get textStyleTheme => Theme.of(this).textTheme;

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);

    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  Color lerpDarken(Color color, double factor) {
    return Color.lerp(color, Colors.black, factor)!;
  }
}
