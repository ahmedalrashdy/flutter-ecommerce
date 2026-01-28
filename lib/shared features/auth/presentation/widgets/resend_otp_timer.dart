import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/widgets/custom_button.dart';

class ResendOtpTimer extends StatefulWidget {
  final VoidCallback onResend;
  final int cooldownSeconds;
  final AsyncStatus status;
  ResendOtpTimer(
      {super.key,
      required this.onResend,
      required this.status,
      required this.cooldownSeconds});

  @override
  State<ResendOtpTimer> createState() => _ResendOtpTimerState();
}

class _ResendOtpTimerState extends State<ResendOtpTimer> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.cooldownSeconds;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  void _handleResend() {
    if (_remainingSeconds > 0) return;

    // Reset timer and resend OTP
    setState(() => _remainingSeconds = widget.cooldownSeconds);
    _startTimer();
    widget.onResend();
  }

  String _formatTime() {
    int hours = _remainingSeconds ~/ 3600;
    final hoursStr = hours.toString().padLeft(2, '0');

    final minutes =
        ((_remainingSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    if (hours > 0) return '$hoursStr:$minutes:$seconds';

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final isActive = _remainingSeconds > 0;
    return CustomButton(
        onPressed: isActive ? null : _handleResend,
        isLoading: widget.status == AsyncStatus.loading,
        title: isActive
            ? 'إعادة الإرسال خلال ${_formatTime()}'
            : 'إعادة إرسال الرمز');
  }
}
