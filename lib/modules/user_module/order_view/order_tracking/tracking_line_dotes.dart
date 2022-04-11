import 'package:flutter/material.dart';

class TrackingLineDotes extends StatelessWidget {
  const TrackingLineDotes({
    Key? key,
    this.height = 8,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(10)),
    );
  }
}
