import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final int? maxLine;
  final TextOverflow? overflow;
  final bool? softWrap;

  const CustomText({
    Key? key,
    this.text = '',
    this.textStyle,
    this.textAlign = TextAlign.center,
    this.maxLine,
    this.overflow,
    this.softWrap = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: textStyle,
      maxLines: maxLine,
      overflow: overflow,
      softWrap: softWrap,
      textAlign: textAlign,
    );
  }
}