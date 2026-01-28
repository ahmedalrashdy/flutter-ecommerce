import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';

class ResetPasswordHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  const ResetPasswordHeader(
      {super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            Icons.lock_reset_rounded,
            size: 64,
            color: context.colors.primary,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          title,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: context.colors.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          subTitle,
          style: TextStyle(fontSize: 16, color: context.colors.onSurface),
        )
      ],
    );
  }
}
