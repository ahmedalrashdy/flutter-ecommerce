import 'package:flutter/material.dart';

class AppTextStyleTheme extends ThemeExtension<AppTextStyleTheme> {
  final TextStyle bold14;
  final TextStyle bold16;
  final TextStyle bold18;
  final TextStyle bold20;
  final TextStyle bold23;
  final TextStyle bold12;
  final TextStyle semiBold14;
  final TextStyle semiBold12;
  final TextStyle regular16;
  final TextStyle regular14;
  final TextStyle regular13;
  final TextStyle regular11;
  final TextStyle regular12;

  const AppTextStyleTheme()
      : bold14 = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        bold16 = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        bold18 = const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        bold20 = const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        bold23 = const TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w700,
        ),
        bold12 = const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        semiBold14 = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        semiBold12 = const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        regular16 = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        regular14 = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        regular13 = const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.normal,
        ),
        regular11 = const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.normal,
        ),
        regular12 = const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        );

  const AppTextStyleTheme._({
    required this.bold14,
    required this.bold16,
    required this.bold18,
    required this.bold20,
    required this.bold23,
    required this.bold12,
    required this.semiBold14,
    required this.semiBold12,
    required this.regular16,
    required this.regular14,
    required this.regular13,
    required this.regular11,
    required this.regular12,
  });

  @override
  AppTextStyleTheme copyWith({
    TextStyle? bold14,
    TextStyle? bold16,
    TextStyle? bold18,
    TextStyle? bold20,
    TextStyle? bold23,
    TextStyle? bold12,
    TextStyle? semiBold14,
    TextStyle? semiBold12,
    TextStyle? regular16,
    TextStyle? regular14,
    TextStyle? regular13,
    TextStyle? regular11,
    TextStyle? regular12,
  }) {
    return AppTextStyleTheme._(
      bold14: bold14 ?? this.bold14,
      bold16: bold16 ?? this.bold16,
      bold18: bold18 ?? this.bold18,
      bold20: bold20 ?? this.bold20,
      bold23: bold23 ?? this.bold23,
      bold12: bold12 ?? this.bold12,
      semiBold14: semiBold14 ?? this.semiBold14,
      semiBold12: semiBold12 ?? this.semiBold12,
      regular16: regular16 ?? this.regular16,
      regular14: regular14 ?? this.regular14,
      regular13: regular13 ?? this.regular13,
      regular11: regular11 ?? this.regular11,
      regular12: regular12 ?? this.regular12,
    );
  }

  @override
  ThemeExtension<AppTextStyleTheme> lerp(
    covariant ThemeExtension<AppTextStyleTheme>? other,
    double t,
  ) {
    if (other is! AppTextStyleTheme) {
      return this;
    }
    return AppTextStyleTheme._(
      bold14: TextStyle.lerp(bold14, other.bold14, t)!,
      bold16: TextStyle.lerp(bold16, other.bold16, t)!,
      bold18: TextStyle.lerp(bold18, other.bold18, t)!,
      bold20: TextStyle.lerp(bold20, other.bold20, t)!,
      bold23: TextStyle.lerp(bold23, other.bold23, t)!,
      bold12: TextStyle.lerp(bold12, other.bold12, t)!,
      semiBold14: TextStyle.lerp(semiBold14, other.semiBold14, t)!,
      semiBold12: TextStyle.lerp(semiBold12, other.semiBold12, t)!,
      regular16: TextStyle.lerp(regular16, other.regular16, t)!,
      regular14: TextStyle.lerp(regular14, other.regular14, t)!,
      regular13: TextStyle.lerp(regular13, other.regular13, t)!,
      regular11: TextStyle.lerp(regular11, other.regular11, t)!,
      regular12: TextStyle.lerp(regular12, other.regular12, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTextStyleTheme &&
          runtimeType == other.runtimeType &&
          bold14 == other.bold14 &&
          bold16 == other.bold16 &&
          bold18 == other.bold18 &&
          bold20 == other.bold20 &&
          bold23 == other.bold23 &&
          bold12 == other.bold12 &&
          semiBold14 == other.semiBold14 &&
          semiBold12 == other.semiBold12 &&
          regular16 == other.regular16 &&
          regular14 == other.regular14 &&
          regular13 == other.regular13 &&
          regular11 == other.regular11 &&
          regular12 == other.regular12;

  @override
  int get hashCode => Object.hash(
        runtimeType,
        bold14,
        bold16,
        bold18,
        bold20,
        bold23,
        bold12,
        semiBold14,
        semiBold12,
        regular16,
        regular14,
        regular13,
        regular11,
        regular12,
      );
}
