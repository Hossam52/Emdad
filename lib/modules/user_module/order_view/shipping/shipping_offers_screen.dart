import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/checkout/checkout_screen.dart';
import 'package:emdad/modules/user_module/my_orders/orders_build_item.dart';
import 'package:emdad/modules/user_module/offers_module/title_with_filter_build_item.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/order_in_progress_screen.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_offer_details.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_offers_view/vendor_offers_cubit/vendor_offers_cubit.dart';
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
            TitleWithFilterBuildItem(
              title: 'عروض التوصيل',
              changeSortType: (sortType) {},
              hasSort: false,
            ),
            ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => OrderBuildItem(
                // order: VendorOffersCubit.instance(context)
                //     .offers
                //     .first, //Replace it
                title: 'Remove this',
                date: '2022-05-08',
                image: '',
                hasBadge: false,
                trailing: const Text('عربه نصف نقل'),
                onTap: () {
                  navigateTo(context, ShippingOfferDetails(
                    onAcceptOffer: () {
                      navigateTo(
                        context,
                        CheckoutScreen(onConfirmPressed: () {
                          navigateTo(
                              context,
                              const OrderInPorgressScreen(
                                orderId: 'order', //Modify it
                                status: OrderStatus.inProgress,
                                title: 'عرض سعر جديد',
                              ));
                        }),
                      );
                    },
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
