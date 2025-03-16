import 'package:flutter/material.dart';
import 'package:super_ecommerce/core/constants/app_text_style.dart';
import 'package:super_ecommerce/core/theme/app_theme.dart';

class CategoryNavBar extends StatefulWidget {
  CategoryNavBar({super.key, required this.tabController});
  TabController tabController;
  @override
  State<CategoryNavBar> createState() => _CategoryNavBarState();
}

class _CategoryNavBarState extends State<CategoryNavBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildIconButton(icon: Icons.all_inbox, name: "الكل", index: 0),
              const SizedBox(width: 12),
              _buildIconButton(
                  icon: Icons.trending_up, name: "الأكثر مبيعًا", index: 1),
              const SizedBox(width: 12),
              _buildIconButton(
                  icon: Icons.hotel_class_sharp,
                  name: "الأعلى تقييمًا",
                  index: 2),
              const SizedBox(width: 12),
              _buildIconButton(
                  icon: Icons.golf_course_outlined, name: "الاحدث", index: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required String name,
    required IconData icon,
    required int index,
  }) {
    bool isActive = selectedIndex == index; // Determine active state

    return FilledButton.icon(
      onPressed: () {
        setState(() {
          widget.tabController.animateTo(index);
          selectedIndex = index;
        });
      },
      icon: Icon(icon, size: 18),
      label: Text(name,
          style: AppTextStyle.bold12.copyWith(
              color: isActive ? Colors.white : AppTheme.primaryTextColor)),
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) =>
              isActive ? Colors.white : AppTheme.primaryTextColor,
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) =>
              isActive ? AppTheme.primaryColor : Colors.white,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        elevation: WidgetStateProperty.all(isActive ? 2 : 0),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
    );
  }
}
