import 'package:emdad/modules/vendor_module/price_details_table.dart';
import 'package:emdad/modules/vendor_module/screens/vender_add_product_view/vendor_edit_product_screen.dart';
import 'package:emdad/modules/vendor_module/screens/vender_add_product_view/widgets/all_product_images.dart';
import 'package:emdad/modules/vendor_module/screens/vender_add_product_view/widgets/main_product_image.dart';
import 'package:emdad/modules/vendor_module/screens/vender_add_product_view/widgets/product_details_widget.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/products_cubit/vendor_product_cubit.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/vendor_product_crud_cubit/vendor_product_crud_cubit.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/vendor_product_crud_cubit/vendor_product_crud_states.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
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

class VendorAddNewProductScreen extends StatefulWidget {
  const VendorAddNewProductScreen({Key? key}) : super(key: key);

  @override
  State<VendorAddNewProductScreen> createState() =>
      _VendorAddNewProductScreenState();
}

class _VendorAddNewProductScreenState extends State<VendorAddNewProductScreen> {
  final formKey = GlobalKey<FormState>();
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
        create: (_) => VendorProductCrudCubit.newProduct(),
        child: VendorProductCrudCubitBlocConsumer(
          listener: (context, state) {
            if (state is AddProductErrorState) {
              SharedMethods.showToast(context, state.error,
                  textColor: Colors.white, color: AppColors.errorColor);
            }
            if (state is AddProductSuccessState) {
              SharedMethods.showToast(context, 'تم اضافة المنتج بنجاح',
                  textColor: Colors.white);
              VendorProductsCubit.instance(context).getAllVendorProducts();
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            final productCubit = VendorProductCrudCubit.instance(context);
            return Form(
              key: formKey,
              child: Scaffold(
                backgroundColor: AppColors.scaffoldBackgroundColor,
                appBar: _appBar(context),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                ProductDetailsWidget(
                                    productCubit: productCubit),
                                Align(
                                  child: state is AddProductLoadingState
                                      ? const CircularProgressIndicator()
                                      : CustomButton(
                                          width: 176.w,
                                          height: 60.h,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              final validateProductData =
                                                  productCubit
                                                      .validateProductData(
                                                          context);
                                              if (validateProductData == null) {
                                                productCubit.addNewProduct();
                                              } else {
                                                SharedMethods.showToast(context,
                                                    validateProductData,
                                                    textColor: Colors.white,
                                                    color:
                                                        AppColors.errorColor);
                                              }
                                            }
                                          },
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
              ),
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
      // leading: IconButton(
      //   onPressed: () {
      //     Navigator.of(context).pop();
      //   },
      //   icon: const Icon(Icons.arrow_back, color: Colors.white),
      // ),
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
    );
  }
}
