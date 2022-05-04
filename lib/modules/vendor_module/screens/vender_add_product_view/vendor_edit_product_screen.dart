import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/modules/vendor_module/price_details_table.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/vendor_product_crud_cubit/vendor_product_crud_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:emdad/shared/widgets/dialogs/add_new_price.dart';
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
    return BlocProvider(
      create: (context) => VendorProductCrudCubit(widget.product),
      child: VendorProductCrudCubitBlocBuilder(
        builder: (context, state) {
          return VendorBlocConsumer(
            listener: (context, state) {},
            builder: (context, state) {
              final productCubit = VendorProductCrudCubit.instance(context);
              final product = productCubit.product;
              return Scaffold(
                backgroundColor: AppColors.scaffoldBackgroundColor,
                appBar: _appBar(context),
                body: ListView(
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
                          const _MainImage(),
                          SizedBox(height: 20.h),
                          const _AllImages(),
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
                            Column(
                              children: [
                                CustomText(
                                  text: 'اسم المنتج',
                                  textStyle: secondaryTextStyle()
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 5.h),
                                buildTextFormField(
                                  controller:
                                      productCubit.productNameController,
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
                                  controller:
                                      productCubit.productDescriptionController,
                                  onChanged: (String? value) {},
                                  onSubmitted: (String? value) {},
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: 'تفاصيل السعر',
                                      textStyle: secondaryTextStyle().copyWith(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showModalSheet(context);
                                      },
                                      child: Material(
                                        elevation: 10,
                                        borderRadius:
                                            BorderRadius.circular(20.r),
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
                                const PriceDetailsTable(),
                                SizedBox(height: 40.h),
                                ListTile(
                                  trailing: Checkbox(
                                    value: product.isPriceShown,
                                    onChanged: (bool? value) {
                                      productCubit
                                          .changePriceVisibility(value!);
                                    },
                                    activeColor: Colors.green,
                                  ),
                                  leading: CustomText(
                                    text: 'اظهار السعر',
                                    textStyle: thirdTextStyle().copyWith(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
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
      actions: const [
        ChangeLangWidget(
          color: Colors.white,
        )
      ],
    );
  }

  showModalSheet(BuildContext context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext _context) {
        return AddNewPriceDialog(
          onSave: (
              {required minimumAmount,
              required pricePerUnit,
              required productUnit}) {
            VendorProductCrudCubit.instance(context).addPriceUnit(
                productUnit: productUnit,
                minimumAmount: minimumAmount,
                pricePerUnit: pricePerUnit);
          },
        );
      },
    );
  }

  Widget buildTextFormField({
    required TextEditingController? controller,
    required Function(String)? onChanged,
    required Function(String)? onSubmitted,
  }) {
    return CustomTextFormField(
      validation: (val) {},
      controller: controller,
      contentPadding: const EdgeInsets.all(4),
      onChange: onChanged,
      onSubmit: onSubmitted,
    );
  }
}

class _ImageItem extends StatelessWidget {
  const _ImageItem(
      {Key? key,
      required this.index,
      required this.onDeleteImage,
      required this.imageProvider})
      : super(key: key);
  final int index;
  final VoidCallback onDeleteImage;
  final ImageProvider imageProvider;
  @override
  Widget build(BuildContext context) {
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
              image: imageProvider,
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
              onPressed: onDeleteImage,
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
}

class _MainImage extends StatelessWidget {
  const _MainImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VendorProductCrudCubitBlocBuilder(
      builder: (context, state) {
        final productCubit = VendorProductCrudCubit.instance(context);
        return Column(
          children: [
            CustomText(
              text: 'الصوره الرئيسية',
              textStyle: thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
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
                      image: productCubit.hasPickedMainFile
                          ? FileImage(productCubit.mainProductImageFile)
                              as ImageProvider
                          : CachedNetworkImageProvider(
                              productCubit.originalMainImage,
                            ),
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
                        productCubit.pickMainImage();
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
            )
          ],
        );
      },
    );
  }
}

class _AllImages extends StatelessWidget {
  const _AllImages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productCubit = VendorProductCrudCubit.instance(context);
    return VendorProductCrudCubitBlocBuilder(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'صور اخري',
                  textStyle:
                      thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
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
                        productCubit.pickImages();
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
            productCubit.isEmptyImages
                ? SvgPicture.asset('assets/images/questions_amico.svg')
                : SizedBox(
                    height: 100.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        originalImagesListView(), //For online images that come with product
                        addedFilesImagesListView(), //For images that selected from gallery
                      ],
                    ),
                  )
          ],
        );
      },
    );
  }

  Widget originalImagesListView() {
    return Builder(builder: (context) {
      final productCubit = VendorProductCrudCubit.instance(context);
      final originalImages = productCubit.originalProductImages;
      return ListView.separated(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _ImageItem(
            index: index,
            onDeleteImage: () {
              productCubit.removeOriginalImage(index);
            },
            imageProvider: CachedNetworkImageProvider(originalImages[index])),
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemCount: originalImages.length,
      );
    });
  }

  Widget addedFilesImagesListView() {
    return Builder(builder: (context) {
      final productCubit = VendorProductCrudCubit.instance(context);
      final imageFiles = productCubit.productImagesFromFiles;
      return ListView.separated(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _ImageItem(
            index: index,
            onDeleteImage: () {
              productCubit.removeFileImage(index);
            },
            imageProvider: FileImage(imageFiles[index])),
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemCount: imageFiles.length,
      );
    });
  }
}
