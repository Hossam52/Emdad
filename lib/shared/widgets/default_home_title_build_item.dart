import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class DefaultHomeTitleBuildItem extends StatelessWidget {
  const DefaultHomeTitleBuildItem({
    Key? key,
    required this.title,
    required this.onPressed,
    this.hasButton = true,
  }) : super(key: key);

  final String title;
  final Function() onPressed;
  final bool hasButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: secondaryTextStyle().copyWith(fontWeight: FontWeight.w600),
          )),
          if (hasButton)
            TextButton(
              onPressed: onPressed,
              child: Text('إظهار الكل',
                  style: subTextStyle().copyWith(
                    color: Colors.black54,
                    decoration: TextDecoration.underline,
                  )),
            ),
        ],
      ),
    );
  }
}
