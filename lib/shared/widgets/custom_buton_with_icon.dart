import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double radius;
  final double padding;
  final double width;
  final double height;
  final TextStyle? textStyle;
  final IconData iconData;

  const CustomButtonWithIcon({
    Key? key,
    required this.onPressed,
    this.text = 'write text',
    this.textColor = Colors.white,
    this.color = AppColors.textButtonColor,
    this.radius = 10.0,
    this.padding = 5.0,
    this.width = double.infinity,
    this.height = 50,
    this.textStyle,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          padding:
              MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(padding)),
          side: MaterialStateProperty.all(
            const BorderSide(width: 0, color: AppColors.textButtonColor),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: CustomText(
                text: text,
                textStyle:
                    textStyle ?? subTextStyle().copyWith(color: textColor),
              ),
            ),
            SizedBox(width: 30.w),
            Flexible(
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
