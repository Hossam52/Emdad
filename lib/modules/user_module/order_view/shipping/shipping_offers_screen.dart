import 'dart:developer';

import 'package:emdad/common_cubits/filter_supply_requests_cubit/filter_supply_requests_cubit.dart';
import 'package:emdad/modules/user_module/my_orders/orders_build_item.dart';
import 'package:emdad/modules/user_module/offers_module/title_with_filter_build_item.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_cubit.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_offer_details.dart';
import 'package:emdad/modules/user_module/order_view/shipping/user_shipping_offers_cubit/user_shipping_offers_cubit.dart';
import 'package:emdad/modules/user_module/order_view/shipping/user_shipping_offers_cubit/user_shipping_offers_states.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/empty_data.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingOffersScreen extends StatelessWidget {
  const ShippingOffersScreen(
      {Key? key,
      required this.transportationRequestId,
      required this.orderCubit})
      : super(key: key);
  final String transportationRequestId;
  final OrderCubit orderCubit;
  @override
  Widget build(BuildContext context) {
    log(transportationRequestId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('عروض التوصيل'),
        actions: const [ChangeLangWidget(color: Colors.black)],
      ),
      body: BlocProvider(
        create: (context) => UserShippingOffersCubit(transportationRequestId)
          ..getVendorTransportationOffers(),
        child: UserShippingOffersBlocConsumer(
          listener: (context, state) {
            if (state is AcceptUserTransportationOfferSuccessState) {
              Navigator.pop(context); //For offer details
              Navigator.pop(context); //For this screen
              orderCubit.getOrder();
            }
            if (state is AcceptUserTransportationOfferErrorState) {
              SharedMethods.showToast(context, state.error,
                  color: AppColors.errorColor, textColor: Colors.white);
            }
          },
          builder: (context, state) {
            final offersCubit = UserShippingOffersCubit.instance(context);
            if (state is GetUserTransportationOffersLoadingState) {
              return const DefaultLoader();
            }
            if (state is GetUserTransportationOffersErrorState) {
              return NoDataWidget(
                  onPressed: () {
                    offersCubit.getVendorTransportationOffers();
                  },
                  text: state.error);
            }
            final offers = offersCubit.offers;
            if (offersCubit.errorInOffers || offers.isEmpty) {
              return const EmptyData(
                emptyText: 'لا يوجد عروض توصيل',
              );
            }
            return BlocProvider(
              create: (context) =>
                  FilterSuuplyRequestsCubit.transportationOffers(offers),
              child: FilterSuuplyRequestsBlocBuilder(
                builder: (context, state) {
                  final offers = FilterSuuplyRequestsCubit.instance(context)
                      .transportationOffers;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        TitleWithFilterBuildItem(
                          title: 'عروض التوصيل',
                          filterCubit:
                              FilterSuuplyRequestsCubit.instance(context),
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
            );
          },
        ),
      ),
    );
  }
  // ({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('عروض التوصيل'),
  //       actions: const [ChangeLangWidget(color: Colors.black)],
  //     ),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           TitleWithFilterBuildItem(
  //             title: 'عروض التوصيل',
  //             changeSortType: (sortType) {},
  //             hasSort: false,
  //           ),
  //           ListView.builder(
  //             itemCount: 5,
  //             shrinkWrap: true,
  //             padding: const EdgeInsets.all(16),
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemBuilder: (context, index) => OrderBuildItem(
  //               // order: VendorOffersCubit.instance(context)
  //               //     .offers
  //               //     .first, //Replace it
  //               title: 'Remove this',
  //               date: '2022-05-08',
  //               image: '',
  //               hasBadge: false,
  //               trailing: const Text('عربه نصف نقل'),
  //               onTap: () {
  //                 navigateTo(context, ShippingOfferDetails(
  //                   onAcceptOffer: () {
  //                     navigateTo(
  //                       context,
  //                       CheckoutScreen(onConfirmPressed: () {
  //                         navigateTo(
  //                             context,
  //                             const OrderInPorgressScreen(
  //                               orderId: 'order', //Modify it
  //                               status: OrderStatus.inProgress,
  //                               title: 'عرض سعر جديد',
  //                             ));
  //                       }),
  //                     );
  //                   },
  //                 ));
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
