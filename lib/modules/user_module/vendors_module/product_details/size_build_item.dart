import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class SizeBuildItem extends StatelessWidget {
  const SizeBuildItem({
    Key? key,
    required this.title,
    required this.value,
    required this.price,
  }) : super(key: key);

  final String title;
  final String value;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: thirdTextStyle()
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.black54),
            ),
          ),
          Expanded(child: Text(value)),
          Text(price),
        ],
      ),
    );
  }
}
