import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/api_endpoints.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/functions/perform_async_operation.dart';
import 'package:super_ecommerce/core/services/api_service.dart';
import 'package:super_ecommerce/data/models/address_model.dart';
import 'package:super_ecommerce/data/repositories/address_repository.dart';
import 'package:super_ecommerce/presentation/cart/getX/cart_controller.dart';
import '../../../core/dialogs/app_message.dart';

class PaymentController extends GetxController {
  AddressRepository addressRepository = Get.find();
  ApiService apiService = Get.find();
  AsyncStatus status = AsyncStatus.idle;
  int? selectedAddressId;
  @override
  void onInit() {
    super.onInit();
    getAllAddresses();
  }

  void defaultAddress() {
    for (AddressModel address in addresses) {
      if (address.isDefault) {
        selectedAddressId = address.id;
      }
    }
  }

  List<AddressModel> addresses = [];
  Future<void> getAllAddresses() async {
    await handleCustomResultAsync(
        setStatus: (s) => status = s,
        task: () => addressRepository.getAllAddresses(),
        onSuccess: (result) => addresses = result,
        onError: (failure) => AppMessage.showError(message: failure.message));
  }

  void selectAddress(AddressModel address) {
    selectedAddressId = address.id;
    update();
  }

  void goToPayment() {
    Get.toNamed(AppRoute.paymentScreen);
  }

  AsyncStatus createPaymentStatus = AsyncStatus.idle;
  String? client_secret;

  Future<void> createPaymentIntent() async {
    createPaymentStatus = AsyncStatus.loading;
    update();
    CartController cartController = Get.find();
    List<int> cartItems = cartController.selectedItem.isNotEmpty
        ? cartController.selectedItem.toList()
        : cartController.cartList.map((cart) => cart.id).toList();

    try {
      final jsonResponse = await apiService.post(
          ApiEndpoint.createPaymentIntent,
          body: {"cart_items": cartItems, "address": selectedAddressId});
      createPaymentStatus = AsyncStatus.success;

      client_secret = jsonResponse['client_secret'] as String;
      await handlePayment();
      createPaymentStatus = AsyncStatus.success;
    } catch (error) {
      log(error.toString());
      createPaymentStatus = AsyncStatus.failure;
      AppMessage.showError(message: "حدث خطأ ما");
    } finally {
      update();
    }
  }

  Future<void> handlePayment() async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: client_secret!,
          style: ThemeMode.light,
          merchantDisplayName: "الراشدي",
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      AppMessage.showSuccess(message: "تمت عملية الشراء بنجاح");
      Get.offAllNamed(AppRoute.mainScreen);
    } catch (error) {
      print(error.toString());
      AppMessage.showError(message: "حدث خطأ ما الرجاء المحاولة لحقا");
    }
  }
}
