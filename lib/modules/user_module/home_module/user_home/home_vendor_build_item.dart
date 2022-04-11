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
  }) : super(key: key);

  final double width;
  final bool isFavorite;
  final Function() onTap;

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
            Stack(
              children: [
                Container(
                  width: width,
                  height: width,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DefaultCachedNetworkImage(
                    imageUrl:
                        'https://cdn.dribbble.com/users/230290/screenshots/15128882/media/4175d17c66f179fea9b969bbf946820f.jpg?compress=1&resize=400x300',
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
            SizedBox(height: 12.h),
            Text(
              'الهدي للتوريدات',
              style: subTextStyle().copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'خضروات',
              style: subTextStyle().copyWith(
                color: Colors.black54,
              ),
            ),
            Text(
              'الرياض',
              style: subTextStyle().copyWith(
                color: Colors.black54,
              ),
            ),
            Row(
              children: [
                Text(
                  '4.9',
                  style: subTextStyle().copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.thirdColor,
                  ),
                ),
                const Icon(
                  Icons.star_rounded,
                  color: AppColors.thirdColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
