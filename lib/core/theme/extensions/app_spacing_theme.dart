import 'dart:ui';

import 'package:flutter/material.dart';

/// Defines standard spacing values for consistent layout rhythms.
/// Helps maintain visual consistency for padding and margins.
class AppSpacingTheme extends ThemeExtension<AppSpacingTheme> {
  /// Extra extra small spacing value (e.g., 2.0).
  final double xxs;

  /// Extra small spacing value (e.g., 4.0).
  final double xs;

  /// Small spacing value (e.g., 8.0).
  final double sm;

  /// Medium spacing value (e.g., 16.0).
  final double md;

  /// Large spacing value (e.g., 24.0).
  final double lg;

  /// Extra large spacing value (e.g., 32.0).
  final double xl;

  /// Extra extra large spacing value (e.g., 48.0).
  final double xxl;

  /// Default constructor for spacing values.
  const AppSpacingTheme({
    this.xxs = 2.0,
    this.xs = 4.0,
    this.sm = 8.0,
    this.md = 16.0,
    this.lg = 24.0,
    this.xl = 32.0,
    this.xxl = 48.0,
  });

  @override
  AppSpacingTheme copyWith({
    double? xxs,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return AppSpacingTheme(
      xxs: xxs ?? this.xxs,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  ThemeExtension<AppSpacingTheme> lerp(
    covariant ThemeExtension<AppSpacingTheme>? other,
    double t,
  ) {
    if (other is! AppSpacingTheme) {
      return this;
    }
    // Interpolate spacing values
    return AppSpacingTheme(
      xxs: lerpDouble(xxs, other.xxs, t)!,
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      xxl: lerpDouble(xxl, other.xxl, t)!,
    );
  }
}
