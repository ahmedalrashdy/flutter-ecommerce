import 'package:flutter/material.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.title,
    this.isLoading = false,
  });
  final void Function()? onPressed;
  final bool isLoading;
  final String title;
  @override
  Widget build(BuildContext context) {
    Color secondary = isLoading || onPressed == null
        ? context.colors.onSurfaceVariant
        : context.colors.onPrimary;
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
          backgroundColor: context.colors.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(secondary),
                ),
              ),
            if (isLoading) const SizedBox(width: 10),
            Text(
              title,
              style: context.appTextTheme.bold16.copyWith(color: secondary),
            )
          ],
        ),
      ),
    );
  }
}
