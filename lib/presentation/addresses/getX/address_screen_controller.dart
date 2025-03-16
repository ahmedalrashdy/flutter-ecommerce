import 'package:get/get.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/data/models/address_model.dart';
import 'package:super_ecommerce/data/repositories/address_repository.dart';

import '../../../core/dialogs/app_message.dart';

class AddressScreenController extends GetxController {
  List<AddressModel> addresses = [];
  final AddressRepository addressRepository = Get.find();
  AsyncStatus status = AsyncStatus.idle;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllAddresses();
  }

  Future<void> deleteAddress(int addressId) async {
    AddressModel address =
        addresses.firstWhere((address) => address.id == addressId);
    addresses.remove(address);
    update();
    final result = await addressRepository.deleteAddress(address.id!);
    result.fold((failure) {
      AppMessage.showError(message: failure.message);
    }, (_) {
      AppMessage.showInfo(message: "تم حذف العنوان بنجاح");
    });
    update();
  }

  Future<void> getAllAddresses() async {
    status = AsyncStatus.loading;
    update();
    await Future.delayed(Duration(seconds: 1));
    final result = await addressRepository.getAllAddresses();
    result.fold((failure) {
      AppMessage.showError(message: failure.message);
      status = AsyncStatus.failure;
    }, (result) {
      addresses = result;
      status = AsyncStatus.success;
    });
    update();
  }
}
