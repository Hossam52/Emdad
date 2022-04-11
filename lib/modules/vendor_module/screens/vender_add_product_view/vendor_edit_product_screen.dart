import 'dart:io';

import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/models/general_models/product_detailes.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VendorEditProductScreen extends StatefulWidget {
  const VendorEditProductScreen({Key? key}) : super(key: key);

  @override
  State<VendorEditProductScreen> createState() =>
      _VendorEditProductScreenState();
}

class _VendorEditProductScreenState extends State<VendorEditProductScreen> {
  TextEditingController productName = TextEditingController();
  TextEditingController productDetails = TextEditingController();

  @override
  void initState() {
    super.initState();
    productName.text = 'دجاج';
    productDetails.text =
        'هذا المنتج من افضل المنتجات الموجده وجميع المنتجات من خير مزارعنا';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VendorCubit, VendorState>(
      listener: (context, state) {},
      builder: (context, state) {
        var vendorCubit = VendorCubit.get(context);
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
              text: 'تعديل منتج',
              textStyle: primaryTextStyle().copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: SizedBox(
            height: 900,
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: 16.w, top: 20.h, bottom: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: 'الصوره الرئيسية',
                        textStyle: thirdTextStyle()
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 161.h,
                            width: 142.w,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.grey.shade100,
                              image: DecorationImage(
                                image: vendorCubit.productImage == null
                                    ? const NetworkImage(
                                        'https://tse1.mm.bing.net/th?id=OIP.L3uZEm5nXG-UtEGXNL8tFQHaFj&pid=Api&P=0&w=244&h=183',
                                      )
                                    : FileImage(vendorCubit.productImage!)
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: 35.h,
                            width: 35.w,
                            margin: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColors.primaryColor,
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  vendorCubit.getProductImage();
                                },
                                icon: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                  size: 20.r,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'صور اخري',
                            textStyle: thirdTextStyle()
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          Container(
                            height: 35.h,
                            width: 35.w,
                            margin: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColors.primaryColor,
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  vendorCubit.getProductOtherImages();
                                },
                                icon: Icon(
                                  Icons.library_add_outlined,
                                  color: Colors.white,
                                  size: 20.r,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      vendorCubit.productOtherImages!.isNotEmpty
                          ? SizedBox(
                              height: 100.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    buildOtherPhotosListItem(
                                  vendorCubit,
                                  index,
                                ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 10.w),
                                itemCount:
                                    vendorCubit.productOtherImages!.length,
                              ),
                            )
                          : Flexible(
                              child: SvgPicture.asset(
                                  'assets/images/questions_amico.svg'),
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
                        SizedBox(height: 5.h),
                        buildTextFormField(
                          controller: productName,
                          onChanged: (String? value) {},
                          onSubmitted: (String? value) {},
                        ),
                        SizedBox(height: 20.h),
                        CustomText(
                          text: 'تفاصيل المنتج',
                          textStyle: secondaryTextStyle()
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 5.h),
                        buildTextFormField(
                          controller: productDetails,
                          onChanged: (String? value) {},
                          onSubmitted: (String? value) {},
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'تفاصيل السعر',
                              textStyle: secondaryTextStyle()
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            InkWell(
                              onTap: () {
                                showModalSheet();
                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(20.r),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 35.r,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                              SizedBox(height: 10.h),
                              SizedBox(
                                height: 100.h,
                                child: ListView.separated(
                                  itemBuilder: (context, index) => Dismissible(
                                    key: ValueKey<ProductDetailsModel>(
                                        vendorCubit.products[index]),
                                    confirmDismiss: (direction) {
                                      return showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text("حذف سعر"),
                                          content: const Text("هل أنت متأكد"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                vendorCubit
                                                    .deletePriceDetails(index);
                                                Navigator.of(ctx).pop(true);
                                              },
                                              child: Text(
                                                "نعم",
                                                style:
                                                    thirdTextStyle().copyWith(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.red),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop(false);
                                              },
                                              child: Text(
                                                "لا",
                                                style:
                                                    thirdTextStyle().copyWith(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.green),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    background: Container(color: Colors.red),
                                    child: buildPriceDetailsItem(),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 20.h),
                                  itemCount: vendorCubit.products.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.h),
                        ListTile(
                          trailing: Checkbox(
                            value: vendorCubit.isSelected,
                            onChanged: (bool? value) {
                              vendorCubit.changeCheckBoxState(value!);
                              print(vendorCubit.isSelected);
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
                            text: 'حفظ',
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
        );
      },
    );
  }

  showModalSheet() {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return buildModalSheetItem();
      },
    );
  }

  Widget buildOtherPhotosListItem(VendorCubit vendorCubit, int index) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          height: 100.h,
          width: 90.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.grey.shade100,
            image: DecorationImage(
              image: vendorCubit.productOtherImages!.isEmpty
                  ? const NetworkImage(
                      'https://tse1.mm.bing.net/th?id=OIP.L3uZEm5nXG-UtEGXNL8tFQHaFj&pid=Api&P=0&w=244&h=183',
                    )
                  : FileImage(File(vendorCubit.productOtherImages![index].path))
                      as ImageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: 35.h,
          width: 35.w,
          margin: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.primaryColor,
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                vendorCubit.removeProductOtherImages(index);
              },
              icon: Icon(
                Icons.clear,
                color: Colors.white,
                size: 20.r,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPriceDetailsItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          decoration: const BoxDecoration(color: AppColors.textButtonColor),
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
          decoration: const BoxDecoration(color: AppColors.textButtonColor),
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

  Widget buildModalSheetItem() {
    return SizedBox(
      height: 450.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ListTile(
              leading: CustomText(
                text: 'وحدة القياس',
                textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
              ),
              trailing: SizedBox(
                width: 200.w,
                child: buildTextFormField(
                  controller: null,
                  onChanged: (String? value) {},
                  onSubmitted: (String? value) {},
                ),
              ),
              title: SizedBox(width: 20.w),
            ),
            SizedBox(height: 20.h),
            ListTile(
              leading: CustomText(
                text: 'الحد الادني',
                textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
              ),
              trailing: SizedBox(
                width: 200.w,
                child: buildTextFormField(
                  controller: null,
                  onChanged: (String? value) {},
                  onSubmitted: (String? value) {},
                ),
              ),
              title: SizedBox(width: 20.w),
            ),
            SizedBox(height: 30.h),
            ListTile(
              leading: CustomText(
                text: 'سعر الوحدة',
                textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
              ),
              trailing: SizedBox(
                width: 200.w,
                child: buildTextFormField(
                  controller: null,
                  onChanged: (String? value) {},
                  onSubmitted: (String? value) {},
                ),
              ),
              title: SizedBox(width: 20.w),
            ),
            SizedBox(height: 20.h),
            ListTile(
              leading: CustomText(
                text: 'الضريبة',
                textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
              ),
              trailing: SizedBox(
                width: 200.w,
                child: buildTextFormField(
                  controller: null,
                  onChanged: (String? value) {},
                  onSubmitted: (String? value) {},
                ),
              ),
              title: SizedBox(width: 20.w),
            ),
            SizedBox(height: 30.h),
            Align(
              child: CustomButton(
                width: 176.w,
                height: 60.h,
                backgroundColor: AppColors.primaryColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'حفظ',
                radius: 4.r,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required TextEditingController? controller,
    required Function(String)? onChanged,
    required Function(String)? onSubmitted,
  }) {
    return SizedBox(
      height: 50.h,
      child: TextFormField(
        cursorColor: Colors.grey,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: const BorderSide(
              color: AppColors.textButtonColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: const BorderSide(
              color: AppColors.textButtonColor,
            ),
          ),
        ),
        style: thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
      ),
    );
  }
}
