import 'dart:developer';

import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/checkout/checkout_screen.dart';
import 'package:emdad/modules/user_module/my_orders/orders_build_item.dart';
import 'package:emdad/modules/user_module/offers_module/title_with_filter_build_item.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/order_in_progress_screen.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_offer_details.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/vendor_order_cubit/vendor_order_cubit.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/vendor_shipping_offers_cubit/vendor_shipping_offers_cubit.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/vendor_shipping_offers_cubit/vendor_shipping_offers_states.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/empty_data.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class VendorShippingOffersScreen extends StatelessWidget {
  const VendorShippingOffersScreen(
      {Key? key,
      required this.transportationRequestId,
      required this.orderCubit})
      : super(key: key);
  final String transportationRequestId;
  final VendorOrderCubit orderCubit;
  @override
  Widget build(BuildContext context) {
    log(transportationRequestId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('عروض التوصيل'),
        actions: const [ChangeLangWidget(color: Colors.black)],
      ),
      body: BlocProvider(
        create: (context) => VendorShippingOffersCubit(transportationRequestId)
          ..getVendorTransportationOffers(),
        child: VendorShippingOffersBlocConsumer(
          listener: (context, state) {
            if (state is AcceptTransportationOfferSuccessState) {
              Navigator.pop(context); //For offer details
              Navigator.pop(context); //For this screen
              orderCubit.getOrder();
            }
            if (state is AcceptTransportationOfferErrorState) {
              SharedMethods.showToast(context, state.error,
                  color: AppColors.errorColor, textColor: Colors.white);
            }
          },
          builder: (context, state) {
            final offersCubit = VendorShippingOffersCubit.instance(context);
            if (state is GetVendorTransportationOffersLoadingState) {
              return const DefaultLoader();
            }
            if (state is GetVendorTransportationOffersErrorState) {
              return NoDataWidget(
                  onPressed: () {
                    offersCubit.getVendorTransportationOffers();
                  },
                  text: state.error);
            }
            final offers = offersCubit.offers;
            if (offersCubit.errorInOffers || offers.isEmpty) {
              return const EmptyData(
                emptyText: 'لا يوجد عروض توصيل حتي الان',
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  TitleWithFilterBuildItem(
                    title: 'عروض التوصيل',
                    changeSortType: (sortType) {},
                    hasSort: false,
                  ),
                  ListView.builder(
                    itemCount: offers.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => OrderBuildItem(
                      // order: VendorOffersCubit.instance(context)
                      //     .offers
                      //     .first, //Replace it
                      title: offers[index].transporter.oraganizationName,
                      date: offers[index].updatedAt,
                      image: offers[index].transporter.logo,
                      hasBadge: false,
                      trailing: Text(offers[index]
                          .transportationRequest
                          .transportationMethod),
                      onTap: () {
                        navigateTo(context, Material(
                          child: Builder(builder: (context) {
                            return ShippingOfferDetails(
                              transportationOffer: offers[index],
                              onAcceptOffer: () {
                                offersCubit.acceptTransportationOffer(
                                    context, offers[index].id);
                              },
                            );
                          }),
                        ));
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
