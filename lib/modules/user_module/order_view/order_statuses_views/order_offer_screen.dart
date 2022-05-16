import 'dart:developer';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/checkout/checkout_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_cubit.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_states.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/edit_order_widget.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_user_preview.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_widget_wrapper.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/shipping_widget.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/total_order_price_widget.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/order_items_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderOfferScreen extends StatelessWidget {
  const OrderOfferScreen({
    Key? key,
    required this.title,
    required this.orderId,
    required this.status,
  }) : super(key: key);

  final OrderStatus status;
  final String title;
  final String orderId;

  @override
  Widget build(BuildContext context) {
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
          child: BlocListener<OrderCubit, OrderStates>(
            listener: (context, state) async {
              if (state is AcceptSupplyOfferSuccessState) {
                Navigator.pop(context, true);
              }
            },
            child: Builder(
              builder: (context) {
                final order = OrderCubit.instance(context).order;

                return SingleChildScrollView(
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
                            trailing: !order.userCanSendPurchaseOrder
                                ? null
                                : EditOrderItemsWidget(
                                    order: order,
                                  ),
                          );
                        },
                      ),
                      // AllOrdersListView(
                      //     vendorId: order.vendorId,
                      //     trailing: EditOrderItemsWidget(
                      //       order: order,
                      //     )),
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
                      const SizedBox(height: 10),
                      OrderBlocBuilder(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: state is AcceptSupplyOfferLoadingState
                                ? const CircularProgressIndicator()
                                : CustomButton(
                                    onPressed: () async {
                                      if (!order.userCanSendPurchaseOrder) {
                                        SharedMethods.showToast(context,
                                            'Vendor not provide price offer yet',
                                            color: AppColors.errorColor,
                                            textColor: Colors.white);
                                        return;
                                      }
                                      if (order.isUser) {
                                        final hasMyOwnTransport =
                                            await showOrderConfirmationDialog(
                                                context);
                                        log(hasMyOwnTransport.toString());

                                        final successPay = await pay(context);

                                        if (successPay != null && successPay) {
                                          acceptSupplyRequest(context);
                                          log('Success');
                                        } else {
                                          SharedMethods.showToast(context,
                                              'لم تتم عملية الدفع بنجاح برجاء المحاولة مجددا',
                                              textColor: Colors.white,
                                              color: AppColors.errorColor);
                                        }
                                      } else {
                                        acceptSupplyRequest(context);
                                      }
                                    },
                                    text: 'إرسال طلب أمر شراء',
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    radius: 10,
                                  ),
                          );
                        },
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> pay(BuildContext context) async {
    final paymentSuccess = await navigateTo<bool?>(
      context,
      CheckoutScreen(
        onConfirmPressed: () {
          // navigateTo(
          //   context,
          //   OrderInPorgressScreen(
          //       orderId: orderId, title: title, status: status),
          // );
        },
      ),
    );
    log(paymentSuccess.toString());
    return paymentSuccess;
  }

  void acceptSupplyRequest(BuildContext context) async {
    await OrderCubit.instance(context).acceptSupplyOffer();
  }
}
