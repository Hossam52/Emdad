import 'package:emdad/common_cubits/filter_supply_requests_cubit/filter_supply_requests_cubit.dart';
import 'package:emdad/modules/transporter_module/screens/transporter_offers_view/transporter_offer_details_screen.dart';
import 'package:emdad/modules/transporter_module/transporter_cubits/transporter_offers_cubit/transporter_offers_cubit.dart';
import 'package:emdad/modules/transporter_module/transporter_cubits/transporter_offers_cubit/transporter_offers_states.dart';
import 'package:emdad/modules/transporter_module/transporter_widgets/transporter_order_item_preview.dart';
import 'package:emdad/modules/user_module/offers_module/title_with_filter_build_item.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/responsive/responsive_widget.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/custom_refresh_widget.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/empty_data.dart';
import 'package:emdad/shared/widgets/load_more_data.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransporterOffersScreen extends StatelessWidget {
  const TransporterOffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransporterOffersBlocConsumer(
      listener: (context, state) {},
      builder: (context, state) {
        final transporterCubit = TransporterOffersCubit.instance(context);
        if (state is GetOffersLoadingState) return const DefaultLoader();
        if (state is GetOffersErrorState) {
          return NoDataWidget(
            onPressed: () {
              transporterCubit.getOffers();
            },
            text: state.error,
          );
        }

        if (transporterCubit.errorOffers) {
          return NoDataWidget(
            onPressed: () {
              transporterCubit.getOffers();
            },
            text: context.tr.error_happened_retry_again,
          );
        }
        final offers = transporterCubit.offers;
        return CustomRefreshWidget(
          onRefresh: () async {
            await transporterCubit.getOffers();
          },
          child: responsiveWidget(
            responsive: (_, deviceInfo) => BlocProvider(
              create: (context) =>
                  FilterSuuplyRequestsCubit.transporterOrders(offers),
              child: FilterSuuplyRequestsBlocBuilder(builder: (context, _) {
                final offers = FilterSuuplyRequestsCubit.instance(context)
                    .transporterSupplyRequests;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      TitleWithFilterBuildItem(
                        title: context.tr.price_offers,
                        filterCubit:
                            FilterSuuplyRequestsCubit.instance(context),
                        changeSortType: (sortType) {},
                        hasSort: false,
                      ),
                      if (offers.isEmpty)
                        Center(
                            child: EmptyData(
                                emptyText: context.tr.no_price_offers))
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16),
                          itemCount: offers.length,
                          itemBuilder: (context, index) {
                            final offer = offers[index];
                            return TransporterOrderItemPreview(
                              order: offer,
                              onTap: () {
                                navigateTo(
                                    context,
                                    TransporterOfferDetailsScreen(
                                      transportId: offer.id,
                                    ));
                              },
                            );
                          },
                        ),
                      LoadMoreData(
                        onLoadingMore: () {
                          transporterCubit.getMoreOffers();
                        },
                        isLoading: state is GetMoreOffersLoadingState,
                        visible: !transporterCubit.isLastPage,
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
