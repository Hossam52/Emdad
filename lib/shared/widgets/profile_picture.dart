import 'package:cached_network_image/cached_network_image.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProfilePicture extends StatelessWidget {
  const MyProfilePicture({Key? key, this.radius, required this.url})
      : super(key: key);
  final double? radius;
  final String url;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius?.r ?? 145.r,
      height: radius?.r ?? 145.r,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.secondaryColor.withOpacity(0.7),
          width: 4,
        ),
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            url,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
