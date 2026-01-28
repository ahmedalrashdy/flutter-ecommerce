import 'package:flutter/material.dart';

import 'app_colors.dart';

class DarkAppColors extends AppColors {
  // Based on Material 3 Tonal Palettes (approximate for the given light colors)

  // Primary: Light Blue (Tone 80) for Dark Theme
  @override
  final Color primary = const Color(0xFFADC6FF);
  // On Primary: Dark Blue (Tone 20) for contrast on the light primary
  @override
  final Color onPrimary = const Color(0xFF002E69);

  // Secondary: Light Teal (Tone 80) for Dark Theme
  @override
  final Color secondary = const Color(0xFF65D5C8);
  // On Secondary: Dark Teal (Tone 20)
  @override
  final Color onSecondary = const Color(0xFF003732);

  // Tertiary: Light Amber (Tone 80) for Dark Theme
  @override
  final Color tertiary = const Color(0xFFFFB94F);
  // On Tertiary: Dark Amber (Tone 20)
  @override
  final Color onTertiary = const Color(0xFF452C00);

  // Error: Light Red (Tone 80) for Dark Theme
  @override
  final Color error = const Color(0xFFFFB4AB);
  // On Error: Dark Red (Tone 20)
  @override
  final Color onError = const Color(0xFF690005);

  // Surface: Dark Grey (common standard)
  @override
  final Color surface = const Color(0xFF1F1F1F); // Or 0xFF121212
  // On Surface: Light Grey/Off-white for text on dark background
  @override
  final Color onSurface = const Color(0xFFE6E1E5); // Or 0xFFE0E0E0

  // On Surface Variant: A less prominent grey for secondary text/icons
  @override
  final Color onSurfaceVariant =
      const Color(0xFFCAC4D0); // Or Colors.white.withOpacity(0.6)

  const DarkAppColors();
}
