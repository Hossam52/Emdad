import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? hintText;

  const SearchWidget({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
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
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            hintText: hintText,
            hintStyle: thirdTextStyle().copyWith(fontWeight: FontWeight.normal),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          style: thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
