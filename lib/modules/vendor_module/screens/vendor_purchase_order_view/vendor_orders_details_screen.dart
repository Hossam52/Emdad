import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/order_view/order_item_build.dart';
import 'package:emdad/modules/user_module/order_view/order_view_screen.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_componants/vendor_info_build_item.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorOrderDetailsScreen extends StatelessWidget {
  const VendorOrderDetailsScreen({
    Key? key,
    required this.title,
    this.isCompleted = false,
    this.hasShipping = false,
  }) : super(key: key);

  final bool hasShipping;
  final String title;
  final bool isCompleted;

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
      ),
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
            const ListTile(
              title:
                  Text('قائمة الطلبات', style: TextStyle(color: Colors.black)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 22, horizontal: 16),
            ),
            ListView.separated(
              itemCount: 3,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  if(isCompleted == false) {
                    showModalSheet(
                      context: context,
                      title: 'تحديد سعر المنتج',
                      isTransporter: false,
                      isOutList: false);
                  }
                },
                child: const OrderItemBuild(
                  columns: ['صنف', 'كمية', 'وحدة', 'سعر', 'ضريبة'],
                  rows: ['طماطم', '3', 'طن', '١٥٠٠ ر.س', '١٢٪'],
                ),
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
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  if(isCompleted == false) {
                    showModalSheet(
                      context: context,
                      title: 'تحديد سعر الطلب',
                      isTransporter: false,
                      isOutList: true);
                  }
                },
                child: const OrderItemBuild(
                  columns: ['الوصف', 'سعر', 'ضريبة'],
                  rows: ['٤ كرتونه كاتشب', '١٥٠٠ ر.س', '١٢٪'],
                  radius: 3,
                ),
              ),
            ),
            const SizedBox(height: 20),
            DefaultHomeTitleBuildItem(
              title: 'التوصيل',
              onPressed: () {},
              hasButton: false,
            ),
            InkWell(
              onTap: () {
                if(isCompleted == false) {
                  showModalSheet(
                    context: context,
                    title: 'تحديد سعر النقل',
                    isTransporter: true,
                    isOutList: false);
                }
              },
              child: Card(
                  elevation: 3,
                  color: Colors.grey[100],
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('تكلفة الطلب ',
                                style: subTextStyle()
                                    .copyWith(color: AppColors.primaryColor)),
                            const Spacer(),
                            Text('٩٠٩٠ ريال سعودي',
                                style: thirdTextStyle()
                                    .copyWith(fontWeight: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 10),
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
                      ],
                    ),
                  )),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('إجمالي',
                            style: subTextStyle()
                                .copyWith(color: AppColors.primaryColor)),
                        Text('الضريبة',
                            style: subTextStyle()
                                .copyWith(color: AppColors.primaryColor)),
                        SizedBox(height: 10.h),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('٩٠٩٠ ريال سعودي',
                            style: thirdTextStyle()
                                .copyWith(fontWeight: FontWeight.w700)),
                        SizedBox(height: 10.h),
                        Text('١٢٪',
                            style: subTextStyle()
                                .copyWith(fontWeight: FontWeight.w700)),
                      ],
                    ),
                    Container(
                      width: 103.w,
                      height: 63.h,
                      color: AppColors.textButtonColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('إجمالي',
                              style: subTextStyle().copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          SizedBox(height: 10.h),
                          Text('٩٠٩٠ ريال سعودي',
                              style:
                                  subTextStyle().copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                onPressed: () {
                  if(isCompleted) {
                    navigateTo(context, const OrderViewScreen(title: 'طلب عرض سعر', status: OrderStatus.inProgress));
                  } else {
                    showOrderConfirmationDialog(context);
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
      ),
    );
  }

}
