import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class DefaultProgressButton extends StatelessWidget {
  const DefaultProgressButton({
    Key? key,
    required this.buttonState,
    this.onPressed,
    this.borderRadius = 100.0,
    required this.idleText,
    this.loadingText = 'loading',
    required this.failText,
    required this.successText,
  }) : super(key: key);

  final ButtonState buttonState;
  final Function? onPressed;
  final String idleText;
  final String loadingText;
  final String failText;
  final String successText;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: onPressed == null ? Clip.antiAliasWithSaveLayer : Clip.none,
      decoration: onPressed == null
          ? BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(borderRadius),
            )
          : null,
      child: ProgressButton.icon(
        radius: borderRadius,
        textStyle: thirdTextStyle().copyWith(color: Colors.white),
        iconedButtons: {
          ButtonState.idle: IconedButton(
            text: idleText,
            icon: const Icon(
              Icons.send,
              size: 0,
            ),
            color: AppColors.secondaryColor,
          ),
          ButtonState.loading: const IconedButton(
              text: 'Loading', color: AppColors.secondaryColor),
          ButtonState.fail: IconedButton(
              text: failText,
              icon: const Icon(Icons.cancel, color: Colors.white),
              color: AppColors.errorColor),
          ButtonState.success: IconedButton(
            text: successText,
            icon: const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            color: AppColors.successColor,
          )
        },
        onPressed: onPressed,
        state: buttonState,
      ),
    );
  }
}
