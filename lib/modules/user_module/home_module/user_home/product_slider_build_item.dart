import 'package:cached_network_image/cached_network_image.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class ProductSliderBuildItem extends StatelessWidget {
  const ProductSliderBuildItem({Key? key, required this.screenWidth})
      : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        image: DecorationImage(
          image: const CachedNetworkImageProvider(
            'https://images.unsplash.com/photo-1557844352-761f2565b576?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
          ),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الهدي للتوريدات',
              style: thirdTextStyle().copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              'خضروات',
              style: subTextStyle().copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              'الرياض',
              style: subTextStyle().copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Text(
                  '4.9',
                  style: subTextStyle().copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Icon(
                  Icons.star_rounded,
                  color: AppColors.thirdColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
