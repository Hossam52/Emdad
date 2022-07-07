import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:flutter/material.dart';

class TrackingListTile extends StatelessWidget {
  const TrackingListTile({
    Key? key,
    required this.name,
    required this.type,
  }) : super(key: key);

  final String name;
  final TrackingType type;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        type == TrackingType.source
            ? context.tr.delivery_location
            : context.tr.vendor,
        style: subTextStyle().copyWith(color: Colors.grey),
      ),
      contentPadding: EdgeInsets.zero,
      subtitle: Text(
        name,
        style: secondaryTextStyle()
            .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
      ),
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: type == TrackingType.source
            ? AppColors.secondaryColor.withOpacity(0.5)
            : Colors.grey.withOpacity(0.4),
        child: Icon(
            type == TrackingType.source ? Icons.circle : MyIcons.map_pin_fill,
            size: 12,
            color: type == TrackingType.source
                ? AppColors.primaryColor
                : Colors.black),
      ),
      trailing: type == TrackingType.source
          ? IconButton(
              icon: const Icon(MyIcons.map_pin_fill, size: 20),
              onPressed: () {})
          : null,
    );
  }
}

enum TrackingType { source, destination }
