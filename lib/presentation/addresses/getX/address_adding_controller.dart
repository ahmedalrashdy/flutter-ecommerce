import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/dialogs/app_message.dart';
import 'package:super_ecommerce/core/dialogs/custom_confirm_dialog.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/errors/exceptions.dart';
import 'package:super_ecommerce/data/models/address_model.dart';
import 'package:super_ecommerce/data/repositories/address_repository.dart';

class AddressAddingController extends GetxController {
  final AddressRepository addressRepository = Get.find();
  late final TextEditingController addressController;
  late final TextEditingController cityController;

  double? lng;
  double? lat;
  bool isDefault = false;
  AsyncStatus status = AsyncStatus.idle;

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  CameraPosition? cameraPosition;

  Set<Marker> markers = {};

  @override
  void onInit() {
    super.onInit();
    addressController = TextEditingController();
    cityController = TextEditingController();
    _fetchCurrentPosition();
  }

  @override
  void onClose() {
    addressController.dispose();
    cityController.dispose();
    super.onClose();
  }

  AsyncStatus addingStatus = AsyncStatus.idle;
  Future<void> addAddress() async {
    addingStatus = AsyncStatus.loading;
    update(["addingAddress"]);
    await Future.delayed(Duration(seconds: 1));
    final result = await addressRepository.addAddress(AddressModel(
        address: addressController.text,
        city: cityController.text,
        lang: lng!,
        lat: lat!,
        isDefault: isDefault));
    result.fold((failure) {
      AppMessage.showError(message: failure.message);
      addingStatus = AsyncStatus.failure;
    }, (_) {
      Get.back(result: true);
      AppMessage.showInfo(message: "تمت اضافة الموقع بنجاح");
      addingStatus = AsyncStatus.success;
    });
    update(["addingAddress"]);
  }

  bool isEnable = false;
  void checkEnable() {
    isEnable = addressController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        lng != null &&
        lat != null;
    update(["addingAddress"]);
  }

  void switchDefault(bool value) {
    isDefault = value;
    update();
  }

  void addMarker(LatLng position) {
    markers.clear();
    markers.add(Marker(
        markerId: MarkerId(position.toString()),
        infoWindow: InfoWindow(
          title: "موقعك",
        ),
        position: position));
    lng = position.longitude;
    lat = position.latitude;
    update();
  }

  Future<void> _fetchCurrentPosition() async {
    status = AsyncStatus.loading;
    update();
    try {
      final Position? currentPosition = await _getCurrentPosition();
      if (currentPosition != null) {
        checkEnable();
        cameraPosition = CameraPosition(
            target: LatLng(
              currentPosition.latitude,
              currentPosition.longitude,
            ),
            zoom: 14.47);
        status = AsyncStatus.success;
        addMarker(LatLng(currentPosition.latitude, currentPosition.longitude));
      } else {
        status = AsyncStatus.failure;
      }
    } catch (error, stackTrace) {
      status = AsyncStatus.failure;
      log('Error fetching current position: $error', stackTrace: stackTrace);
    }
    update();
  }

  Future<Position?> _getCurrentPosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      await _showLocationServiceDisabledDialog();
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (!_hasLocationPermission(permission)) {
      permission = await Geolocator.requestPermission();
      if (!_hasLocationPermission(permission)) {
        await _showLocationPermissionDeniedDialog();
        return null;
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  bool _hasLocationPermission(LocationPermission permission) {
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Future<void> _showLocationServiceDisabledDialog() async {
    await Get.dialog(
      CustomConfirmationDialog(
        title: "الموقع",
        content: "قم بتفعيل خدمة الموقع الالكتروني لنتمكن من الوصل الى موقعك",
        onConfirm: () => Get.back(),
        onCancel: () => Get.back(),
        confirmText: "فهمت",
        cancelText: "",
      ),
    );
  }

  Future<void> _showLocationPermissionDeniedDialog() async {
    await Get.dialog(
      CustomConfirmationDialog(
        title: "صلاحية الوصول",
        content:
            "لم يتمكن التطبيق من الحصول على خدمة الموقع. الرجاء قم بتمكين التطبيق من إعدادات النظام.",
        onConfirm: () => Get.back(),
        onCancel: () => Get.back(),
        confirmText: "فهمت",
        cancelText: "",
      ),
    );
  }
}
