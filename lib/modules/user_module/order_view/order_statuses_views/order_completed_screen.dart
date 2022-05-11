import 'dart:developer';

import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_cubit.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_user_preview.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_widget_wrapper.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/shipping_widget.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/total_order_price_widget.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/tracking_widget.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/order_items_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCompletedScreen extends StatelessWidget {
  const OrderCompletedScreen({
    Key? key,
    required this.title,
    required this.status,
    required this.orderId,
  }) : super(key: key);

  final OrderStatus status;
  final String orderId;
  final String title;

  @override
  Widget build(BuildContext context) {
    log(status.toString());
    return BlocProvider(
      create: (context) => OrderCubit(orderId: orderId)..getOrder(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, style: const TextStyle(color: Colors.white)),
          backgroundColor: AppColors.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
          actions: const [
            ChangeLangWidget(
              color: Colors.white,
            )
          ],
        ),
        body: OrderWidgetWrapper(
          child: Builder(
            builder: (context) {
              final order = OrderCubit.instance(context).order;
              return TrackingWidget(
                order: order,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      OrderUserPreview(
                        order: order,
                        displayedUser: order.vendor,
                      ),
                      OrderBlocBuilder(
                        builder: (context, state) {
                          final order = OrderCubit.instance(context).order;
                          final items = order.requestItems;
                          return OrderItemsListView(
                            items: items,
                            displayTotalAfterTaxes: true,
                          );
                        },
                      ),
                      // AllOrdersListView(
                      //   vendorId: order.vendorId,
                      // ),
                      const SizedBox(height: 36),
                      OrderAdditionalItemsListView(order: order),
                      const SizedBox(height: 20),
                      ShippingWidget(
                        order: order,
                      ),
                      const SizedBox(height: 20),
                      TotalOrderPrice(
                        order: order,
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
