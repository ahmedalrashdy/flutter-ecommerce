import 'package:flutter/material.dart';
import 'package:super_ecommerce/core/constants/app_text_style.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField(
      {super.key,
      required this.controller,
      this.keyboardType = TextInputType.name,
      required this.label,
      this.icon,
      this.hasPasswordToggle = false,
      this.onTogglePassword,
      this.validator,
      this.obscureText = false,
      this.errorMessage,
      this.onChanged});
  void Function(String)? onChanged;
  TextEditingController controller;
  TextInputType? keyboardType;
  String label;
  bool obscureText;
  IconData? icon;
  bool hasPasswordToggle;
  void Function()? onTogglePassword;
  String? Function(String?)? validator;
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            error: errorMessage != null
                ? Text(
                    errorMessage!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.regular11.copyWith(color: Colors.red),
                  )
                : null,
            labelText: label,
            labelStyle:
                TextStyle(color: errorMessage == null ? Colors.green : null),
            prefixIcon: Icon(
              icon,
              color: errorMessage == null ? Colors.green : Colors.red,
              size: 22,
            ),
            suffixIcon: hasPasswordToggle
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                      size: 22,
                    ),
                    onPressed: onTogglePassword,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(15),
            ),
            focusColor: Colors.green,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          validator: validator,
        ));
  }
}
