import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({Key? key, required this.item, required this.onDeleted})
      : super(key: key);
  final String item;
  final VoidCallback onDeleted;
  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
      deleteIcon: const Icon(Icons.close),
      onDeleted: onDeleted,
      deleteIconColor: Colors.white,
      label: Text(
        item,
        style: thirdTextStyle().copyWith(color: Colors.white),
      ),
    );
  }
}
