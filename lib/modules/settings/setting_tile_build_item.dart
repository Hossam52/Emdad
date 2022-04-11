import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingTileBuildItem extends StatelessWidget {
  SettingTileBuildItem({
    Key? key,
    required this.title,
    required this.leading,
    this.onTap,
    this.trailing = const Icon(CupertinoIcons.forward,
        color: AppColors.primaryColor, size: 20),
  }) : super(key: key);

  final String title;
  final Widget leading;
  final Widget trailing;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: thirdTextStyle().copyWith(fontWeight: FontWeight.w400)),
      leading: leading,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
