import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';
import 'package:emdad/shared/widgets/default_ratingbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardBuildItem extends StatelessWidget {
  const ProductCardBuildItem({
    Key? key,
    this.isVendor = false,
    this.isList = false,
    this.product,
    required this.onProductTapped,
    this.trailing,
    this.selectedCard = false,
  }) : super(key: key);

  final bool isVendor;
  final bool isList;
  final ProductModel? product;
  final VoidCallback onProductTapped;
  final Widget? trailing;
  final bool selectedCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          isList ? const EdgeInsetsDirectional.only(end: 17) : EdgeInsets.zero,
      elevation: 0,
      child: GestureDetector(
        onTap: onProductTapped,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // gradient: !selectedCard
            //     ? null
            //     : LinearGradient(
            //         colors: [
            //             AppColors.primaryColor,
            //             AppColors.primaryColor.withOpacity(0.5),
            //             AppColors.primaryColor.withOpacity(0.45),
            //             AppColors.primaryColor.withOpacity(0.4),
            //             AppColors.primaryColor.withOpacity(0.1),
            //             AppColors.primaryColor.withOpacity(0.0),
            //             AppColors.primaryColor.withOpacity(0.0),
            //           ],
            //         begin: AlignmentDirectional.topCenter,
            //         end: AlignmentDirectional.bottomCenter),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 110.w,
                height: 130.h,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DefaultCachedNetworkImage(
                  imageUrl: product!.images.first,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 4.h),
              // Row(
              //   children: [
              //     const DefaultRatingbar(rate: 4.0, size: 14),
              //     const SizedBox(width: 4),
              //     Text(
              //       '(4.2)',
              //       style: subTextStyle().copyWith(
              //         fontWeight: FontWeight.w600,
              //         color: Colors.amber,
              //       ),
              //     ),
              //   ],
              // ),
              Container(
                color: selectedCard
                    ? AppColors.successColor.withOpacity(0.3)
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product!.name,
                          style: subTextStyle().copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          getPiceAccordingToUnit(),
                          style: subTextStyle().copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    if (trailing != null) trailing!,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getPiceAccordingToUnit() {
    if (isVendor) return product!.units.first.generateStringPerUnit;
    if (!product!.isPriceShown) return 'السعر مخفي';
    return product!.units.isEmpty
        ? ' '
        : product!.units.first.generateStringPerUnit;
  }
}
