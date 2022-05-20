import 'dart:developer';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/my_orders/my_orders_cubit/my_orders_cubit.dart';
import 'package:emdad/modules/user_module/my_orders/my_orders_cubit/my_orders_states.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/new_order_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/order_completed_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/order_in_progress_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_view_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/guest_checker_widget.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'my_orders_tab.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GuestCheckerWidget(
      child: Column(
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
            child: TabBar(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                onTap: (int val) {
                  MyOrdersCubit.instance(context).changeSelectedTabIndex = val;
                },
                isScrollable: true,
                labelColor: AppColors.primaryColor,
                indicatorColor: AppColors.primaryColor,
                tabs: MyOrdersCubit.instance(context)
                    .details
                    .map((e) => Tab(
                          text: e.title,
                        ))
                    .toList()),
          ),
          Expanded(
            child: MyOrdersBlocBuilder(
              builder: (context, state) {
                final myOrdersCubit = MyOrdersCubit.instance(context);
                if (state is GetMyOrdersLoadingState) {
                  return const DefaultLoader();
                }
                if (state is GetMyOrdersErrorState) {
                  return NoDataWidget(
                      onPressed: () {
                        myOrdersCubit.orderTab.getOrders();
                      },
                      text: 'Error ${state.error}');
                }
                return TabBarView(
                  children: [
                    MyOrdersTab(
                      onTap: (orderId) {
                        navigateTo(
                            context,
                            OrderNewScreen(
                              orderId: orderId,
                              title: 'منتظر النقل',
                              status: OrderStatus.newOrder,
                            ));
                      },
                    ),
                    MyOrdersTab(
                      onTap: (orderId) {
                        navigateTo(
                            context,
                            OrderInPorgressScreen(
                              orderId: orderId,
                              title: 'قيد التحميل',
                              status: OrderStatus.inProgress,
                            ));
                      },
                    ),
                    MyOrdersTab(
                      onTap: (orderId) {
                        navigateTo(
                            context,
                            OrderInPorgressScreen(
                              title: 'قيد التوصيل',
                              orderId: orderId,
                              status: OrderStatus.inProgress,
                            ));
                      },
                    ),
                    MyOrdersTab(onTap: (orderId) {
                      navigateTo(
                          context,
                          OrderCompletedScreen(
                            orderId: orderId,
                            title: 'طلب مكتمل',
                            status: OrderStatus.completed,
                          ));
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
