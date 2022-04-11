import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';

class BackgroundStack extends StatelessWidget {
  const BackgroundStack({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: child,
        ),
        Positioned(
            top: height * 0.3 + height * 0.28,
            child: buildCircle(height * 0.3, AppColors.primaryColor))
      ],
    );
  }

  Widget buildCircle(double radius, Color color) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
    );
  }
}
