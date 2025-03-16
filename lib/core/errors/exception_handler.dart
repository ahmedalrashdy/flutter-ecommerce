import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'exceptions.dart';
import 'failures.dart';

mixin ExceptionHandler {
  final Logger logger = Get.find();
  Future<Either<Failure, T>> handleExceptionAsync<T>(
      Future<Either<Failure, T>> Function() action) async {
    try {
      return await action();
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(messages: e.messages));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on CustomException catch (e) {
      return Left(CustomFailure(message: e.message));
    } catch (e, stackTrace) {
      final className = runtimeType.toString();

      logger.e(
        "class:[$className] ,Unhandled Exception:[$e]",
        error: e,
        stackTrace: stackTrace,
      );
      return const Left(CustomFailure(message: "حطأ غير معروف"));
    }
  }

  Either<Failure, T> handleException<T>(Either<Failure, T> Function() action) {
    try {
      return action();
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(messages: e.messages));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on CustomException catch (e) {
      return Left(CustomFailure(message: e.message));
    } catch (e, stackTrace) {
      final className = runtimeType.toString();
      logger.e(
        "[$className][$e]",
        error: e,
        stackTrace: stackTrace,
      );
      return const Left(CustomFailure(message: "حطأ غير معروف"));
    }
  }
}
