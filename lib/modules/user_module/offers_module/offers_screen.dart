import 'dart:developer';

import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/my_orders/orders_build_item.dart';
import 'package:emdad/modules/user_module/offers_module/offers_cubit/offers_cubit.dart';
import 'package:emdad/modules/user_module/offers_module/offers_cubit/offers_states.dart';
import 'package:emdad/modules/user_module/offers_module/title_with_filter_build_item.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/order_offer_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_view_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/responsive/responsive_widget.dart';
import 'package:emdad/shared/widgets/custom_refresh_widget.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/load_more_data.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OffersScreen extends StatelessWidget {
  OffersScreen({Key? key}) : super(key: key);
  final _controller = RefreshController();
  @override
  Widget build(BuildContext context) {
    return CustomRefreshWidget(
      onRefresh: () async {
        await OffersCubit.instance(context).getRequestOffers();
        _controller.refreshCompleted();
      },
      child: OffersBlocBuilder(
        builder: (context, state) {
          final offersCubit = OffersCubit.instance(context);
          if (state is GetRequestOffersLoadingState) {
            return const DefaultLoader();
          } else if (state is GetRequestOffersErrorState) {
            return NoDataWidget(
                onPressed: () {
                  offersCubit.getRequestOffers();
                },
                text: state.error);
          }
          if (offersCubit.emptyOffers) return NoDataWidget(onPressed: () {});
          final offers = offersCubit.offers;
          return responsiveWidget(
            responsive: (context, deviceInfo) => SingleChildScrollView(
              child: Column(
                children: [
                  TitleWithFilterBuildItem(
                    title: 'عروض اسعار',
                    changeSortType: offersCubit.changeSortType,
                    hasSort: offersCubit.notSort,
                  ),
                  ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: offers.length,
                    itemBuilder: (context, index) {
                      return OrderBuildItem(
                        order: offers[index],
                        hasBadge: true,
                        onTap: () async {
                          final mustReloadData = await navigateTo(
                              context,
                              OrderOfferScreen(
                                  orderId: offersCubit.offers[index].id,
                                  title: 'عرض سعر جديد',
                                  status: OrderStatus.offer));
                          if (mustReloadData != null && mustReloadData) {
                            offersCubit.getRequestOffers();
                          }
                        },
                      );
                    },
                  ),
                  LoadMoreData(
                      visible: offersCubit.canLoadMoreOffers,
                      isLoading: state is GetMoreRequestOffersLoadingState,
                      onLoadingMore: () {
                        offersCubit.getMoreRequestOffers();
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
