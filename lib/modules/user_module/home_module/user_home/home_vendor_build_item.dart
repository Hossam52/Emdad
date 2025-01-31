import 'package:emdad/models/users/user/user_response_model.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeVendorBuildItem extends StatelessWidget {
  const HomeVendorBuildItem({
    Key? key,
    required this.width,
    required this.isFavorite,
    required this.onTap,
    required this.user,
  }) : super(key: key);

  final double width;
  final bool isFavorite;
  final Function() onTap;
  final User user;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: width,
                    height: width,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DefaultCachedNetworkImage(
                      imageUrl: user.logoUrl ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (isFavorite)
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15.r,
                        child: IconButton(
                          color: Colors.red,
                          iconSize: 20,
                          icon: const Icon(Icons.favorite),
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // SizedBox(height: 12.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      user.name!,
                      style: subTextStyle().copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      user.allVendorTypeString,
                      style: subTextStyle().copyWith(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      user.city!,
                      style: subTextStyle().copyWith(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        Text(
                          (user.overAllRating ?? 0).toStringAsFixed(1),
                          style: subTextStyle().copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.thirdColor,
                          ),
                        ),
                        Icon(
                          Icons.star_rounded,
                          size: 20.r,
                          color: AppColors.thirdColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
