import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/modules/vendor_module/price_details_table.dart';
import 'package:emdad/modules/vendor_module/screens/vender_add_product_view/widgets/all_product_images.dart';
import 'package:emdad/modules/vendor_module/screens/vender_add_product_view/widgets/main_product_image.dart';
import 'package:emdad/modules/vendor_module/screens/vender_add_product_view/widgets/product_details_widget.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/vendor_product_crud_cubit/vendor_product_crud_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:emdad/shared/widgets/dialogs/add_new_price.dart';
import 'package:emdad/shared/widgets/dialogs/confirm_exit_product_edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VendorEditProductScreen extends StatefulWidget {
  const VendorEditProductScreen({Key? key, required this.product})
      : super(key: key);
  final ProductModel product;
  @override
  State<VendorEditProductScreen> createState() =>
      _VendorEditProductScreenState();
}

class _VendorEditProductScreenState extends State<VendorEditProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final res = await showDialog(
            context: context,
            builder: (_) => const ConfirmExitProductEditDialog());
        if (res != null && res == true) return true;
        return false;
      },
      child: BlocProvider(
        create: (context) => VendorProductCrudCubit(widget.product),
        child: VendorProductCrudCubitBlocBuilder(
          builder: (context, state) {
            return VendorBlocConsumer(
              listener: (context, state) {},
              builder: (context, state) {
                final productCubit = VendorProductCrudCubit.instance(context);
                return Scaffold(
                  backgroundColor: AppColors.scaffoldBackgroundColor,
                  appBar: _appBar(context),
                  body: ListView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: 16.w, top: 20.h, bottom: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const MainProductImage(),
                            SizedBox(height: 20.h),
                            const AllProductImages(),
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
                              ProductDetailsWidget(productCubit: productCubit),
                              Align(
                                child: CustomButton(
                                  width: 176.w,
                                  height: 60.h,
                                  backgroundColor: AppColors.primaryColor,
                                  onPressed: () {
                                    productCubit.editProduct();
                                  },
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
                );
              },
            );
          },
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15.r),
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      title: CustomText(
        text: 'تعديل منتج',
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
    );
  }
}
