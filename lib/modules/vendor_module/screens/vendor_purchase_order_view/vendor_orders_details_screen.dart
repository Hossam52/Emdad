import 'dart:developer';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/models/supply_request/order_transportation_request.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/modules/user_module/order_view/order_item_build.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/order_in_progress_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_total_overview_price.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_total_row_item.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_user_preview.dart';
import 'package:emdad/modules/user_module/order_view/order_view_screen.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_componants/vendor_info_build_item.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/vendor_order_cubit/vendor_order_cubit.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/vendor_order_cubit/vendor_order_states.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/widgets/vendor_delivery_widget.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/widgets/vendor_total_price.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/dialogs/edit_price_dialogs.dart';
import 'package:emdad/shared/widgets/order_items_list_view.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<T?> _showEditPriceDialog<T>(
    {required BuildContext context, required Widget widget}) async {
  return await showModalBottomSheet<T?>(
      context: context, isScrollControlled: true, builder: (_) => widget);
}

class VendorOrderDetailsScreen extends StatelessWidget {
  const VendorOrderDetailsScreen({
    Key? key,
    required this.title,
    required this.orderId,
    this.isCompleted = false,
    this.hasShipping = false,
  }) : super(key: key);

  final bool hasShipping;
  final String title;
  final bool isCompleted;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: BlocProvider(
        create: (context) => VendorOrderCubit(orderId)..getOrder(),
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
                    onItemPress: (item) async {
                      if (isCompleted == false) {
                        final price = await _showEditPriceDialog<double?>(
                            context: context,
                            widget: EditItemPriceDialog(item: item));
                        if (price != null) {
                          vendorOrderCubit.editItemPrice(
                              requestId: item.id!, price: price);
                        }
                        log(price.toString());
                      }
                    },
                  ),
                  const SizedBox(height: 36),
                  OrderAdditionalItemsListView(
                    order: order,
                    onItemTap: (item) async {
                      if (isCompleted == false) {
                        final price = await _showEditPriceDialog<double?>(
                          context: context,
                          widget: EditAdditionalItemPriceDialog(item: item),
                        );
                        if (price != null) {
                          vendorOrderCubit.editAdditionalItemPrice(
                              additionalItemId: item.id, price: price);
                        }
                        log(price.toString());
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  VendorDeliveryWidget(
                    order: order,
                    onEditPrice: () async {
                      if (isCompleted == false) {
                        final price = await _showEditPriceDialog<double?>(
                          context: context,
                          widget: EditShippingPriceDialog(
                            minPrice: order.transportationRequest
                                    ?.transportationOffer?.price ??
                                0,
                          ),
                        );
                        if (price != null) {
                          VendorOrderCubit.instance(context)
                              .editShippingPrice(price: price);
                        }
                        // log(price.toString());
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  VendorTotalPrice(order: order),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: state is QuoteOrderLoadingState
                        ? const DefaultLoader()
                        : CustomButton(
                            onPressed: () {
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
                              if (isCompleted) {
                                navigateTo(
                                    context,
                                    const OrderInPorgressScreen(
                                        orderId: 'orderId', //Modify it
                                        title: 'طلب عرض سعر',
                                        status: OrderStatus.inProgress));
                              } else {
                                if (order.transportationHandlerEnum ==
                                    FacilityType.user) {
                                } else {
                                  showOrderConfirmationDialog(context);
                                }
                              }
                            },
                            text: isCompleted ? 'بدأ التوصيل' : 'إرسال عرض سعر',
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
