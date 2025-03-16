import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: IconButton(
          icon: Icon(Icons.search_outlined,
              size: 20, color: AppTheme.greyTextColor),
          onPressed: () {},
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.camera_alt_outlined,
              size: 20, color: AppTheme.greyTextColor),
          onPressed: () {},
        ),
        hintText: 'البحث',
        hintStyle: TextStyle(color: AppTheme.greyTextColor),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }
}
