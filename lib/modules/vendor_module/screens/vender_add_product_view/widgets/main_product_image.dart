import 'package:cached_network_image/cached_network_image.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/vendor_product_crud_cubit/vendor_product_crud_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainProductImage extends StatelessWidget {
  const MainProductImage({Key? key}) : super(key: key);

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
                    image: productCubit.noMainImage
                        ? null
                        : DecorationImage(
                            image: productCubit.hasPickedMainFile
                                ? FileImage(productCubit.mainProductImageFile)
                                    as ImageProvider
                                : CachedNetworkImageProvider(
                                    productCubit.originalMainImage,
                                  ),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: productCubit.noMainImage == false
                      ? null
                      : const Center(child: Text('لم تختار اي صورة')),
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
