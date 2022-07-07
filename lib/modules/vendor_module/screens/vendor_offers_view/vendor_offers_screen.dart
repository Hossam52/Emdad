import 'dart:developer';

import 'package:emdad/common_cubits/filter_supply_requests_cubit/filter_supply_requests_cubit.dart';
import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/modules/user_module/my_orders/orders_build_item.dart';
import 'package:emdad/modules/user_module/offers_module/offers_cubit/offers_cubit.dart';
import 'package:emdad/modules/user_module/offers_module/title_with_filter_build_item.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_offers_view/vendor_offers_cubit/vendor_offers_cubit.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_offers_view/vendor_offers_cubit/vendor_offers_states.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/vendor_orders_details_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/widgets/custom_refresh_widget.dart';
import 'package:emdad/shared/widgets/empty_data.dart';
import 'package:emdad/shared/widgets/load_more_data.dart';
import 'package:emdad/shared/widgets/ui_componants/default_loader.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VendorOffersScreen extends StatelessWidget {
  VendorOffersScreen({Key? key}) : super(key: key);
  final _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return CustomRefreshWidget(
      onRefresh: () async {
        return VendorOffersCubit.instance(context).getVendorOffers();
      },
      child: VendorOffersBlocConsumer(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetVendorOffersLoadingState) {
            return const DefaultLoader();
          }
          final vendorOffersCubit = VendorOffersCubit.instance(context);
          if (state is GetVendorOffersErrorState) {
            return NoDataWidget(
              onPressed: () {
                vendorOffersCubit.getVendorOffers();
              },
              text: state.error,
            );
          }

          if (vendorOffersCubit.hasErrorOnLoadOffers) {
            return NoDataWidget(onPressed: () {
              vendorOffersCubit.getVendorOffers();
            });
          }
          final offers = vendorOffersCubit.offers;
          return BlocProvider(
            create: (_) => FilterSuuplyRequestsCubit(offers),
            child: FilterSuuplyRequestsBlocBuilder(builder: (context, _) {
              final offers =
                  FilterSuuplyRequestsCubit.instance(context).supplyRequests;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TitleWithFilterBuildItem(
                      title: 'طلبات عروض سعر',
                      filterCubit: FilterSuuplyRequestsCubit.instance(context),
                      changeSortType:
                          FilterSuuplyRequestsCubit.instance(context)
                              .changeSortType,
                      hasSort:
                          FilterSuuplyRequestsCubit.instance(context).notSort,
                    ),
                    if (offers.isEmpty)
                      const EmptyData(emptyText: 'لا يوجد طلبات')
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: offers.length,
                        itemBuilder: (context, index) => OrderBuildItem(
                          // order: orders[index],
                          title: offers[index].id,
                          subTitleText: offers[index].orderItemsString,

                          date: offers[index].createdAt,
                          image: offers[index].user.logoUrl,
                          hasBadge: false,
                          onTap: () async {
                            final refreshPage = await navigateTo(
                                context,
                                VendorOrderDetailsScreen(
                                  title: 'طلب عرض سعر',
                                  orderId: offers[index].id,
                                ));
                            log(refreshPage.toString());
                            if (refreshPage != null && refreshPage) {
                              vendorOffersCubit.getVendorOffers();
                            }
                          },
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 50.h),
                      child: LoadMoreData(
                        isLoading: state is GetMoreVendorOffersLoadingState,
                        visible: !vendorOffersCubit.isLastPage,
                        onLoadingMore: () {
                          vendorOffersCubit.getMoreVendorOffers();
                        },
                      ),
                    )
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
