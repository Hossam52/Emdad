import 'package:emdad/models/general_models/on_boarding_model.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardItem extends StatelessWidget {
  const OnBoardItem({
    Key? key,
    required this.boardingModel,
  }) : super(key: key);

  final BoardingModel boardingModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 295.w,
          height: 550.h,
          decoration: BoxDecoration(
            color: AppColors.textButtonColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(boardingModel.logoImagePath),
            SizedBox(height: 20.h),
            Text(
              boardingModel.title,
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                boardingModel.body,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.white.withOpacity(0.5),
                  height: 1.5.h,
                ),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
