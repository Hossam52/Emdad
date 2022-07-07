import 'dart:developer';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/modules/user_module/checkout/checkout_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_user_preview.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/vendor_order_cubit/vendor_order_cubit.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/vendor_order_cubit/vendor_order_states.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/widgets/vendor_delivery_widget.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/widgets/vendor_total_price.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/dialogs/edit_price_dialogs.dart';
import 'package:emdad/shared/widgets/order_items_list_view.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VendorPurchaseOrderDetailsScreen extends StatelessWidget {
  const VendorPurchaseOrderDetailsScreen({Key? key, required this.orderId})
      : super(key: key);
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلب قيد التجهيز',
            style: TextStyle(color: Colors.white)),
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
      body: BlocProvider(
        create: (_) => VendorOrderCubit(orderId)..getOrder(),
        child: VendorOrderBlocConsumer(
          listener: (context, state) {
            if (state is QuoteOrderErrorState) {
              SharedMethods.showToast(context, state.error,
                  textColor: Colors.white, color: AppColors.errorColor);
            }
            if (state is QuoteOrderSuccessState) {
              SharedMethods.showToast(context, 'تم ارسال عرض التسعير بنجاح',
                  textColor: Colors.white, color: AppColors.successColor);
              Navigator.pop(context, true);
            }
          },
          builder: (context, state) {
            final vendorOrderCubit = VendorOrderCubit.instance(context);
            if (state is GetVendorOrderLoadingState) {
              return const DefaultLoader();
            }
            if (state is GetVendorOrderErrorState) {
              return NoDataWidget(
                onPressed: () {
                  vendorOrderCubit.getOrder();
                },
                text: state.error,
              );
            }
            if (vendorOrderCubit.hasErrorOnOrder) {
              return NoDataWidget(onPressed: () {
                vendorOrderCubit.getOrder();
              });
            }
            final order = vendorOrderCubit.order;
            return SingleChildScrollView(
              child: Column(
                children: [
                  OrderUserPreview(
                    order: order,
                    displayedUser: order.user,
                  ),
                  OrderItemsListView(
                    items: order.requestItems,
                    displayTotalAfterTaxes: false,
                  ),
                  const SizedBox(height: 36),
                  OrderAdditionalItemsListView(
                    order: order,
                  ),
                  const SizedBox(height: 20),
                  VendorDeliveryWidget(
                    order: order,
                  ),
                  const SizedBox(height: 20),
                  VendorTotalPrice(order: order),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: state is QuoteOrderLoadingState
                        ? const DefaultLoader()
                        : CustomButton(
                            onPressed: () async {
                              if (order.isUser ||
                                  (order.vendorHasRequestTransportation &&
                                      order.hasAcceptedTransportationOffer)) {
                                if (order.isVendor) {
                                  //Vendor who will handle transport
                                  final res = await navigateTo(context,
                                      CheckoutScreen(onConfirmPressed: () {}));

                                  print(res.toString());
                                }
                                log(order.transportationHandler);
                                //Start delivery
                              } else {
                                if (order.transportationRequest == null) {
                                  //Vendor not request any transportation yet
                                  final hasMyTransportation =
                                      await showOrderConfirmationDialog(
                                          context);
                                } else {
                                  //Vendor has requested transportation
                                  if (order.transportationRequest!
                                          .transportationOffer ==
                                      null) {
                                    SharedMethods.showToast(context,
                                        'لم يتم قبول عرض التوصيل من قبل اي احد لهذا الطلب',
                                        textColor: Colors.white);
                                  }
                                }
                              }
                              return;
                              try {
                                if (vendorOrderCubit
                                    .addPriceToAllItemsAndShipping) {
                                  vendorOrderCubit.quoteOrder();
                                }
                              } catch (e) {
                                SharedMethods.showToast(context, e.toString(),
                                    textColor: Colors.white,
                                    color: AppColors.errorColor);
                              }
                              return;
                              // if (isCompleted) {
                              //   navigateTo(
                              //       context,
                              //       const OrderInPorgressScreen(
                              //           orderId: 'orderId', //Modify it
                              //           title: 'طلب عرض سعر',
                              //           status: OrderStatus.inProgress));
                              // } else {
                              //   if (order.transportationHandlerEnum ==
                              //       FacilityType.user) {
                              //   } else {
                              //     showOrderConfirmationDialog(context);
                              //   }
                              // }
                            },
                            text: 'بدأ التوصيل',
                            radius: 10,
                            backgroundColor: AppColors.secondaryColor,
                          ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
