import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkService extends GetxService {
  Future<bool> get isConnected;
}

class NetworkServiceImplWithICCP extends NetworkService {
  final InternetConnection internetConnection;
  NetworkServiceImplWithICCP({required this.internetConnection});

  final RxBool _isConnected = false.obs;
  late StreamSubscription<InternetStatus> _subscription;

  @override
  Future<void> onInit() async {
    super.onInit();

    _subscription = internetConnection.onStatusChange.listen((status) {
      _isConnected.value = (status == InternetStatus.connected);
    });
  }

  @override
  Future<bool> get isConnected async {
    if (!_isConnected.value) {
      _isConnected.value = await internetConnection.hasInternetAccess;
    }
    return _isConnected.value;
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
