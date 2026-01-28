import 'package:flutter/material.dart';

abstract class AppColors {
  abstract final Color primary;
  abstract final Color onPrimary;
  abstract final Color secondary;
  abstract final Color onSecondary;
  abstract final Color tertiary;
  abstract final Color onTertiary;
  abstract final Color error;
  abstract final Color onError;
  abstract final Color surface;
  abstract final Color onSurface;
  abstract final Color onSurfaceVariant;

  const AppColors();

  static ColorScheme getColorScheme(AppColors colors, Brightness brightness) {
    return ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: colors.primary,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      secondary: colors.secondary,
      onSecondary: colors.onSecondary,
      tertiary: colors.tertiary,
      onTertiary: colors.onTertiary,
      error: colors.error,
      onError: colors.onError,
      surface: colors.surface,
      onSurface: colors.onSurface,
      onSurfaceVariant: colors.onSurfaceVariant,
    );
  }
}
