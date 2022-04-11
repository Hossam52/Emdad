import 'package:emdad/modules/user_module/order_view/order_item_build.dart';
import 'package:flutter/material.dart';

class OrderOutOfProducts extends StatelessWidget {
  const OrderOutOfProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 2,
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) => const OrderItemBuild(
        columns: ['الوصف', 'سعر', 'ضريبة'],
        rows: ['٤ كرتونه كاتشب', '١٥٠٠ ر.س', '١٢٪'],
        radius: 3,
      ),
    );
  }
}
