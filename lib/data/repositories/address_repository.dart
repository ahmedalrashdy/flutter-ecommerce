import 'package:dartz/dartz.dart';
import 'package:super_ecommerce/core/constants/api_endpoints.dart';
import 'package:super_ecommerce/core/errors/exception_handler.dart';
import 'package:super_ecommerce/core/services/api_service.dart';
import 'package:super_ecommerce/data/models/address_model.dart';
import '../../main.dart';

abstract class AddressRepository with ExceptionHandler {
  CustomResultAsync<Unit> addAddress(AddressModel address);
  CustomResultAsync<Unit> deleteAddress(int addressId);
  CustomResultAsync<List<AddressModel>> getAllAddresses();
}

class AddressRepositoryImpWithHttp extends AddressRepository {
  ApiService apiService;
  AddressRepositoryImpWithHttp({required this.apiService});
  @override
  CustomResultAsync<Unit> addAddress(AddressModel address) async {
    return await handleExceptionAsync<Unit>(() async {
      await apiService.post(ApiEndpoint.addAddress, body: address.toMap());
      return const Right(unit);
    });
  }

  @override
  CustomResultAsync<Unit> deleteAddress(int addressId) async {
    return await handleExceptionAsync<Unit>(() async {
      await apiService.delete(ApiEndpoint.deleteAddress(addressId));
      return const Right(unit);
    });
  }

  @override
  CustomResultAsync<List<AddressModel>> getAllAddresses() async {
    return await handleExceptionAsync<List<AddressModel>>(() async {
      List<dynamic> data = await apiService.get(ApiEndpoint.allAddresses);
      return Right(AddressModel.fromListMap(data));
    });
  }
}
