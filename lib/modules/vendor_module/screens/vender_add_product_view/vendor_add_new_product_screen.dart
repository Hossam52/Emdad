import 'package:emdad/modules/vendor_module/price_details_table.dart';
import 'package:emdad/modules/vendor_module/screens/vender_add_product_view/vendor_edit_product_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:emdad/shared/widgets/dialogs/add_new_price.dart';
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
        actions: const [
          ChangeLangWidget(
            color: Colors.white,
          )
        ],
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
                padding: EdgeInsets.only(right: 16.w, top: 20.h, bottom: 20.h),
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
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'اسم المنتج',
                        textStyle: secondaryTextStyle()
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      CustomTextFormField(
                        validation: (val) {},
                        hint: 'اسم المنتج',
                        hasBorder: true,
                        contentPadding: const EdgeInsets.all(4),
                        borderRadius: 15,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'تفاصيل السعر',
                            textStyle: secondaryTextStyle()
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          GestureDetector(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.r),
                                      topRight: Radius.circular(30.r),
                                    ),
                                  ),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddNewPriceDialog(
                                      onSave: (
                                          {required minimumAmount,
                                          required pricePerUnit,
                                          required productUnit}) {},
                                    );
                                  },
                                );
                              },
                              child:
                                  const CircleAvatar(child: Icon(Icons.add))),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      const PriceDetailsTable(),
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
}
