import 'package:flutter/material.dart';

class DefaultCircularProgressIndicator extends StatelessWidget {
  const DefaultCircularProgressIndicator({
    Key? key,
    this.width = 20,
    this.height = 20,
    this.color,
  }) : super(key: key);

  final double width;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(color: color),
    );
  }
}
