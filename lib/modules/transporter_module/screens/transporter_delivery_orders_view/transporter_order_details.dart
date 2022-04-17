import 'package:emdad/modules/transporter_module/screens/transporter_delivery_orders_view/transport_process_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_item_build.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_buton_with_icon.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_transporter_order_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransporterOrderDetailsScreen extends StatefulWidget {
  const TransporterOrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TransporterOrderDetailsScreen> createState() =>
      _TransporterOfferDetailsScreenState();
}

class _TransporterOfferDetailsScreenState
    extends State<TransporterOrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15.r),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: CustomText(
          text: 'تتفاصيل الطلب',
          textStyle: primaryTextStyle().copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: const [ChangeLangWidget(color: Colors.white)],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const CustomTransporterOrderListTile(
                    clientImageUrl:
                        'https://image.freepik.com/free-photo/medium-shot-happy-man-smiling_23-2148221808.jpg',
                    clientName: 'محمد احمد',
                    clientCompanyName: 'زاد',
                    address: 'العنوان',
                  ),
                  SizedBox(height: 30.h),
                  const CustomTransporterOrderListTile(
                    clientImageUrl:
                        'https://image.freepik.com/free-photo/medium-shot-happy-man-smiling_23-2148221808.jpg',
                    clientName: 'محمد احمد',
                    clientCompanyName: 'زاد',
                    address: 'العنوان',
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              CustomText(
                text: 'قائمة الطلبات',
                textStyle: thirdTextStyle(),
              ),
              SizedBox(height: 20.h),

              /// put list view here //

              ListView.separated(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemBuilder: (context, index) => const OrderItemBuild(
                  columns: ['صنف', 'كمية', 'وحدة'],
                  rows: ['طماطم', '3', 'طن'],
                  hasTotal: false,
                ),
              ),

              SizedBox(height: 20.h),
              Row(
                children: [
                  CustomText(
                    text: 'نوع النقل:',
                    textStyle:
                        thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 10.w),
                  CustomText(
                    text: 'سيارة نصف نقل',
                    textAlign: TextAlign.start,
                    textStyle: thirdTextStyle()
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  CustomText(
                    text: 'ملاحظات:',
                    textStyle:
                        thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 10.w),
                  CustomText(
                    text: 'يفضل نص نقل شيفروليه ٤*٤',
                    textAlign: TextAlign.start,
                    textStyle: thirdTextStyle()
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  CustomText(
                    text: 'سعر النقل:',
                    textStyle:
                        thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 10.w),
                  CustomText(
                    text: '١٢٠٠ ر.س',
                    textStyle:
                        thirdTextStyle().copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Card(
                elevation: 5,
                shape: const RoundedRectangleBorder(),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  height: 63.h,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'تكلفة الطلب',
                                textAlign: TextAlign.start,
                                textStyle: subTextStyle()
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                              CustomText(
                                text: 'الضريبة',
                                textAlign: TextAlign.start,
                                textStyle: subTextStyle()
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: '٩٠٩٠ ريال سعودي',
                            textAlign: TextAlign.start,
                            textStyle: subTextStyle()
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          CustomText(
                            text: '١٢٪',
                            textAlign: TextAlign.start,
                            textStyle: subTextStyle()
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          width: 78.w,
                          color: AppColors.textButtonColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'إجمالي',
                                textAlign: TextAlign.start,
                                textStyle: subTextStyle()
                                    .copyWith(color: Colors.white),
                              ),
                              CustomText(
                                text: '٩٠٩٠ ريال سعودي',
                                textAlign: TextAlign.start,
                                textStyle: subTextStyle().copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Align(
                child: CustomButtonWithIcon(
                  width: 302.w,
                  height: 57.h,
                  onPressed: () {
                    navigateTo(context, const TransportProcessScreen());
                  },
                  text: 'بدأعملية التوصيل',
                  iconData: Icons.place,
                  textStyle: thirdTextStyle().copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
