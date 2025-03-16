import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:super_ecommerce/core/constants/app_assets.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';

class RequestWidget extends StatelessWidget {
  RequestWidget(
      {super.key,
      required this.status,
      this.loading,
      this.centerLoading = false,
      this.centerFailure = false,
      required this.success,
      this.failure});
  final Widget? loading;
  final Widget success;
  final Widget? failure;
  final bool centerLoading;
  final bool centerFailure;
  AsyncStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case AsyncStatus.loading:
        {
          return centerLoading
              ? Center(child: _buildLoading())
              : _buildLoading();
        }
      case AsyncStatus.success:
        return success;
      case AsyncStatus.failure:
        {
          if (failure != null) {
            return centerFailure ? Center(child: failure) : failure!;
          }
          return centerFailure
              ? Center(child: LottieBuilder.asset(AppAssets.lottie404error))
              : LottieBuilder.asset(AppAssets.lottie404error);
        }
      default:
        return centerLoading ? Center(child: _buildLoading()) : _buildLoading();
    }
  }

  Widget _buildLoading() {
    if (loading != null) {
      return loading!;
    }
    return LottieBuilder.asset(AppAssets.lottieLoading);
  }
}
