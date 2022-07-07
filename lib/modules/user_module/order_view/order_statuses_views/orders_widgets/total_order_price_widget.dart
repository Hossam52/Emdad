import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_total_overview_price.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_total_row_item.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:flutter/material.dart';

class TotalOrderPrice extends StatelessWidget {
  const TotalOrderPrice({Key? key, required this.order}) : super(key: key);
  final SupplyRequest order;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultHomeTitleBuildItem(
          title: context.tr.total,
          onPressed: () {},
          hasButton: false,
        ),
        OrderTotalOverviewPrice(
          children: [
            OrderTotalRowItem(title: context.tr.tax, value: '١٢٪'),
            const SizedBox(height: 10),
            OrderTotalRowItem(
                title: context.tr.net_price,
                value: !order.vendorProvidePriceOffer
                    ? context.tr.price_not_defined
                    : order.totalOrderPrice.toInt().toString()),
            const SizedBox(height: 10),
            if (order.hasTransportation)
              OrderTotalRowItem(
                  title: context.tr.shipping,
                  value: SharedMethods.getPrice(order.transportationPrice)),
            const SizedBox(height: 10),
            const Divider(),
            OrderTotalRowItem(
                title: context.tr.total,
                value: !order.vendorProvidePriceOffer
                    ? context.tr.price_not_defined
                    : (order.totalOrderPrice + order.totalOrderPrice * 0.12)
                        .toString()),
          ],
        )
      ],
    );
  }
}
