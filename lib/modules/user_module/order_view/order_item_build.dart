import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_data_table.dart';

class OrderItemBuild extends StatelessWidget {
  const OrderItemBuild({
    Key? key,
    required this.columns,
    required this.rows,
    this.radius = 10,
    this.hasTotal = true,
  }) : super(key: key);

  final List<String> columns;
  final List<String> rows;
  final double radius;
  final bool hasTotal;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 3,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: CustomDataTable(
                columns: columns,
                rows: rows,
                columnSpacing: 5.w,
                headingRowColor: Colors.grey.withOpacity(0.2),
                headingTextColor: AppColors.primaryColor,
                dataTextColor: Colors.black,
              ),
            ),
            if (hasTotal)
              Container(
                color: Colors.grey,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'إجمالي',
                      style: subTextStyle().copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '١٨٠٠ ر.س',
                      style: subTextStyle().copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
