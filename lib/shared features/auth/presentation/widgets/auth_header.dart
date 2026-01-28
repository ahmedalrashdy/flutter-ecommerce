import 'package:flutter/material.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String description;
  final String assetPath;
  final String heroTag;

  const AuthHeader({
    Key? key,
    required this.title,
    required this.description,
    required this.assetPath,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: heroTag,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: context.colors.primary.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 20,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Image.asset(
              assetPath,
              height: 80,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              context.colors.primary,
              context.colors.secondary,
            ],
          ).createShader(bounds),
          child: Text(
            title,
            style: context.textStyleTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: context.textStyleTheme.bodyLarge?.copyWith(
            color: context.colors.onSurface,
          ),
        ),
      ],
    );
  }
}
