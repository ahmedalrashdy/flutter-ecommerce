import 'package:flutter/material.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: context.colors.onPrimary,
        filled: true,
        prefixIcon: IconButton(
          icon: Icon(Icons.search_outlined,
              size: 20, color: context.colors.onSurfaceVariant),
          onPressed: () {},
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.camera_alt_outlined,
              size: 20, color: context.colors.onSurfaceVariant),
          onPressed: () {},
        ),
        hintText: 'البحث',
        hintStyle: TextStyle(color: context.colors.onSurfaceVariant),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }
}
