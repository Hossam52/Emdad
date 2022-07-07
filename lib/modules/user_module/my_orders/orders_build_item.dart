import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';

class OrderBuildItem extends StatelessWidget {
  const OrderBuildItem({
    Key? key,
    required this.hasBadge,
    required this.onTap,
    required this.title,
    required this.image,
    required this.date,
    this.trailing,
    this.subTitleText,
    this.badgeText,
  }) : super(key: key);
  final String title;
  final String image;
  final String date;
  final bool hasBadge;
  final String? badgeText;
  final Function() onTap;
  final Widget? trailing;
  final String? subTitleText;
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
              Container(
                width: 53.w,
                height: 53.w,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: DefaultCachedNetworkImage(
                  imageUrl: image, //order.vendor.logoUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 13.5.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      // order.id,
                      // order.vendor.oraganizationName,
                      style: thirdTextStyle().copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (subTitleText != null) Text(subTitleText!),
                    Text(
                      SharedMethods.mappedDate(
                        date, // order.createdAt,
                      ),
                      style: subTextStyle(),
                    ),
                    if (hasBadge)
                      if (badgeText != null)
                        Chip(
                          label: Text(badgeText!,
                              style: subTextStyle()
                                  .copyWith(color: AppColors.errorColor)),
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(0.15),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        )
                      else
                        Chip(
                          label: Text(context.tr.offers_not_added,
                              style: subTextStyle()
                                  .copyWith(color: AppColors.errorColor)),
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(0.15),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                    if (trailing != null) trailing!,
                  ],
                ),
              ),
              RawMaterialButton(
                onPressed: () {},
                child: const Icon(Icons.arrow_forward_ios, size: 12),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                constraints: const BoxConstraints(minWidth: 0),
                padding: const EdgeInsets.all(6),
                fillColor: Colors.white54,
                shape: const CircleBorder(),
                elevation: 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
