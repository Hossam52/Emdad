import 'package:emdad/shared/widgets/default_circle_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emdad/shared/styles/font_styles.dart';

import 'vendor_view/vendor_view_componants/location_build_item.dart';

class VendorBuildItem extends StatelessWidget {
  const VendorBuildItem({Key? key, required this.onTap}) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(bottom: 20),
      shadowColor: Colors.black.withOpacity(0.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              DefaultCircleImage(
                width: 53.w,
                height: 53.w,
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/sco/thumb/b/bf/KFC_logo.svg/1200px-KFC_logo.svg.png',
              ),
              SizedBox(width: 13.5.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الرحمه للمواد الغذائية',
                      style: thirdTextStyle().copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const LocationBuildItem(location: 'الرياض'),
                    Text(
                      'مواد غذائيه',
                      style: subTextStyle(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
