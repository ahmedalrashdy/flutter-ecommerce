import 'package:flutter/material.dart';

/// Defines standard border radius values for consistent corner styling.
class AppBorderRadiusTheme extends ThemeExtension<AppBorderRadiusTheme> {
  /// Small border radius (e.g., 4.0). Suitable for tags, chips.
  final BorderRadius small;

  /// Medium border radius (e.g., 8.0). Suitable for cards, buttons.
  final BorderRadius medium;

  /// Large border radius (e.g., 16.0). Suitable for dialogs, bottom sheets.
  final BorderRadius large;

  /// Extra large border radius (e.g., 24.0).
  final BorderRadius extraLarge;

  /// Circular border radius (often represented by a large value like 999).
  final BorderRadius circle;

  /// Default constructor for border radius values.
  const AppBorderRadiusTheme({
    this.small = const BorderRadius.all(Radius.circular(4.0)),
    this.medium = const BorderRadius.all(Radius.circular(8.0)),
    this.large = const BorderRadius.all(Radius.circular(16.0)),
    this.extraLarge = const BorderRadius.all(Radius.circular(24.0)),
    this.circle = const BorderRadius.all(
        Radius.circular(999.0)), // Common way to represent full circle
  });

  @override
  AppBorderRadiusTheme copyWith({
    BorderRadius? small,
    BorderRadius? medium,
    BorderRadius? large,
    BorderRadius? extraLarge,
    BorderRadius? circle,
  }) {
    return AppBorderRadiusTheme(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      extraLarge: extraLarge ?? this.extraLarge,
      circle: circle ?? this.circle,
    );
  }

  @override
  ThemeExtension<AppBorderRadiusTheme> lerp(
    covariant ThemeExtension<AppBorderRadiusTheme>? other,
    double t,
  ) {
    if (other is! AppBorderRadiusTheme) {
      return this;
    }
    // Interpolate BorderRadius values
    return AppBorderRadiusTheme(
      small: BorderRadius.lerp(small, other.small, t)!,
      medium: BorderRadius.lerp(medium, other.medium, t)!,
      large: BorderRadius.lerp(large, other.large, t)!,
      extraLarge: BorderRadius.lerp(extraLarge, other.extraLarge, t)!,
      circle: BorderRadius.lerp(circle, other.circle, t)!,
    );
  }
}
