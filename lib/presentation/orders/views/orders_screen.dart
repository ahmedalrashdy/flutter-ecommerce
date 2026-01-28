import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/core/widgets/basic/tab_content.dart';
import 'package:super_ecommerce/presentation/orders/getX/orders_controller.dart';
import 'package:super_ecommerce/presentation/orders/widgets/order_list.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/order_app_bar.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    OrdersController controller = Get.put(OrdersController());
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: OrderAppBar(
        tabController: _tabController,
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TabContent(child: OrderList(type: "active")),
          TabContent(child: OrderList(type: "completed")),
          TabContent(child: OrderList(type: "cancelled")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSortDialog(context);
        },
        backgroundColor: context.colors.primary,
        child: const Icon(Icons.sort),
      ),
    );
  }
}
