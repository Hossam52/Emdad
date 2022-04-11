import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/location_picker/location_picker_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseLocationBuildItem extends StatelessWidget {
  const ChooseLocationBuildItem({Key? key, required this.cubit}) : super(key: key);

  final AuthCubit cubit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context, LocationPickerScreen(authCubit: cubit));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/map.jpg',
              width: double.infinity,
              height: 125.h,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'اختر الموقع علي الخريطة',
                      style: thirdTextStyle().copyWith(
                        color: AppColors.textButtonColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    const Icon(
                      Icons.place,
                      color: AppColors.textButtonColor,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
