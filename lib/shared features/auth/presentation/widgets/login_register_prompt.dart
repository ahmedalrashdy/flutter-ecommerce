import 'package:flutter/material.dart';

import '../../../../core/constants/app_text_style.dart';

class LoginRegisterPrompt extends StatelessWidget {
  final String promptText;
  final String actionText;
  final VoidCallback onActionPressed;

  const LoginRegisterPrompt({
    Key? key,
    this.promptText = 'ليس لديك حساب؟',
    this.actionText = 'سجل الآن',
    required this.onActionPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            promptText,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          TextButton(
            onPressed: onActionPressed,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            child: Text(
              actionText,
              style: AppTextStyle.regular16.copyWith(
                decoration: TextDecoration.underline,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
