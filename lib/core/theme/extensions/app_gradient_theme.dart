import 'package:flutter/foundation.dart'; // For DiagnosticPropertiesBuilder
import 'package:flutter/material.dart';

/// Defines gradient styles for the application.
///
/// Use this extension to maintain consistent gradient usage across the app.
/// Most gradients adapt to the current theme's ColorScheme (light/dark),
/// while the shimmer gradient uses predefined colors for consistency.
class AppGradientTheme extends ThemeExtension<AppGradientTheme> {
  // -- Gradient Definitions --

  /// Primary gradient, typically used for main Call-To-Action buttons,
  /// prominent headers, or visually important elements.
  /// Derived from ColorScheme.primary and ColorScheme.secondary (or similar).
  final Gradient primary;

  /// Secondary gradient, used for less critical elements, highlighted cards,
  /// or section backgrounds needing a subtle distinction.
  /// Derived from ColorScheme.secondary and ColorScheme.tertiary (or similar).
  final Gradient secondary;

  /// Accent gradient, used for special offers, icons needing emphasis,
  /// or decorative elements that need to stand out.
  /// Derived from ColorScheme.tertiary and ColorScheme.primary (or similar).
  final Gradient accent;

  /// Subtle background gradient, suitable for main screen backgrounds or
  /// large areas where a plain color feels too flat. Should be very subtle.
  /// Derived from ColorScheme.background and ColorScheme.surfaceContainerLowest.
  final Gradient background;

  /// Gradient used for shimmer effects in loading skeletons.
  /// Uses predefined colors independent of the ColorScheme for a consistent look.
  final Gradient shimmer;

  final Gradient containerGradient;

  // -- Private Constructor --
  // Use the factory 'fromColorScheme' to create instances.
  const AppGradientTheme._(
      {required this.primary,
      required this.secondary,
      required this.accent,
      required this.background,
      required this.shimmer,
      required this.containerGradient});

  // --- Predefined Shimmer Gradients ---
  // These are fixed and don't change with the ColorScheme

  /// Shimmer gradient definition for light themes.
  static const Gradient _lightShimmerGradient = LinearGradient(
    colors: [
      Color(0xFFE0E0E0), // Light Gray
      Color(0xFFF5F5F5), // Lighter Gray
      Color(0xFFE0E0E0), // Light Gray
    ],
    stops: [0.4, 0.5, 0.6],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  /// Shimmer gradient definition for dark themes.
  static const Gradient _darkShimmerGradient = LinearGradient(
    colors: [
      Color(0xFF424242), // Dark Gray
      Color(0xFF616161), // Lighter Dark Gray
      Color(0xFF424242), // Dark Gray
    ],
    stops: [0.4, 0.5, 0.6],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  // -- Factory Constructor --

  /// Creates an AppGradientTheme based on the provided ColorScheme.
  ///
  /// Adjusts gradient colors based on the ColorScheme properties,
  /// except for the shimmer gradient which uses predefined values.
  factory AppGradientTheme.fromColorScheme(ColorScheme colorScheme) {
    final bool isDark = colorScheme.brightness == Brightness.dark;

    final containerGradient = isDark
        ? LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              colorScheme.primary.withOpacity(0.1),
              Colors.black,
              colorScheme.primary.withOpacity(0.05),
            ],
          )
        : LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              colorScheme.primary.withOpacity(0.1),
              Colors.white,
              colorScheme.primary.withOpacity(0.05),
            ],
          );

    // --- Define gradients based on the ColorScheme ---

    // Example Primary Gradient: Primary -> Secondary
    final primaryGradient = LinearGradient(
      colors: [
        colorScheme.primary,
        colorScheme
            .secondary, // Adjust if needed, e.g., colorScheme.primaryContainer
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // Example Secondary Gradient: Secondary -> Tertiary (or similar)
    final secondaryGradient = LinearGradient(
      colors: [
        colorScheme.secondary,
        colorScheme
            .tertiary, // Adjust if needed, e.g., colorScheme.secondaryContainer
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    // Example Accent Gradient: Tertiary -> Primary (or a bright accent)
    final accentGradient = LinearGradient(
      colors: [
        colorScheme
            .tertiary, // Adjust if needed, e.g., colorScheme.tertiaryContainer
        colorScheme.primary,
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );

    // Updated Background Gradient: Background -> Surface Container Lowest (very subtle)
    // This uses M3 surface roles for a minimal difference from the base background.
    final backgroundGradient = LinearGradient(
      colors: [
        colorScheme.surface,
        colorScheme.surfaceContainerLowest, // Subtle difference
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    // --- Select the predefined shimmer gradient ---
    final shimmerGradient =
        isDark ? _darkShimmerGradient : _lightShimmerGradient;

    return AppGradientTheme._(
        primary: primaryGradient,
        secondary: secondaryGradient,
        accent: accentGradient,
        background: backgroundGradient,
        shimmer: shimmerGradient,
        containerGradient:
            containerGradient // Assign the selected fixed shimmer
        );
  }

  // -- ThemeExtension Methods --

  @override
  AppGradientTheme copyWith({
    Gradient? primary,
    Gradient? secondary,
    Gradient? accent,
    Gradient? background,
    Gradient? shimmer,
    Gradient? containerGradient,
  }) {
    // Use the private constructor
    return AppGradientTheme._(
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
        accent: accent ?? this.accent,
        background: background ?? this.background,
        shimmer: shimmer ?? this.shimmer,
        containerGradient: containerGradient ?? this.containerGradient);
  }

  @override
  ThemeExtension<AppGradientTheme> lerp(
    covariant ThemeExtension<AppGradientTheme>? other,
    double t,
  ) {
    if (other is! AppGradientTheme) {
      return this;
    }
    return AppGradientTheme._(
      primary: Gradient.lerp(primary, other.primary, t) ?? primary,
      secondary: Gradient.lerp(secondary, other.secondary, t) ?? secondary,
      accent: Gradient.lerp(accent, other.accent, t) ?? accent,
      background: Gradient.lerp(background, other.background, t) ?? background,
      containerGradient:
          Gradient.lerp(containerGradient, other.containerGradient, t) ??
              containerGradient,
      // Lerping between predefined shimmers might look odd during theme transition,
      // but it's technically correct for smooth visual change.
      // Alternatively, you could skip lerping shimmer if instantaneous change is preferred.
      shimmer: Gradient.lerp(shimmer, other.shimmer, t) ?? shimmer,
    );
  }
}
