import 'package:cached_network_image/cached_network_image.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileInfoBuildItem extends StatelessWidget {
  const ProfileInfoBuildItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 55),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            AppColors.secondaryColor.withOpacity(0.18),
            AppColors.secondaryColor.withOpacity(0.09),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 145.r,
            height: 145.r,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.secondaryColor.withOpacity(0.7),
                width: 4,
              ),
              image: const DecorationImage(
                image: CachedNetworkImageProvider(
                  'https://mir-s3-cdn-cf.behance.net/project_modules/fs/c2f3a644232807.580c702a05425.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'عمرو التهامى',
                      style: headersTextStyle()
                          .copyWith(color: AppColors.primaryColor),
                    ),
                    Text(
                      'الرياض ,ىالمملكه العربيه السعوديه',
                      style: subTextStyle()
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              CustomIconButton(
                width: 45.w,
                height: 45.h,
                icon: const Icon(MyIcons.edit, color: Colors.white),
                buttonColor: AppColors.secondaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
