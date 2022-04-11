import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class CustomTransporterOrderListTile extends StatelessWidget {
  const CustomTransporterOrderListTile({
    Key? key,
    required this.clientImageUrl,
    required this.clientName,
    required this.clientCompanyName,
    required this.address,
  }) : super(key: key);

  final String clientImageUrl;
  final String clientName;
  final String clientCompanyName;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xffEF6038), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            minRadius: 35.r,
            maxRadius: 37.r,
            backgroundImage: NetworkImage(
              clientImageUrl,
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'العميل:',
                textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w500),
              ),
              CustomText(
                text: 'المؤسسة:',
                textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w500),
              ),
              CustomText(
                text: 'العنوان:',
                textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: clientName,
                textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w500),
              ),
              CustomText(
                text: clientCompanyName,
                textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w500),
              ),
              CustomText(
                text: address,
                textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Flexible(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/map.png',
                  width: 122.w,
                  height: 81.h,
                  fit: BoxFit.cover,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      text: 'اختر الموقع علي الخريطة',
                      textStyle:
                      subTextStyle().copyWith(fontWeight: FontWeight.w500),
                    ),
                    const Icon(
                      Icons.place,
                      color: AppColors.textButtonColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}