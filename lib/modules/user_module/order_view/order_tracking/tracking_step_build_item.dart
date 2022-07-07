import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:flutter/material.dart';

import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';

class TrackingStepBuildItem extends StatelessWidget {
  const TrackingStepBuildItem({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<TrackingStatusItem> items;
  @override
  Widget build(BuildContext context) {
    final currentStepIndex =
        items.indexWhere((element) => element.dateString == null);
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (context, index) {
        final item = items[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: item.dateString != null
                        ? AppColors.successColor.withOpacity(0.4)
                        : AppColors.secondaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(item.icon,
                      color: item.dateString != null
                          ? AppColors.successColor
                          : AppColors.primaryColor),
                ),
                if (index != items.length - 1)
                  const DottedLine(
                    direction: Axis.vertical,
                    lineLength: 60,
                    dashGapLength: 5,
                    dashLength: 10,
                    lineThickness: 1,
                  ),
              ],
            ),
            Expanded(
              child: ListTile(
                title: Text(item.title,
                    style:
                        thirdTextStyle().copyWith(fontWeight: FontWeight.w700)),
                subtitle: Text(
                  item.dateString != null
                      ? SharedMethods.mappedDateWithSeconds(item.dateString!)
                      : context.tr.not_done_yet,
                  style: secondaryTextStyle()
                      .copyWith(fontWeight: FontWeight.w300),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              ),
            )
          ],
        );
      },
    );
  }
}

class TrackingStatusItem {
  String title;
  String? dateString;
  IconData icon;
  TrackingStatusItem({
    required this.title,
    required this.dateString,
    required this.icon,
  });
}
