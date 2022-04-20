import 'package:emdad/models/rating/rate_model.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_circle_image.dart';
import 'package:emdad/shared/widgets/default_ratingbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'location_build_item.dart';

class ReviewBuildItem extends StatelessWidget {
  const ReviewBuildItem({Key? key, this.hasMargin = true, this.rateModel})
      : super(key: key);

  final bool hasMargin;
  final RateModel? rateModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.5),
      margin: hasMargin
          ? const EdgeInsetsDirectional.only(end: 16)
          : EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultCircleImage(
              width: 46.r,
              height: 46.r,
              imageUrl:
                  'https://play-lh.googleusercontent.com/vGvZXoThMUkAQpJ1iM2nH46-h03a6S8XWL7zIQZ7OLsrWiWqferlm0fPPVAP_ZH3F84',
            ),
            SizedBox(width: 7.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rateModel!.user.name,
                    style:
                        subTextStyle().copyWith(fontWeight: FontWeight.w700)),
                LocationBuildItem(location: rateModel!.user.city),
                const DefaultRatingBarNotTapped(
                    rate: 3.0, size: 16, padding: EdgeInsets.zero),
                SizedBox(height: 3.h),
                SizedBox(
                  width: 180.w,
                  child: Text(
                    rateModel!.comment,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: subTextStyle(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
