import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';

class OrderBuildItem extends StatelessWidget {
  OrderBuildItem({
    Key? key,
    required this.hasBadge,
    required this.onTap,
    required this.title,
    required this.image,
    this.trailing,
  }) : super(key: key);

  final bool hasBadge;
  final Function() onTap;
  final String title;
  final String image;
  Widget? trailing;
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
                  imageUrl: image,
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
                      style: thirdTextStyle().copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '12-2-2020',
                      style: subTextStyle(),
                    ),
                    if (hasBadge)
                      Chip(
                        label: Text('لم يتم اضافة عرض',
                            style: subTextStyle()
                                .copyWith(color: AppColors.errorColor)),
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(0.15),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    if(trailing != null)
                      trailing!,
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
