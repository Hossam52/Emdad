import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class CustomDataTable extends StatelessWidget {
  const CustomDataTable({
    Key? key,
    required this.columns,
    required this.rows,
    required this.columnSpacing,
    this.headingRowColor = Colors.white,
    this.dataRowColor = Colors.white,
    this.headingTextColor = Colors.black,
    this.dataTextColor = Colors.black,
  }) : super(key: key);

  final List<String> columns;
  final List<String> rows;
  final double columnSpacing;
  final Color headingRowColor;
  final Color dataRowColor;
  final Color headingTextColor;
  final Color dataTextColor;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columns.map((item) => DataColumn(label: Text(item))).toList(),
      rows: <DataRow>[
        DataRow(cells: rows.map((item) => DataCell(Text(item))).toList())
      ],
      columnSpacing: columnSpacing,
      headingRowColor: MaterialStateProperty.all<Color>(headingRowColor),
      dataRowColor: MaterialStateProperty.all<Color>(dataRowColor),
      headingTextStyle: subTextStyle().copyWith(color: headingTextColor),
      dataTextStyle: subTextStyle().copyWith(color: dataTextColor),
    );
  }
}
