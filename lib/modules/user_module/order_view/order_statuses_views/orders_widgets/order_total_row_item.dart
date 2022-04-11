import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class OrderTotalRowItem extends StatelessWidget {
  const OrderTotalRowItem({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            style: subTextStyle().copyWith(color: AppColors.primaryColor)),
        const Spacer(),
        Text(value,
            style: subTextStyle().copyWith(fontWeight: FontWeight.w700)),
      ],
    );
  }
}
