import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/modules/user_module/order_view/order_view_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:flutter/material.dart';

import 'orders_build_item.dart';

class MyOrdersTab extends StatelessWidget {
  const MyOrdersTab({Key? key, required this.status}) : super(key: key);

  final OrderStatus status;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) => OrderBuildItem(
        order: VendorCubit.instance(context)
            .allVendorRequests!
            .supplyRequests
            .first, //Replace it
        hasBadge: false,
        title: 'الهدى للتوريدات الغذائية',
        image:
            'https://upload.wikimedia.org/wikipedia/sco/thumb/b/bf/KFC_logo.svg/1200px-KFC_logo.svg.png',
        onTap: () {
          navigateTo(
              context,
              OrderViewScreen(
                title: 'طلب مكتمل',
                status: status,
              ));
        },
      ),
    );
  }
}
