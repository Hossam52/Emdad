import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/modules/user_module/my_orders/my_orders_cubit/my_orders_cubit.dart';
import 'package:emdad/modules/user_module/my_orders/my_orders_cubit/my_orders_states.dart';
import 'package:emdad/modules/user_module/offers_module/offers_cubit/offers_cubit.dart';
import 'package:emdad/shared/widgets/custom_refresh_widget.dart';
import 'package:emdad/shared/widgets/empty_data.dart';
import 'package:emdad/shared/widgets/load_more_data.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'orders_build_item.dart';

class MyOrdersTab extends StatelessWidget {
  const MyOrdersTab({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final void Function(String orderId) onTap;

  @override
  Widget build(BuildContext context) {
    final orderTab = MyOrdersCubit.instance(context).orderTab;
    final orders = orderTab.orders;
    if (orderTab.isOrderNotLoaded) {
      return NoDataWidget(onPressed: () {
        orderTab.getOrders();
      });
    }
    if (orders.isEmpty) return const EmptyData(emptyText: 'No orders found');
    return CustomRefreshWidget(
      onRefresh: () async {
        await orderTab.getOrders();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: orders.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) => OrderBuildItem(
                order: orders[index],
                hasBadge: false,
                onTap: () => onTap(
                  orders[index].id,
                ),
              ),
            ),
            LoadMoreData(
              visible: !orderTab.isLastPage,
              isLoading: MyOrdersCubit.instance(context).state
                  is GetMoreMyOrdersLoadingState,
              onLoadingMore: () {
                orderTab.getMoreOrders();
              },
            ),
          ],
        ),
      ),
    );
  }
}
