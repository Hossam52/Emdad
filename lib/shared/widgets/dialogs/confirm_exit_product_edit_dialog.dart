import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/custom_buton_with_icon.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ConfirmExitProductEditDialog extends StatelessWidget {
  const ConfirmExitProductEditDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm close'),
      content: Column(mainAxisSize: MainAxisSize.min, children: const [
        Text('Are you sure to exit and all data will be deleted?'),
      ]),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: [
        CustomButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          backgroundColor: Colors.red,
          textColor: Colors.white,
          text: 'Close',
        ),
        const SizedBox(
          height: 20,
        ),
        CustomButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          backgroundColor: AppColors.secondaryColor,
          textColor: Colors.white,
          text: 'Stay',
        ),
      ],
    );
  }
}
