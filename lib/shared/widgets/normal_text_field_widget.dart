import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NormalTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  const NormalTextField({
    Key? key,
    required this.controller,
    this.onChanged,
    required this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 50.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: TextFormField(
          cursorColor: Colors.grey,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.textButtonColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.textButtonColor,
              ),
            ),
          ),
          style: thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ),
    );
  }
}
