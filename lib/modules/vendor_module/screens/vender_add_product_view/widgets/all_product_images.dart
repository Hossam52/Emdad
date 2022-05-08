import 'package:cached_network_image/cached_network_image.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/vendor_product_crud_cubit/vendor_product_crud_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllProductImages extends StatelessWidget {
  const AllProductImages({
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
