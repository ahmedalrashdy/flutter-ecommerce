import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/auth_response.dart';
import '../../data/repository/auth_repository.dart';
import '../screens/login_screen.dart';

class AuthController extends GetxController {
  final AuthRepository repository;

  AuthController({required this.repository});

  final _isLoading = false.obs;
  final _user = Rxn<UserData>();
  final _error = Rxn<String>();

  bool get isLoading => _isLoading.value;
  UserData? get user => _user.value;
  String? get error => _error.value;

  Future<void> forgotPassword(String email) async {
    try {
      _isLoading.value = true;
      update();

      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'تم بنجاح',
        'تم إرسال رمز التحقق إلى بريدك الإلكتروني',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(8),
      );

      // Get.to(() => VerifyOtpScreen(email: email));
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء إرسال رمز التحقق',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(8),
      );
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    try {
      _isLoading.value = true;
      update();

      // TODO: Implement API call to verify OTP
      await Future.delayed(const Duration(seconds: 2)); // Simulating API call

      Get.snackbar(
        'تم بنجاح',
        'تم التحقق من الرمز بنجاح',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(8),
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'الرمز غير صحيح',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(8),
      );
      return false;
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  Future<void> resendOtp(String email) async {
    try {
      _isLoading.value = true;
      update();

      // TODO: Implement API call to resend OTP
      await Future.delayed(const Duration(seconds: 2)); // Simulating API call

      Get.snackbar(
        'تم بنجاح',
        'تم إعادة إرسال رمز التحقق',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(8),
      );
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء إعادة إرسال الرمز',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(8),
      );
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  Future<void> resetPassword(
      String email, String otp, String newPassword) async {
    try {
      _isLoading.value = true;
      update();

      // TODO: Implement API call to reset password
      await Future.delayed(const Duration(seconds: 2)); // Simulating API call

      Get.snackbar(
        'تم بنجاح',
        'تم تغيير كلمة المرور بنجاح',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(8),
      );

      Get.offAll(() => const LoginScreen());
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء تغيير كلمة المرور',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(8),
      );
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  void logout() {
    // _repository.logout();
    _user.value = null;
  }
}
