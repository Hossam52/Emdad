import 'package:flutter/material.dart';

class OrderTotalOverviewPrice extends StatelessWidget {
  const OrderTotalOverviewPrice({Key? key, this.children = const []})
      : super(key: key);
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.grey[100],
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: children),
      ),
    );
  }
}
