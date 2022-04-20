import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/modules/user_module/vendors_module/product_details/product_details_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:flutter/material.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';
import 'package:emdad/shared/widgets/default_ratingbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardBuildItem extends StatelessWidget {
  const ProductCardBuildItem({
    Key? key,
    required this.name,
    required this.image,
    this.hasCart = true,
    this.isVendor = false,
    this.isList = false,
    this.product,
  }) : super(key: key);

  final String name;
  final String image;
  final bool hasCart;
  final bool isVendor;
  final bool isList;
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          isList ? const EdgeInsetsDirectional.only(end: 17) : EdgeInsets.zero,
      elevation: 0,
      child: GestureDetector(
        onTap: () {
          navigateTo(context,
              ProductDetailsScreen(productId: product!.id, isVendor: isVendor));
        },
        child: Column(
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
            Row(
              children: [
                const DefaultRatingbar(rate: 4.0, size: 14),
                const SizedBox(width: 4),
                Text(
                  '(4.2)',
                  style: subTextStyle().copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            if (hasCart)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(Icons.add_shopping_cart, size: 20),
                    ),
                  ),
                ],
              )
            else
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
          ],
        ),
      ),
    );
  }

  String getPiceAccordingToUnit() {
    return product!.units.isEmpty
        ? ' '
        : product!.units.first.generateStringPerUnit;
  }
}
