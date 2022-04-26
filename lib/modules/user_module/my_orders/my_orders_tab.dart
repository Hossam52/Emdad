import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/modules/user_module/my_orders/my_orders_cubit/my_orders_cubit.dart';
import 'package:emdad/modules/user_module/my_orders/my_orders_cubit/my_orders_states.dart';
import 'package:emdad/modules/user_module/offers_module/offers_cubit/offers_cubit.dart';
import 'package:emdad/shared/widgets/empty_data.dart';
import 'package:emdad/shared/widgets/load_more_data.dart';
import 'package:flutter/material.dart';

import 'orders_build_item.dart';

class MyOrdersTab extends StatelessWidget {
  const MyOrdersTab({
    Key? key,
    required this.status,
    required this.onTap,
    required this.orders,
    this.visibleShowMore = false,
    this.isLoadMoreData = false,
  }) : super(key: key);

  final OrderStatus status;
  final void Function(String orderId) onTap;
  final List<SupplyRequest> orders;
  final bool visibleShowMore;
  final bool isLoadMoreData;
  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) return const EmptyData(emptyText: 'No orders found');
    return SingleChildScrollView(
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
            visible: !MyOrdersCubit.instance(context).isLastPage,
            isLoading: MyOrdersCubit.instance(context).state
                is GetMoreMyOrdersLoadingState,
            onLoadingMore: () {
              MyOrdersCubit.instance(context).getMoreMyOrders();
            },
          ),
        ],
      ),
    );

    CustomScrollView(
      primary: true,
      slivers: [
        SliverToBoxAdapter(
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: orders.length * 2,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) => OrderBuildItem(
              order: orders[index % orders.length],
              hasBadge: false,
              onTap: () => onTap(
                orders[index % orders.length].id,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: LoadMoreData(
            visible: !MyOrdersCubit.instance(context).isLastPage,
            isLoading: MyOrdersCubit.instance(context).state
                is GetMoreMyOrdersLoadingState,
            onLoadingMore: () {
              MyOrdersCubit.instance(context).getMoreMyOrders();
            },
          ),
        ),
      ],
    );
  }
}
