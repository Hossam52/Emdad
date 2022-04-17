import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomUpdateProfileAppBar extends StatelessWidget {
  const CustomUpdateProfileAppBar({Key? key, required this.title})
      : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: primaryTextStyle().copyWith(fontSize: 14.sp),
      actions: const [
        ChangeLangWidget(
            // color: Colors.white,
            )
      ],
    );
  }
}
