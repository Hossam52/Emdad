import 'dart:developer';

import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/cart_module/cart_screen.dart';
import 'package:emdad/modules/user_module/checkout/checkout_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_cubit.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_states.dart';
import 'package:emdad/modules/user_module/order_view/order_item_build.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/order_in_progress_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/all_orders_list_view.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_out_of_products.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_total_overview_price.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_total_row_item.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_vendor_info.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_widget_wrapper.dart';
import 'package:emdad/modules/user_module/order_view/order_tracking/order_tracking_screen.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_card_build_item.dart';
import 'package:emdad/modules/user_module/vendors_module/product_details/product_cubit.dart/product_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_componants/vendor_info_build_item.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_icon_button.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          child: Builder(
            builder: (context) {
              final order = OrderCubit.instance(context).order;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    OrderVendorInfo(
                      vendor: order.vendor,
                    ),
                    const AllOrdersListView(),
                    const SizedBox(height: 36),
                    const OrderOutOfProducts(),
                    const SizedBox(height: 20),
                    DefaultHomeTitleBuildItem(
                      title: 'النقل',
                      onPressed: () {},
                      hasButton: false,
                    ),
                    const ShippingCardBuildItem(
                      name: 'عربه نصف نقل',
                      info: 'المدة المتوقعة: 12 ساعة',
                      icon: Icon(MyIcons.truck_thin,
                          color: AppColors.primaryColor),
                      price: 1150,
                    ),
                    const SizedBox(height: 20),
                    DefaultHomeTitleBuildItem(
                      title: 'إجمالي',
                      onPressed: () {},
                      hasButton: false,
                    ),
                    OrderTotalOverviewPrice(children: [
                      const OrderTotalRowItem(title: 'الضريبة', value: '١٢٪'),
                      const SizedBox(height: 10),
                      OrderTotalRowItem(
                          title: 'السعر الصافي',
                          value: order.totalOrderPrice.toInt().toString()),
                      const SizedBox(height: 10),
                      const OrderTotalRowItem(
                          title: 'الشحن', value: '1150 ر.س'),
                      const SizedBox(height: 10),
                      const Divider(),
                      OrderTotalRowItem(
                          title: 'إجمالي',
                          value: (order.totalOrderPrice +
                                  order.totalOrderPrice * 0.12)
                              .toString()),
                    ]),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomButton(
                        onPressed: () async {
                          final acceptOrder =
                              await showOrderConfirmationDialog(context);

                          if (acceptOrder != null && acceptOrder) {
                            await navigateTo(
                              context,
                              CheckoutScreen(
                                onConfirmPressed: () {
                                  Navigator.pop(context);

                                  navigateTo(
                                    context,
                                    OrderInPorgressScreen(
                                        orderId: orderId,
                                        title: title,
                                        status: status),
                                  );
                                },
                              ),
                            );
                          }
                        },
                        text: 'إرسال طلب أمر شراء',
                        width: MediaQuery.of(context).size.width * 0.6,
                        radius: 10,
                      ),
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
