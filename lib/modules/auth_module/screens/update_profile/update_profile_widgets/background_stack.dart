import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';

class BackgroundStack extends StatelessWidget {
  const BackgroundStack({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.grey.withOpacity(0.1),
      child: Stack(
        children: [
          Positioned(
              top: -height * 0.3 * 1.3,
              right: 0,
              left: 0,
              child: buildCircle(height * 0.3, AppColors.secondaryColor)),
          Positioned(
              right: -height * 0.3 * 1.2,
              top: 0,
              bottom: 0,
              child: buildCircle(
                  height * 0.3, AppColors.thirdColor.withOpacity(0.17))),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: child,
          ),
        ],
      ),
    );
  }

  Widget buildCircle(double radius, Color color) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
    );
  }
}
