import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
// Import your AppColors and implementations (LightAppColors, DarkAppColors)

// The Theme Extension class
class AppColorTheme extends ThemeExtension<AppColorTheme> {
  final AppColors colors;

  const AppColorTheme({required this.colors});

  @override
  AppColorTheme copyWith({AppColors? colors}) {
    return AppColorTheme(
      colors: colors ?? this.colors,
    );
  }

  @override
  AppColorTheme lerp(ThemeExtension<AppColorTheme>? other, double t) {
    if (other is! AppColorTheme) {
      return this; // Return current instance if types don't match
    }

    return t < 0.5 ? this : other;
  }
}
