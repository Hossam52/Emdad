import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';

import 'my_orders_tab.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.primaryColor,
                width: 0.5,
              ),
            ),
          ),
          child: const TabBar(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            isScrollable: true,
            labelColor: AppColors.primaryColor,
            indicatorColor: AppColors.primaryColor,
            tabs: [
              Tab(text: 'منتظر النقل'),
              Tab(text: 'قيد التحميل'),
              Tab(text: 'قيد التوصيل'),
              Tab(text: 'عمليات ناجحة'),
            ],
          ),
        ),
        const Expanded(
          child: TabBarView(
            children: [
              MyOrdersTab(status: OrderStatus.newOrder),
              MyOrdersTab(status: OrderStatus.inProgress),
              MyOrdersTab(status: OrderStatus.inProgress),
              MyOrdersTab(status: OrderStatus.completed),
            ],
          ),
        ),
      ],
    );
  }
}
