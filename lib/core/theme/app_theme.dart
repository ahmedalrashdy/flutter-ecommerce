import 'package:flutter/material.dart';

abstract class AppTheme {
  static bool _isDarkMode = false;

  static void setDarkMode(bool isDark) {
    _isDarkMode = isDark;
  }

  static Color get primaryColor =>
      _isDarkMode ? _darkPrimaryColor : _lightPrimaryColor;
  static const Color _lightPrimaryColor = Color(0xFFE94444);
  static const Color _darkPrimaryColor = Color(0xFFA30B0B);

  static Color get deepPrimaryColor =>
      _isDarkMode ? _darkDeepPrimaryColor : _lightDeepPrimaryColor;
  static const Color _lightDeepPrimaryColor = Color.fromARGB(255, 163, 11, 11);
  static const Color _darkDeepPrimaryColor = Color(0xFF7A0707);

  static Color get secondaryColor =>
      _isDarkMode ? _darkSecondaryColor : _lightSecondaryColor;
  static const Color _lightSecondaryColor = Color(0xFFE94444);
  static const Color _darkSecondaryColor = Color(0xFFA30B0B);

  static Color get accentColor =>
      _isDarkMode ? _darkAccentColor : _lightAccentColor;
  static const Color _lightAccentColor = Color(0xFFFFA726);
  static const Color _darkAccentColor = Color(0xFFFFD700);

  static Color get backgroundColor =>
      _isDarkMode ? _darkBackgroundColor : _lightBackgroundColor;
  static const Color _lightBackgroundColor = Color(0xFFF5F5F5);
  static const Color _darkBackgroundColor = Color(0xFF121212);

  static Color get cardColor => _isDarkMode ? _darkCardColor : _lightCardColor;
  static const Color _lightCardColor = Colors.white;
  static const Color _darkCardColor = Color(0xFF2A2A2A);

  static Color get textColor => _isDarkMode ? _darkTextColor : _lightTextColor;
  static const Color _lightTextColor = Color(0xFF2B2B2B);
  static const Color _darkTextColor = Colors.white;

  static Color get greyTextColor =>
      _isDarkMode ? _darkGreyTextColor : _lightGreyTextColor;
  static const Color _lightGreyTextColor = Color(0xFF757575);
  static const Color _darkGreyTextColor = Color(0xFFB0B0B0);

  static Color get lightGreyColor =>
      _isDarkMode ? _darkLightGreyColor : _lightLightGreyColor;
  static const Color _lightLightGreyColor = Color(0xFFEEEEEE);
  static const Color _darkLightGreyColor = Color(0xFF3A3A3A);

  static Color get seconderTextColor =>
      _isDarkMode ? _darkSeconderTextColor : _lightSeconderTextColor;
  static const Color _lightSeconderTextColor = Color(0xff858587);
  static const Color _darkSeconderTextColor = Color(0xFFB0B0B0);

  static Color get primaryTextColor =>
      _isDarkMode ? _darkPrimaryTextColor : _lightPrimaryTextColor;
  static const Color _lightPrimaryTextColor = Color(0xff222122);
  static const Color _darkPrimaryTextColor = Colors.white;

  static ThemeData get light => ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        cardColor: cardColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          surface: backgroundColor,
        ),
        primaryIconTheme: const IconThemeData(color: Colors.white, size: 22),
        appBarTheme: AppBarTheme(
          backgroundColor: cardColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white70),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: TextTheme(
            bodyLarge: TextStyle(
          color: textColor,
          fontSize: 16,
        )),
        iconTheme: IconThemeData(
          color: primaryColor,
          size: 24,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            side: BorderSide(color: primaryColor),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: lightGreyColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryColor),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          unselectedItemColor: greyTextColor,
          selectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
          ),
          type: BottomNavigationBarType.fixed,
          elevation: 12,
        ),
      );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark, // Important for system-level dark mode
    primaryColor: AppTheme.primaryColor,
    scaffoldBackgroundColor: AppTheme.backgroundColor,
    cardColor: AppTheme.cardColor,
    colorScheme: ColorScheme.dark(
      primary: AppTheme.primaryColor,
      secondary: AppTheme.secondaryColor,
      surface: AppTheme.backgroundColor,
      background: AppTheme.backgroundColor,
      onBackground: AppTheme.textColor,
      onSurface: AppTheme.textColor,
    ),
    primaryIconTheme: IconThemeData(
      color: AppTheme.textColor, // Use theme text color instead of hardcoded
      size: 22,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppTheme.cardColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color:
            AppTheme.textColor.withOpacity(0.7), // Match light theme's white70
      ),
      titleTextStyle: TextStyle(
        color: AppTheme.textColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppTheme.textColor,
        fontSize: 16,
      ),
    ),
    iconTheme: IconThemeData(
      color: AppTheme.primaryColor,
      size: 24,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppTheme.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.primaryColor,
        side: BorderSide(color: AppTheme.primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppTheme.lightGreyColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppTheme.primaryColor),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppTheme.cardColor,
      selectedItemColor: AppTheme.primaryColor,
      unselectedItemColor: AppTheme.greyTextColor,
      selectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 12,
    ),
  );
}
