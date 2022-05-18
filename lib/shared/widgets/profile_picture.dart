import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _Container extends StatelessWidget {
  const _Container({Key? key, this.radius, required this.imageProvider})
      : super(key: key);
  final double? radius;
  final ImageProvider imageProvider;
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
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MyProfilePicture extends StatelessWidget {
  const MyProfilePicture({Key? key, this.radius, required this.url})
      : super(key: key);
  final double? radius;
  final String url;
  @override
  Widget build(BuildContext context) {
    return _Container(
      imageProvider: CachedNetworkImageProvider(
        url,
      ),
    );
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

class ProfilePictureFromFile extends StatelessWidget {
  const ProfilePictureFromFile({Key? key, required this.file})
      : super(key: key);
  final File file;
  @override
  Widget build(BuildContext context) {
    return _Container(
      imageProvider: FileImage(file),
    );
  }
}
