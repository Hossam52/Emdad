import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_cubit.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_states.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/new_order_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_user_preview.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_widget_wrapper.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/shipping_widget.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/total_order_price_widget.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/tracking_widget.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_offers_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/dialogs/request_transform_dialog.dart';
import 'package:emdad/shared/widgets/order_items_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      create: (_) => OrderCubit(orderId: widget.orderId)..getOrder(),
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
                        trailing: Text(
                          context.tr.preparing,
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
                            trailing: _TransportationActions(order: order),
                          );
                        },
                      ),
                      // AllOrdersListView(
                      //   vendorId: order.vendorId,
                      // ),
                      const SizedBox(height: 36),
                      OrderAdditionalItemsListView(order: order),
                      const SizedBox(height: 20),
                      ShippingWidget(order: order),
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

class _TransportationActions extends StatelessWidget {
  const _TransportationActions({Key? key, required this.order})
      : super(key: key);
  final SupplyRequest order;
  @override
  Widget build(BuildContext context) {
    if (order.isVendor) {
      return const SizedBox.shrink();
    }
    if (order.transportationRequest != null) {
      return CustomButton(
        onPressed: () async {
          navigateTo(
              context,
              ShippingOffersScreen(
                orderCubit: OrderCubit.instance(context),
                transportationRequestId: order.transportationRequestId,
              ));
        },
        width: 125.w,
        text: context.tr.delivery_offers,
      );
    }
    return CustomButton(
      onPressed: () async {
        final successRequest = await showRequestTransformMethod(context);
        if (successRequest != null && successRequest) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => OrderInPorgressScreen(
                  title: context.tr.in_porcess,
                  orderId: order.id,
                  status: OrderStatus.inProgress),
            ),
          );
        }
      },
      width: 125.w,
      text: context.tr.get_delivery_comapny,
    );
  }

  Future<bool?> showRequestTransformMethod(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: OrderCubit.instance(context),
        child: OrderBlocConsumer(listener: (context, state) {
          if (state is CreateTransportationRequestErrorState) {
            SharedMethods.showToast(context, state.error,
                color: AppColors.errorColor, textColor: Colors.white);
            Navigator.pop(context);
          }
          if (state is CreateTransportationRequestSuccessState) {
            Navigator.pop(context, true);
          }
        }, builder: (context, orderState) {
          return RequestTransformDialog(
            isLoading: orderState is CreateTransportationRequestLoadingState,
            onCreateTransportRequest: (
                {required String city, required String transportationMethod}) {
              OrderCubit.instance(context).createTransportationRequest(
                city: city,
                transportationMethod: transportationMethod,
              );
            },
          );
        }),
      ),
    );
  }
}
