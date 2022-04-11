import 'package:emdad/modules/transporter_module/screens/transporter_delivery_orders_view/transporter_order_details.dart';
import 'package:emdad/modules/transporter_module/screens/transporter_offers_view/transporter_offers_screen.dart';
import 'package:emdad/modules/user_module/my_orders/orders_build_item.dart';
import 'package:emdad/modules/user_module/offers_module/title_with_filter_build_item.dart';
import 'package:emdad/modules/user_module/order_view/order_view_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';

class TransporterDeliveryOrdersScreen extends StatelessWidget {
  const TransporterDeliveryOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return responsiveWidget(
      responsive: (context, deviceInfo) => SingleChildScrollView(
        child: Column(
          children: [
            const TitleWithFilterBuildItem(title: 'عروض اسعار'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              itemBuilder: (context, index) => OrderBuildItem1(
                title: 'الرحمة للمأكولات',
                image: 'https://upload.wikimedia.org/wikipedia/sco/thumb/b/bf/KFC_logo.svg/1200px-KFC_logo.svg.png',
                hasBadge: true,
                onTap: () {
                  navigateTo(context, TransporterOrderDetailsScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
