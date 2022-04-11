import 'package:emdad/modules/vendor_module/screens/vender_add_product_view/vendor_edit_product_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorAddNewProductScreen extends StatefulWidget {
  const VendorAddNewProductScreen({Key? key}) : super(key: key);

  @override
  State<VendorAddNewProductScreen> createState() =>
      _VendorAddNewProductScreenState();
}

class _VendorAddNewProductScreenState extends State<VendorAddNewProductScreen> {
  final TextEditingController productName = TextEditingController();

  bool? isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
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
          text: 'إضافة منتج',
          textStyle: primaryTextStyle().copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(right: 16.w, top: 20.h, bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'الصوره الرئيسية',
                      textStyle: thirdTextStyle()
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 161.h,
                          width: 142.w,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.grey.shade100,
                          ),
                          child: Image.network(
                            'https://tse1.mm.bing.net/th?id=OIP.L3uZEm5nXG-UtEGXNL8tFQHaFj&pid=Api&P=0&w=244&h=183',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    CustomText(
                      text: 'صور اخري',
                      textStyle: thirdTextStyle()
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 100.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          height: 100.h,
                          width: 90.w,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.grey.shade100,
                          ),
                          child: Image.network(
                            'https://tse1.mm.bing.net/th?id=OIP.L3uZEm5nXG-UtEGXNL8tFQHaFj&pid=Api&P=0&w=244&h=183',
                            fit: BoxFit.cover,
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10.w),
                        itemCount: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.h, horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'اسم المنتج',
                        textStyle: secondaryTextStyle()
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      CustomText(
                        text: 'دجاج',
                        textStyle: secondaryTextStyle()
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                      SizedBox(height: 20.h),
                      CustomText(
                        text: 'تفاصيل المنتج',
                        textStyle: secondaryTextStyle()
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      CustomText(
                        text:
                        'هذا المنتج من افضل المنتجات الموجده وجميع المنتجات من خير مزارعنا',
                        textAlign: TextAlign.start,
                        textStyle: thirdTextStyle()
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                      CustomText(
                        text: 'تفاصيل السعر',
                        textStyle: secondaryTextStyle()
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            width: 2,
                            color: AppColors.textButtonColor,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                shape: BoxShape.rectangle,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  CustomText(
                                    text: 'وحدة القياس',
                                    textStyle: subTextStyle().copyWith(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  CustomText(
                                    text: 'الحد الادني',
                                    textStyle: subTextStyle().copyWith(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  CustomText(
                                    text: 'سعر الوحدة',
                                    textStyle: subTextStyle().copyWith(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  CustomText(
                                    text: 'الضريبة',
                                    textStyle: subTextStyle().copyWith(
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h),
                            ListView.separated(
                              itemBuilder: (context, index) => buildPriceDetailsItem(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 20.h),
                              itemCount: 3,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                      ListTile(
                        trailing: Checkbox(
                          value: isSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              isSelected = value!;
                            });

                            print(isSelected);
                          },
                          activeColor: Colors.green,
                        ),
                        leading: CustomText(
                          text: 'اظهار السعر',
                          textStyle: thirdTextStyle()
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                      Align(
                        child: CustomButton(
                          width: 176.w,
                          height: 60.h,
                          backgroundColor: AppColors.primaryColor,
                          onPressed: () {},
                          text: 'إضافة',
                          radius: 10.r,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPriceDetailsItem(){
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 60.w,
          decoration: const BoxDecoration(
            color: AppColors.textButtonColor,
          ),
          child: CustomText(
            text: 'طن',
            textStyle: subTextStyle().copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          width: 60.w,
          decoration: const BoxDecoration(
              color: AppColors.textButtonColor),
          child: CustomText(
            text: '٤',
            textStyle: subTextStyle().copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          width: 60.w,
          decoration: const BoxDecoration(
              color: AppColors.textButtonColor),
          child: CustomText(
            text: '٤٠٠',
            textStyle: subTextStyle().copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 60.w,
          child: CustomText(
            text: '١٥٪',
            textStyle: subTextStyle().copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }


}
