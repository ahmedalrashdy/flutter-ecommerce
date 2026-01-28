import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Define AppShadowTheme extension
class AppShadowTheme extends ThemeExtension<AppShadowTheme> {
  // -- Shadow Definitions --

  /// ظل خفيف جدًا، مناسب للعناصر التي تحتاج إلى تمييز بسيط جدًا
  /// مثل شريط التطبيق (AppBar) أو الفواصل الدقيقة.
  final BoxShadow extraSmall;

  /// ظل صغير، مثالي للبطاقات في حالتها الطبيعية (غير مرفوعة)
  /// أو العناصر التي تحتاج إلى ارتفاع بسيط.
  final BoxShadow small;

  /// ظل متوسط، مناسب للعناصر المرفوعة قليلاً مثل الأزرار،
  /// أو البطاقات عند التمرير فوقها (hover).
  final BoxShadow medium;

  /// ظل كبير، يستخدم للعناصر البارزة مثل الأزرار العائمة (FAB)
  /// أو العناصر التي تحتاج إلى بروز واضح.
  final BoxShadow large;

  /// ظل قوي جدًا، مخصص لمربعات الحوار (Dialogs)، القوائم السفلية (Bottom Sheets)،
  /// أو أي عنصر يحتاج للظهور بوضوح فوق المحتوى الآخر.
  final BoxShadow dialog;

  // -- Constructors --

  /// Constructor for Light Mode (Default)
  const AppShadowTheme({
    this.extraSmall = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05), // Black with 5% opacity
      blurRadius: 4.0,
      offset: Offset(0, 1),
    ),
    this.small = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.08), // Black with 8% opacity
      blurRadius: 8.0,
      offset: Offset(0, 2),
    ),
    this.medium = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.12), // Black with 12% opacity
      blurRadius: 12.0,
      offset: Offset(0, 4),
    ),
    this.large = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.16), // Black with 16% opacity
      blurRadius: 18.0,
      offset: Offset(0, 8),
    ),
    this.dialog = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.20), // Black with 20% opacity
      blurRadius: 24.0,
      offset: Offset(0, 12),
    ),
  });

  /// Factory constructor for Dark Mode
  factory AppShadowTheme.dark() {
    // Dark mode shadows might need to be slightly more opaque or have larger blurs
    // to be visible against dark backgrounds. Adjust these values as needed.
    return const AppShadowTheme(
      extraSmall: BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.10), // Black with 10% opacity
        blurRadius: 4.0,
        offset: Offset(0, 1),
      ),
      small: BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.15), // Black with 15% opacity
        blurRadius: 8.0,
        offset: Offset(0, 2),
      ),
      medium: BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.20), // Black with 20% opacity
        blurRadius: 12.0,
        offset: Offset(0, 4),
      ),
      large: BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.25), // Black with 25% opacity
        blurRadius: 18.0,
        offset: Offset(0, 8),
      ),
      dialog: BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.30), // Black with 30% opacity
        blurRadius: 24.0,
        offset: Offset(0, 12),
      ),
    );
  }

  // -- ThemeExtension Methods --

  @override
  AppShadowTheme copyWith({
    BoxShadow? extraSmall,
    BoxShadow? small,
    BoxShadow? medium,
    BoxShadow? large,
    BoxShadow? dialog,
  }) {
    return AppShadowTheme(
      extraSmall: extraSmall ?? this.extraSmall,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      dialog: dialog ?? this.dialog,
    );
  }

  @override
  ThemeExtension<AppShadowTheme> lerp(
    covariant ThemeExtension<AppShadowTheme>? other,
    double t,
  ) {
    if (other is! AppShadowTheme) {
      return this; // Return current instance if other is not the correct type
    }
    // Interpolate each shadow property
    return AppShadowTheme(
      extraSmall: BoxShadow.lerp(extraSmall, other.extraSmall, t)!,
      small: BoxShadow.lerp(small, other.small, t)!,
      medium: BoxShadow.lerp(medium, other.medium, t)!,
      large: BoxShadow.lerp(large, other.large, t)!,
      dialog: BoxShadow.lerp(dialog, other.dialog, t)!,
    );
  }
}
