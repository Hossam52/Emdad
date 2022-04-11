import 'package:dotted_line/dotted_line.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class TrackingStepBuildItem extends StatelessWidget {
  const TrackingStepBuildItem({
    Key? key,
    required this.count,
    required this.icons,
    required this.title,
    required this.subtitle,
    required this.currentStep,
  }) : super(key: key);

  final int count;
  final int currentStep;
  final List<IconData> icons;
  final List<String> title;
  final List<String> subtitle;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: count,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: index <= currentStep - 1
                          ? AppColors.successColor.withOpacity(0.4) : AppColors.secondaryColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icons[index], color: index <= currentStep - 1
                        ? AppColors.successColor : AppColors.primaryColor),
                  ),
                  if (index != count - 1)
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
                  title: Text(title[index],
                      style: thirdTextStyle()
                          .copyWith(fontWeight: FontWeight.w700)),
                  subtitle: Text(subtitle[index]),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
