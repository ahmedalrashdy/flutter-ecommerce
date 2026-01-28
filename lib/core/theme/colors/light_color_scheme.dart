import 'package:flutter/material.dart';

import 'app_colors.dart';

class LightAppColors extends AppColors {
  @override
  final Color primary = const Color(0xFF1976D2); // Material Blue 700

  @override
  final Color onPrimary = const Color(0xFFFFFFFF); // White text on Primary

  @override
  final Color secondary = const Color(0xFF00897B); // Material Teal 600

  @override
  final Color onSecondary = const Color(0xFFFFFFFF); // White text on Secondary

  @override
  final Color tertiary = const Color(0xFFFFA000); // Material Amber 700

  @override
  final Color onTertiary = const Color(0xFF000000); // Black text on Tertiary

  @override
  final Color error = const Color(0xFFD32F2F); // Material Red 700

  @override
  final Color onError = const Color(0xFFFFFFFF); // White text on Error

  @override
  final Color surface = const Color(0xFFFFFFFF); // White surface

  @override
  final Color onSurface = const Color(0xFF1F1F1F); // Dark gray text on Surface

  @override
  final Color onSurfaceVariant = Colors.black38;

  const LightAppColors();
}
