import 'dart:developer';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_cubit.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_user_preview.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_widget_wrapper.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/shipping_widget.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/total_order_price_widget.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_offers_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/dialogs/request_transform_dialog.dart';
import 'package:emdad/shared/widgets/order_items_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderNewScreen extends StatelessWidget {
  const OrderNewScreen({
    Key? key,
    required this.title,
    required this.orderId,
    required this.status,
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
          child: Builder(builder: (context) {
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
                        trailing: transportationButton(context, order),
                      );
                    },
                  ),
                  // AllOrdersListView(
                  //   vendorId: order.vendorId,
                  //   trailing: transportationButton(context, order),
                  // ),
                  const SizedBox(height: 36),

                  OrderAdditionalItemsListView(order: order),
                  const SizedBox(height: 20),

                  // const ShippingCardBuildItem(
                  //   name: 'لا يوجد نقل',
                  //   info: 'لم يتم تأكيد طلب النقل . الرجاء تأكيد أمر النقل',
                  //   icon:
                  //       Icon(Icons.info_outlined, color: AppColors.thirdColor),
                  //   borderColor: AppColors.thirdColor,
                  // ),
                  ShippingWidget(
                    transportationRequest: order.transportationRequest,
                    transportationHandler: order.transportationHandlerEnum,
                  ),
                  const SizedBox(height: 20),
                  TotalOrderPrice(
                    order: order,
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget transportationButton(BuildContext context, SupplyRequest order) {
    if (order.transportationRequest != null) {
      if (order.transportationHandlerEnum == FacilityType.vendor) {
        return const SizedBox.shrink();
      }
      return CustomButton(
        onPressed: () async {
          navigateTo(context, const ShippingOffersScreen());
        },
        width: 125.w,
        text: 'عروض النقل',
      );
    }
    return CustomButton(
      onPressed: () async {
        final successRequest = await showRequestTransformMethod(context);
        if (successRequest != null && successRequest) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => OrderNewScreen(
                  title: title, orderId: orderId, status: status),
            ),
          );
        }
      },
      width: 125.w,
      text: 'طلب شركة نقل',
    );
  }

  Future<bool?> showRequestTransformMethod(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: OrderCubit.instance(context),
        child: const RequestTransformDialog(),
      ),
    );
  }
}
