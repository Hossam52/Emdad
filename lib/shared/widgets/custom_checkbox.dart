import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox(
      {Key? key, required this.isChecked, required this.onChange})
      : super(key: key);
  final bool isChecked;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChange,
      child: Container(
        decoration: BoxDecoration(
          color: isChecked ? AppColors.secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
          border: isChecked ? null : Border.all(color: textGrey, width: 1.5),
        ),
        width: 20,
        height: 20,
        child: isChecked
            ? const Icon(
                Icons.check,
                size: 20,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
