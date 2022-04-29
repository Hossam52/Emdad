import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_cubit.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_user_preview.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_widget_wrapper.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/shipping_widget.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/total_order_price_widget.dart';
import 'package:emdad/modules/user_module/order_view/order_tracking/order_tracking_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/order_items_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderInPorgressScreen extends StatefulWidget {
  const OrderInPorgressScreen({
    Key? key,
    required this.title,
    required this.orderId,
    required this.status,
  }) : super(key: key);

  final OrderStatus status;
  final String title;
  final String orderId;

  @override
  State<OrderInPorgressScreen> createState() => _OrderInPorgressScreenState();
}

class _OrderInPorgressScreenState extends State<OrderInPorgressScreen> {
  bool hasRequestedTransport = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(orderId: widget.orderId)..getOrder(),
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(widget.title, style: const TextStyle(color: Colors.white)),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigateTo(context, const OrderTrackingScreen());
          },
          label: const Text('متابعة العملية'),
          icon: const Icon(MyIcons.track_order),
          backgroundColor: AppColors.primaryColor,
        ),
        body: OrderWidgetWrapper(
          child: Builder(
            builder: (context) {
              final order = OrderCubit.instance(context).order;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    OrderUserPreview(
                      order: order,
                      displayedUser: order.vendor,
                      trailing: Text(
                        'قيد التجهيز',
                        style: subTextStyle().copyWith(color: Colors.white),
                      ),
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
                        transportationHandler: order.transportationHandlerEnum,
                        transportationRequest: order.transportationRequest),
                    const SizedBox(height: 20),
                    TotalOrderPrice(
                      order: order,
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
