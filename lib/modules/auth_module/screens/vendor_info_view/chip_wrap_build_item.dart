import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChipWrapBuildItem extends StatelessWidget {
  const ChipWrapBuildItem({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.onSelected,
  }) : super(key: key);

  final List<String> items;
  final List<String> selectedItems;
  final Function(bool selected, int index) onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        items.length,
        (index) {
          var item = items[index];
          return Padding(
            padding: EdgeInsets.all(6.r),
            child: FilterChip(
              avatar: CircleAvatar(
                child: Text(
                  item.substring(0, 1),
                  style: thirdTextStyle(),
                ),
              ),
              label: Text(
                item,
                style: thirdTextStyle(),
              ),
              selected: selectedItems.contains(item),
              onSelected: (selected) {
                onSelected(selected, index);
              },
            ),
          );
        },
      ),
    );
  }
}
