import 'package:emdad/modules/user_module/order_view/order_item_build.dart';
import 'package:flutter/material.dart';

class AllOrdersListView extends StatelessWidget {
  const AllOrdersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) => const OrderItemBuild(
        columns: ['صنف', 'كمية', 'وحدة', 'سعر', 'ضريبة'],
        rows: ['طماطم', '3', 'طن', '١٥٠٠ ر.س', '١٢٪'],
      ),
    );
  }
}
