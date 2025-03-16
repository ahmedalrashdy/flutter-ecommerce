import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMessage {
  static void showSuccess({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showMessage(
      message: message,
      duration: duration,
      backgroundColor: Colors.green.shade800,
      icon: Icons.check_circle_outline,
    );
  }

  static void showError({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showMessage(
      message: message,
      duration: duration,
      backgroundColor: Colors.red.shade800,
      icon: Icons.error_outline,
    );
  }

  static void showWarning({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showMessage(
      message: message,
      duration: duration,
      backgroundColor: Colors.orange.shade800,
      icon: Icons.warning_amber_rounded,
    );
  }

  static void showInfo({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showMessage(
      message: message,
      duration: duration,
      backgroundColor: Colors.blue.shade800,
      icon: Icons.info_outline,
    );
  }

  static void _showMessage({
    required String message,
    required Duration duration,
    required Color backgroundColor,
    required IconData icon,
  }) async {
    Get.snackbar(
      '',
      '',
      titleText: const SizedBox.shrink(),
      messageText: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      borderRadius: 12,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      duration: duration,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutCirc,
      reverseAnimationCurve: Curves.easeInCirc,
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
