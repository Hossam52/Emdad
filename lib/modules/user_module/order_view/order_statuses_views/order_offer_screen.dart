import 'dart:developer';

import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/cart_module/cart_screen.dart';
import 'package:emdad/modules/user_module/checkout/checkout_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_item_build.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/order_in_progress_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/all_orders_list_view.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_out_of_products.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_total_overview_price.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_total_row_item.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_vendor_info.dart';
import 'package:emdad/modules/user_module/order_view/order_tracking/order_tracking_screen.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_card_build_item.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_componants/vendor_info_build_item.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_icon_button.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderOfferScreen extends StatelessWidget {
  const OrderOfferScreen({
    Key? key,
    required this.title,
    required this.status,
  }) : super(key: key);

  final OrderStatus status;
  final String title;

  @override
  Widget build(BuildContext context) {
    log(status.toString());
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OrderVendorInfo(),
            ListTile(
              title: const Text('قائمة الطلبات',
                  style: TextStyle(color: Colors.black)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
              trailing: CustomIconButton(
                width: 45.w,
                height: 45.h,
                icon: const Icon(MyIcons.edit, color: Colors.white),
                buttonColor: AppColors.secondaryColor,
                onPressed: () {
                  navigateTo(
                      context, CartScreen(title: 'الهدي للتوريدات الغذائيه'));
                },
              ),
            ),
            const AllOrdersListView(),
            const SizedBox(height: 36),
            DefaultHomeTitleBuildItem(
              title: 'طلب خارج قائمة المنتجات',
              onPressed: () {},
              hasButton: false,
            ),
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
              icon: Icon(MyIcons.truck_thin, color: AppColors.primaryColor),
              price: 1150,
            ),
            const SizedBox(height: 20),
            DefaultHomeTitleBuildItem(
              title: 'إجمالي',
              onPressed: () {},
              hasButton: false,
            ),
            const OrderTotalOverviewPrice(children: [
              OrderTotalRowItem(title: 'الضريبة', value: '١٢٪'),
              SizedBox(height: 10),
              OrderTotalRowItem(title: 'الشحن', value: '1150 ر.س'),
              SizedBox(height: 10),
              OrderTotalRowItem(title: 'إجمالي', value: '٩٠٩٠ ريال سعودي'),
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
                            OrderInPorgressScreen(title: title, status: status),
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
      ),
    );
  }
}
