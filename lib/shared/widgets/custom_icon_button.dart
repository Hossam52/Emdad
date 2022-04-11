import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.width,
    required this.height,
    required this.icon,
    this.onPressed,
    this.buttonColor = Colors.white,
  }) : super(key: key);

  final double width;
  final double height;
  final Widget icon;
  final Color buttonColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: buttonColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: icon,
        color: buttonColor,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
