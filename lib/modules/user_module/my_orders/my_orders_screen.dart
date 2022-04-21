import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/new_order_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/order_completed_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/order_in_progress_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_view_screen.dart';
import 'package:emdad/shared/componants/components.dart';
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
        Expanded(
          child: TabBarView(
            children: [
              MyOrdersTab(
                status: OrderStatus.newOrder,
                onTap: (orderId) {
                  navigateTo(
                      context,
                      OrderNewScreen(
                        orderId: orderId,
                        title: 'طلب مكتمل',
                        status: OrderStatus.newOrder,
                      ));
                },
              ),
              MyOrdersTab(
                status: OrderStatus.inProgress,
                onTap: (orderId) {
                  navigateTo(
                      context,
                      OrderInPorgressScreen(
                        orderId: orderId,
                        title: 'طلب مكتمل',
                        status: OrderStatus.inProgress,
                      ));
                },
              ),
              MyOrdersTab(
                status: OrderStatus.inProgress,
                onTap: (orderId) {
                  navigateTo(
                      context,
                      OrderInPorgressScreen(
                        title: 'طلب مكتمل',
                        orderId: orderId,
                        status: OrderStatus.inProgress,
                      ));
                },
              ),
              MyOrdersTab(
                  status: OrderStatus.completed,
                  onTap: (orderId) {
                    navigateTo(
                        context,
                        OrderCompletedScreen(
                          orderId: orderId,
                          title: 'طلب مكتمل',
                          status: OrderStatus.completed,
                        ));
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
