import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/modules/user_module/offers_module/offers_cubit/offers_cubit.dart';
import 'package:flutter/material.dart';

import 'orders_build_item.dart';

class MyOrdersTab extends StatelessWidget {
  const MyOrdersTab({Key? key, required this.status, required this.onTap})
      : super(key: key);

  final OrderStatus status;
  final void Function(String orderId) onTap;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: OffersCubit.instance(context).offers.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) => OrderBuildItem(
        order: OffersCubit.instance(context).offers[index], //Replace it
        hasBadge: false,
        title: 'الهدى للتوريدات الغذائية',
        image:
            'https://upload.wikimedia.org/wikipedia/sco/thumb/b/bf/KFC_logo.svg/1200px-KFC_logo.svg.png',
        onTap: () => onTap(OffersCubit.instance(context).offers[index].id),
        // onTap: () {
        //   navigateTo(
        //       context,
        //       OrderViewScreen(
        //         title: 'طلب مكتمل',
        //         status: status,
        //       ));
        // },
      ),
    );
  }
}
