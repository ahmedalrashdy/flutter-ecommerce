import 'package:flutter/material.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';

class CustomMessage extends StatelessWidget {
  const CustomMessage({super.key, required this.icon, required this.title});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 80, color: context.colors.onSurface),
        const SizedBox(height: 20),
        Text(
          title,
          style: context.appTextTheme.bold18
              .copyWith(color: context.colors.onSurface),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
