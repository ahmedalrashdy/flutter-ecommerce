import 'package:flutter/material.dart';
import 'package:super_ecommerce/core/theme/app_theme.dart';

abstract class AppTextStyle {
  static TextStyle bold14 = TextStyle(
      color: AppTheme.primaryTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w700);
  static TextStyle bold16 = TextStyle(
      color: AppTheme.primaryTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w700);
  static TextStyle bold18 = TextStyle(
      color: AppTheme.primaryTextColor,
      fontSize: 18,
      fontWeight: FontWeight.w700);
  static TextStyle bold20 = TextStyle(
      color: AppTheme.primaryTextColor,
      fontSize: 20,
      fontWeight: FontWeight.w700);
  static TextStyle bold23 = TextStyle(
      color: AppTheme.primaryTextColor,
      fontSize: 23,
      fontWeight: FontWeight.w700);
  static TextStyle bold12 = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: AppTheme.primaryTextColor);
  static TextStyle semiBold14 = TextStyle(
      color: AppTheme.primaryTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w500);
  static TextStyle semiBold12 = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppTheme.primaryTextColor);
  static TextStyle regular16 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppTheme.primaryTextColor);
  static TextStyle regular14 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppTheme.primaryTextColor);
  static TextStyle regular13 = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.normal,
      color: AppTheme.primaryTextColor);
  static TextStyle regular11 = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.normal,
      color: AppTheme.primaryTextColor);
  static TextStyle regular12 = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppTheme.primaryTextColor);
}
