import 'dart:developer';

import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/cart_module/cart_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/new_order_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/order_completed_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/order_in_progress_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/order_offer_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_total_row_item.dart';
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

import 'order_item_build.dart';

class OrderViewScreen extends StatelessWidget {
  const OrderViewScreen({
    Key? key,
    required this.title,
    required this.status,
  }) : super(key: key);

  final OrderStatus status;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (status == OrderStatus.completed) {
      return OrderCompletedScreen(title: title, status: status);
    }
    if (status == OrderStatus.offer) {
      return OrderOfferScreen(title: title, status: status);
    }
    if (status == OrderStatus.inProgress) {
      return OrderInPorgressScreen(title: title, status: status);
    } else {
      return OrderNewScreen(title: title, status: status);
    }

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: status == OrderStatus.inProgress
          ? FloatingActionButton.extended(
              onPressed: () {
                navigateTo(context, const OrderTrackingScreen());
              },
              label: const Text('متابعة العملية'),
              icon: const Icon(MyIcons.track_order),
              backgroundColor: AppColors.primaryColor,
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            VendorInfoBuildItem(
              isCart: true,
              tailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(MyIcons.add_drive, color: Colors.white),
                  ),
                  const SizedBox(width: 13),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(MyIcons.truck_thin,
                        color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('قائمة الطلبات',
                  style: TextStyle(color: Colors.black)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
              trailing: status == OrderStatus.inProgress
                  ? null
                  : CustomIconButton(
                      width: 45.w,
                      height: 45.h,
                      icon: const Icon(MyIcons.edit, color: Colors.white),
                      buttonColor: AppColors.secondaryColor,
                      onPressed: () {
                        navigateTo(context,
                            CartScreen(title: 'الهدي للتوريدات الغذائيه'));
                      },
                    ),
            ),
            ListView.separated(
              itemCount: 3,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) => const OrderItemBuild(
                columns: ['صنف', 'كمية', 'وحدة', 'سعر', 'ضريبة'],
                rows: ['طماطم', '3', 'طن', '١٥٠٠ ر.س', '١٢٪'],
              ),
            ),
            const SizedBox(height: 36),
            DefaultHomeTitleBuildItem(
              title: 'طلب خارج قائمة المنتجات',
              onPressed: () {},
              hasButton: false,
            ),
            ListView.separated(
              itemCount: 2,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) => const OrderItemBuild(
                columns: ['الوصف', 'سعر', 'ضريبة'],
                rows: ['٤ كرتونه كاتشب', '١٥٠٠ ر.س', '١٢٪'],
                radius: 3,
              ),
            ),
            const SizedBox(height: 20),
            DefaultHomeTitleBuildItem(
              title: 'النقل',
              onPressed: () {},
              hasButton: false,
            ),
            if (status == OrderStatus.inProgress ||
                status == OrderStatus.completed ||
                status == OrderStatus.offer)
              const ShippingCardBuildItem(
                name: 'عربه نصف نقل',
                info: 'المدة المتوقعة: 12 ساعة',
                icon: Icon(MyIcons.truck_thin, color: AppColors.primaryColor),
                price: 1150,
              )
            else
              const ShippingCardBuildItem(
                name: 'لا يوجد نقل',
                info: 'لم يتم تأكيد طلب النقل . الرجاء تأكيد أمر النقل',
                icon: Icon(Icons.info_outlined, color: AppColors.thirdColor),
                borderColor: AppColors.thirdColor,
              ),
            const SizedBox(height: 20),
            DefaultHomeTitleBuildItem(
              title: 'إجمالي',
              onPressed: () {},
              hasButton: false,
            ),
            Card(
                elevation: 3,
                color: Colors.grey[100],
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const OrderTotalRowItem(title: 'الضريبة', value: '١٢٪'),
                      Row(
                        children: [
                          Text('الضريبة',
                              style: subTextStyle()
                                  .copyWith(color: AppColors.primaryColor)),
                          const Spacer(),
                          Text('١٢٪',
                              style: subTextStyle()
                                  .copyWith(fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (status == OrderStatus.inProgress ||
                          status == OrderStatus.completed ||
                          status == OrderStatus.offer)
                        Row(
                          children: [
                            Text('الشحن',
                                style: subTextStyle()
                                    .copyWith(color: AppColors.primaryColor)),
                            const Spacer(),
                            Text('1150 ر.س',
                                style: subTextStyle()
                                    .copyWith(fontWeight: FontWeight.w700)),
                          ],
                        ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text('إجمالي',
                              style: subTextStyle()
                                  .copyWith(color: AppColors.primaryColor)),
                          const Spacer(),
                          Text('٩٠٩٠ ريال سعودي',
                              style: thirdTextStyle()
                                  .copyWith(fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 10),
            if (status == OrderStatus.completed ||
                status == OrderStatus.newOrder ||
                status == OrderStatus.offer)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  onPressed: () {
                    if (status == OrderStatus.newOrder) {
                      showOrderConfirmationDialog(context);
                    }
                  },
                  text: status == OrderStatus.completed
                      ? 'إعاده ارسال طلب عرض سعر'
                      : 'إرسال طلب أمر شراء',
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
