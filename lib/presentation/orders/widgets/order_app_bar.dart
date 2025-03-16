import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/theme/app_theme.dart';

import 'order_summary.dart';

class OrderAppBar extends StatefulWidget implements PreferredSizeWidget {
  const OrderAppBar({super.key, required this.tabController});
  final TabController tabController;
  @override
  State<OrderAppBar> createState() => _OrderAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(180);
}

class _OrderAppBarState extends State<OrderAppBar>
    with SingleTickerProviderStateMixin {
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All Time';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppTheme.primaryColor,
      title: _showSearch
          ? TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search orders...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey[400]),
              ),
              onChanged: (value) {
                // Implement search functionality
              },
            )
          : const Text(
              'My Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20),
        onPressed: () => Get.back(),
      ),
      actions: [
        IconButton(
          icon: Icon(_showSearch ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              _showSearch = !_showSearch;
              if (!_showSearch) {
                _searchController.clear();
              }
            });
          },
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.filter_list),
          onSelected: (value) {
            setState(() {
              _selectedFilter = value;
            });
          },
          itemBuilder: (context) => [
            'All Time',
            'Last 30 Days',
            'Last 6 Months',
            'This Year',
          ].map((filter) {
            return PopupMenuItem(
              value: filter,
              child: Row(
                children: [
                  Icon(
                    _selectedFilter == filter
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(filter),
                ],
              ),
            );
          }).toList(),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Column(
          children: [
            TabBar(
              controller: widget.tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              indicatorColor: Colors.green,
              indicatorWeight: 4,
              dividerHeight: 0,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: 'Active'),
                Tab(text: 'Completed'),
                Tab(text: 'Cancelled'),
              ],
            ),
            OrderSummary(),
          ],
        ),
      ),
    );
  }
}
