import 'package:emdad/modules/user_module/my_orders/orders_build_item.dart';
import 'package:emdad/modules/user_module/offers_module/title_with_filter_build_item.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_offer_details.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:flutter/material.dart';

class ShippingOffersScreen extends StatelessWidget {
  const ShippingOffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عروض التوصيل'),
        actions: const [ChangeLangWidget(color: Colors.black)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TitleWithFilterBuildItem(title: 'عروض التوصيل'),
            ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => OrderBuildItem(
                title: 'شركه النور للنقل',
                image:
                    'https://media-exp1.licdn.com/dms/image/C4E0BAQG6W8dqXakgSg/company-logo_200_200/0/1519911646250?e=1643241600&v=beta&t=PnYJyb4ht9NLo9zL3t6KZr8ngN0no6smC7abRaiCFBs',
                hasBadge: false,
                trailing: const Text('عربه نصف نقل'),
                onTap: () {
                  navigateTo(context, const ShippingOfferDetails());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
