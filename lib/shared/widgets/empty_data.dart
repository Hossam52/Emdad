import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({Key? key, this.emptyText}) : super(key: key);
  final String? emptyText;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(emptyText ?? 'No data available'),
    );
  }
}
