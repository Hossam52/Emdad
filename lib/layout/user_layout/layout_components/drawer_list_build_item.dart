import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class DrawerListBuildItem extends StatelessWidget {
  const DrawerListBuildItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.size = 20,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function() onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: thirdTextStyle()),
      leading: Icon(icon, color: Colors.black, size: size),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 22),
    );
  }
}
