import 'dart:developer';

import 'package:emdad/models/users/user/user_response_model.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_circle_image.dart';
import 'package:emdad/shared/widgets/default_ratingbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'location_build_item.dart';

class VendorInfoBuildItem extends StatelessWidget {
  const VendorInfoBuildItem({
    Key? key,
    required this.isCart,
    required this.tailing,
    this.vendor,
    this.name,
    this.logoUrl,
    this.city,
    this.vendorType,
  }) : super(key: key);

  final bool isCart;
  final Widget tailing;
  final String? logoUrl;
  final String? city;
  final String? vendorType;
  final String? name;
  final User? vendor;

  @override
  Widget build(BuildContext context) {
    log((vendor?.overAllRating ?? 'NULL ').toString());
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.primaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultCircleImage(
            width: 90.r,
            height: 90.r,
            imageUrl: logoUrl ?? vendor?.logoUrl ?? '',
          ),
          SizedBox(width: 25.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isCart)
                  Text(name ?? vendor?.organizationName ?? 'Organization name',
                      style: secondaryTextStyle().copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                LocationBuildItem(
                    location: city ?? vendor?.city ?? 'City',
                    textColor: Colors.white),
                Text(vendorType ?? vendor?.allVendorTypeString ?? '',
                    style: thirdTextStyle().copyWith(color: Colors.white)),
                if (isCart == false)
                  DefaultRatingBarNotTapped(rate: vendor?.overAllRating ?? 0),
                SizedBox(height: 27.h),
                tailing,
              ],
            ),
          )
        ],
      ),
    );
  }
}
