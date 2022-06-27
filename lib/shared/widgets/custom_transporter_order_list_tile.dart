import 'package:emdad/models/supply_request/user_preview.dart';
import 'package:emdad/modules/map_module/screens/map_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class CustomTransporterOrderListTile extends StatelessWidget {
  const CustomTransporterOrderListTile({
    Key? key,
    required this.client,
  }) : super(key: key);
  final UserPreviewModel client;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 96.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xffEF6038), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: DefaultCachedNetworkImage(
              imageUrl: client.logoUrl,
              fit: BoxFit.cover,
            ),
          ),
          // CircleAvatar(
          //   minRadius: 35.r,
          //   maxRadius: 37.r,
          //   backgroundImage: NetworkImage(
          //     clientImageUrl,
          //   ),
          // ),
          SizedBox(width: 10.w),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                richText('العميل', client.name),
                richText('المؤسسة', client.oraganizationName),
                richText('العنوان', client.detailAddress),
              ],
            ),
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     CustomText(
          //       text: 'العميل:',
          //       textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w500),
          //     ),
          //     CustomText(
          //       text: 'المؤسسة:',
          //       textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w500),
          //     ),
          //     CustomText(
          //       text: 'العنوان:',
          //       textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w500),
          //     ),
          //   ],
          // ),
          // SizedBox(width: 10.w),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     CustomText(
          //       text: clientName,
          //       textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w500),
          //     ),
          //     CustomText(
          //       text: clientCompanyName,
          //       textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w500),
          //     ),
          //     CustomText(
          //       text: address,
          //       textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w500),
          //     ),
          //   ],
          // ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                navigateTo(
                  context,
                  MapScreen(
                      lat: client.locationObject.lat,
                      lng: client.locationObject.lng,
                      screenTitle: client.oraganizationName),
                );
              },
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
                        textStyle: subTextStyle()
                            .copyWith(fontWeight: FontWeight.w500),
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
          ),
        ],
      ),
    );
  }

  Widget richText(String key, String val) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: key + ' : ',
          style: subTextStyle()
              .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
          children: [
            TextSpan(
              text: val,
              style: subTextStyle().copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }
}
