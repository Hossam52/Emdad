import 'package:emdad/shared/styles/app_theme.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class ProductCustomTile extends StatelessWidget {
  const ProductCustomTile({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.lightTheme.copyWith(dividerColor: Colors.white),
      child: ListTileTheme(
        tileColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ExpansionTile(
          title: Text(title,
              style:
                  secondaryTextStyle().copyWith(fontWeight: FontWeight.w600)),
          initiallyExpanded: true,
          textColor: Colors.black,
          iconColor: Colors.black,
          childrenPadding: const EdgeInsets.all(12),
          children: children,
        ),
      ),
    );
  }
}
