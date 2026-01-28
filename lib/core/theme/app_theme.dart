import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_ecommerce/core/theme/extensions/app_text_style_theme.dart';
import 'colors/app_colors.dart';
import 'extensions/app_border_radius_theme.dart';
import 'extensions/app_color_theme.dart';
import 'extensions/app_gradient_theme.dart';
import 'extensions/app_shadow_theme.dart';
import 'extensions/app_spacing_theme.dart';

class AppTheme {
  static Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);

    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  static Color lerpDarken(Color color, double factor) {
    return Color.lerp(color, Colors.black, factor)!;
  }

  static ThemeData getThemeData(AppColors colors, ThemeMode themeMode) {
    final brightness =
        themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light;

    final colorScheme = AppColors.getColorScheme(colors, brightness);

    final appColorTheme = AppColorTheme(colors: colors);

    final appShadowTheme = brightness == Brightness.light
        ? const AppShadowTheme()
        : AppShadowTheme.dark();

    const appSpacingTheme = AppSpacingTheme();

    const appBorderRadiusTheme = AppBorderRadiusTheme();

    final appGradientTheme = AppGradientTheme.fromColorScheme(colorScheme);

    const AppTextStyleTheme appTextTheme = AppTextStyleTheme();
    final baseTheme = brightness == Brightness.light
        ? ThemeData.light(useMaterial3: true)
        : ThemeData.dark(useMaterial3: true);

    final theme = baseTheme.copyWith(
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: darken(colorScheme.surface),

      // Add Custom Theme Extensions
      extensions: [
        appColorTheme,
        appShadowTheme,
        appSpacingTheme,
        appBorderRadiusTheme,
        appGradientTheme,
        appTextTheme
      ],

      // --- Component Themes ---
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 2.0,
        backgroundColor: colorScheme.surface, // Use scheme color
        foregroundColor: colorScheme.onSurface, // Icon/text color
        surfaceTintColor: colorScheme.surfaceTint, // Color tint on scroll
        shadowColor: appShadowTheme.extraSmall.color.withOpacity(0.5),
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),
        systemOverlayStyle: brightness == Brightness.light
            ? SystemUiOverlayStyle.dark // Dark icons on light status bar
            : SystemUiOverlayStyle.light, // Light icons on dark status bar
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        actionsIconTheme: IconThemeData(color: colorScheme.onSurface),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 1, // Subtle elevation
          shadowColor: appShadowTheme.small.color.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: appBorderRadiusTheme.medium, // Use theme radius
          ),
          padding: EdgeInsets.symmetric(
            vertical: appSpacingTheme.sm, // Use theme spacing
            horizontal: appSpacingTheme.lg, // Use theme spacing
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: appBorderRadiusTheme.medium, // Use theme radius
          ),
          padding: EdgeInsets.symmetric(
            vertical: appSpacingTheme.sm, // Use theme spacing
            horizontal: appSpacingTheme.md, // Use theme spacing
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(
            color: colorScheme.outline, // Use scheme outline color
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: appBorderRadiusTheme.medium, // Use theme radius
          ),
          padding: EdgeInsets.symmetric(
            vertical: appSpacingTheme.sm, // Use theme spacing
            horizontal: appSpacingTheme.lg, // Use theme spacing
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),

      cardTheme: CardTheme(
        elevation:
            0, // M3 prefers no elevation, use surface containers or outlines
        // color: colorScheme.surface, // Default is surface
        color: brightness == Brightness.light
            ? colorScheme.surface
            : colorScheme
                .surfaceContainer, // Slightly different bg for dark cards
        margin: EdgeInsets.all(appSpacingTheme.xs), // Use theme spacing
        shape: RoundedRectangleBorder(
          borderRadius: appBorderRadiusTheme.medium, // Use theme radius
          side: BorderSide(
            color: colorScheme.outlineVariant, // Subtle border
            width: 1.0,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme
            .surfaceContainerHigh, // Use appropriate surface container
        contentPadding: EdgeInsets.all(appSpacingTheme.md), // Use theme spacing
        hintStyle:
            TextStyle(color: colorScheme.onSurfaceVariant.withOpacity(0.7)),
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        // Border definition using OutlineInputBorder
        border: OutlineInputBorder(
          borderRadius: appBorderRadiusTheme.medium, // Use theme radius
          borderSide: BorderSide(color: colorScheme.outline, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: appBorderRadiusTheme.medium, // Use theme radius
          borderSide: BorderSide(
              color: colorScheme.outlineVariant,
              width: 1.0), // Subtle border when enabled
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: appBorderRadiusTheme.medium, // Use theme radius
          borderSide: BorderSide(
              color: colorScheme.primary,
              width: 2.0), // Primary color when focused
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: appBorderRadiusTheme.medium, // Use theme radius
          borderSide: BorderSide(color: colorScheme.error, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: appBorderRadiusTheme.medium, // Use theme radius
          borderSide: BorderSide(
              color: colorScheme.error,
              width: 2.0), // Error color thicker when focused
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        elevation: 4.0,
        // shape: RoundedRectangleBorder(borderRadius: appBorderRadiusTheme.large), // Optional: Define shape if needed
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor:
            colorScheme.surfaceContainer, // M3 uses surface container
        elevation: 2.0,
        selectedItemColor:
            colorScheme.primary, // Or onSecondaryContainer depending on M3 role
        unselectedItemColor: colorScheme.onSurfaceVariant,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.secondaryContainer, // Use scheme container
        labelStyle: TextStyle(
            color: colorScheme.onSecondaryContainer, // Text color on container
            fontWeight: FontWeight.w500),
        side: BorderSide.none, // M3 often uses filled chips without border
        shape: RoundedRectangleBorder(
            borderRadius: appBorderRadiusTheme.circle), // Use theme radius
        padding: EdgeInsets.symmetric(
            horizontal: appSpacingTheme.sm,
            vertical: appSpacingTheme.xs), // Use theme spacing
        elevation: 0, // M3 chips usually have no elevation
        pressElevation: 1,
      ),

      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surface, // Use scheme surface
        elevation: 6.0, // M3 standard elevation for dialogs
        shadowColor: appShadowTheme
            .dialog.color, // Use dialog shadow color from theme extension
        // shape: RoundedRectangleBorder(
        //     borderRadius: appBorderRadiusTheme.large), // Use theme radius
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20, // Adjusted for typical dialog title
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(
          color: colorScheme.onSurfaceVariant, // Use variant for less emphasis
          fontSize: 16,
        ),
      ),
      dialogBackgroundColor: Colors.white,

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.primary,
        selectionColor:
            colorScheme.primary.withOpacity(0.3), // Semi-transparent primary
        selectionHandleColor: colorScheme.primary,
      ),
    );

    return theme;
  }
}
