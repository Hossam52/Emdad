import 'package:emdad/layout/transporter_layout/transporter_layout.dart';
import 'package:emdad/modules/user_module/order_view/order_item_build.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TransporterOfferDetailsScreen extends StatefulWidget {
  TransporterOfferDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TransporterOfferDetailsScreen> createState() =>
      _TransporterOfferDetailsScreenState();
}

class _TransporterOfferDetailsScreenState
    extends State<TransporterOfferDetailsScreen> {
  String dropDownValue = 'عربة نصف نقل';

  var items = [
    'عربة نصف نقل',
    'عربة نقل',
    'شاحنة كبيرة',
  ];

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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset('assets/images/shipping_fast.svg'),
                Column(
                  children: [
                    const CustomListTile(
                      imageUrl:
                          'https://image.freepik.com/free-photo/medium-shot-happy-man-smiling_23-2148221808.jpg',
                      title: 'الهدي لتوريدات الغذائية',
                      subTitle: 'العنوان بالتفصيل',
                    ),
                    SizedBox(height: 30.h),
                    const CustomListTile(
                      imageUrl:
                          'https://tse1.mm.bing.net/th?id=OIP.L3uZEm5nXG-UtEGXNL8tFQHaFj&pid=Api&P=0&w=244&h=183',
                      title: 'مطعم كنتاكي',
                      subTitle: 'العنوان بالتفصيل',
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40.h),
            Align(
              child: CustomText(
                text: 'قائمة الطلبات',
                textStyle: thirdTextStyle(),
              ),
            ),
            SizedBox(height: 20.h),

            /// put list view here //

            ListView.separated(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) => const OrderItemBuild(
                columns: ['صنف', 'كمية', 'وحدة'],
                rows: ['طماطم', '3', 'طن'],
                hasTotal: false,
              ),
            ),

            SizedBox(height: 20.h),
            CustomText(
              text: 'ملاحظات',
              textStyle: thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
            ),
            Card(
              elevation: 5,
              shape: const RoundedRectangleBorder(),
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: 91.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: CustomText(
                  text: 'يفضل نص نقل شيفروليه ٤*٤',
                  textAlign: TextAlign.start,
                  textStyle:
                      thirdTextStyle().copyWith(fontWeight: FontWeight.normal),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                CustomText(
                  text: 'وسيلة النقل',
                  textStyle:
                      thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 20.w),
                Card(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    height: 40.h,
                    child: DropdownButton(
                      underline: const Text(''),
                      style: subTextStyle().copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                      value: dropDownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Card(
              elevation: 5,
              shape: const RoundedRectangleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  showModalSheet(
                      context: context,
                      title: 'تحديد سعر الطلب',
                      isTransporter: false,
                      isOutList: true);
                },
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
            ),
            SizedBox(height: 20.h),
            CustomButton(
              width: 308.w,
              height: 57.h,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => SuccessSendingOffer(onPressed: () {
                          navigateToAndFinish(
                              context, const TransporterLayout());
                        }));
              },
              text: 'إرسال عرض سعر توصيل',
              textStyle: thirdTextStyle()
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessSendingOffer extends StatelessWidget {
  const SuccessSendingOffer({Key? key, required this.onPressed})
      : super(key: key);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(
        text: 'تم إرسال العرض بنجاح',
        textStyle: thirdTextStyle().copyWith(fontWeight: FontWeight.w500),
      ),
      content: CircleAvatar(
        radius: 40.r,
        backgroundColor: const Color(0xff39AA2D),
        child: const Icon(Icons.check, color: Colors.white),
      ),
      actions: <Widget>[
        CustomButton(
          width: 215.w,
          text: 'إغلاق',
          backgroundColor: Colors.red,
          textStyle: thirdTextStyle()
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          onPressed: () {
            Navigator.of(context).pop(true);
            onPressed();
          },
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            CircleAvatar(
              minRadius: 35.r,
              maxRadius: 37.r,
              backgroundImage: NetworkImage(
                imageUrl,
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  textStyle: thirdTextStyle()
                      .copyWith(color: AppColors.primaryColor, fontSize: 12.sp),
                ),
                CustomText(
                  text: subTitle,
                  textStyle:
                      subTextStyle().copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
        Container(
          height: 42.h,
          width: 42.w,
          margin: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.textButtonColor,
          ),
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit_location_outlined,
                color: Colors.white,
                size: 20.r,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
