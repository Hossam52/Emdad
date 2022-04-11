import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorButtonsBuild extends StatelessWidget {
  const VendorButtonsBuild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          width: 32.w,
          height: 32.h,
          icon: const Icon(MyIcons.map_pin_fill,
              size: 18, color: AppColors.primaryColor),
        ),
        SizedBox(width: 20.w),
        CustomIconButton(
          width: 32.w,
          height: 32.h,
          icon: const Icon(Icons.star_border,
              size: 21, color: AppColors.thirdColor),
        ),
        SizedBox(width: 20.w),
        CustomIconButton(
          width: 32.w,
          height: 32.h,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                insetPadding: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('الابلاغ عن مورد'),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'ما هى المشكلة ؟',
                          hintStyle: subTextStyle(),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'ابلاغ',
                        onPressed: () {
                          Navigator.pop(context);
                          showSnackBar(
                            context: context,
                            text: 'تم الابلاغ عن المورد',
                            snackBarStates: SnackBarStates.success,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          icon: const Icon(Icons.do_disturb_on,
              size: 21, color: AppColors.errorColor),
        ),
      ],
    );
  }
}
