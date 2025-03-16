import 'package:get/get.dart';
import '../../main.dart';
import '../enums/async_status.dart';
import '../errors/failures.dart';

extension AsyncOperations on GetxController {
  Future<void> handleCustomResultAsync<T>({
    void Function(AsyncStatus)? setStatus,
    required CustomResultAsync<T> Function() task,
    required void Function(T) onSuccess,
    void Function(Failure)? onError,
    List<Object>? updateIds,
  }) async {
    setStatus?.call(AsyncStatus.loading);
    update(updateIds);

    final result = await task();

    result.fold(
      (failure) {
        setStatus?.call(AsyncStatus.failure);
        onError?.call(failure);
      },
      (data) {
        onSuccess(data);
        setStatus?.call(AsyncStatus.success);
      },
    );

    update(updateIds);
  }

  Future<void> handleCustomResult<T>({
    required void Function(AsyncStatus) setStatus,
    required CustomResult<T> Function() task,
    required void Function(T) onSuccess,
    void Function(Failure)? onError,
    List<Object>? updateIds,
  }) async {
    setStatus(AsyncStatus.loading);
    update(updateIds);

    final result = task();

    result.fold(
      (failure) {
        setStatus(AsyncStatus.failure);
        onError?.call(failure);
      },
      (data) {
        onSuccess(data);
        setStatus(AsyncStatus.success);
      },
    );

    update(updateIds);
  }
}
