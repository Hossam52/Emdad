import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class LocationBuildItem extends StatelessWidget {
  const LocationBuildItem({Key? key, required this.location, this.textColor = Colors.black}) : super(key: key);

  final String location;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        const Icon(MyIcons.map_pin_fill,
            size: 13, color: AppColors.thirdColor),
        const SizedBox(width: 2),
        Text(
          location,
          style: subTextStyle().copyWith(color: textColor),
        ),
      ],
    );
  }
}
