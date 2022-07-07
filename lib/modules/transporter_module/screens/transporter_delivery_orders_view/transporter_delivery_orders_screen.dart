import 'package:emdad/common_cubits/filter_supply_requests_cubit/filter_supply_requests_cubit.dart';
import 'package:emdad/modules/transporter_module/screens/transporter_delivery_orders_view/transporter_order_details.dart';
import 'package:emdad/modules/transporter_module/screens/transporter_offers_view/transporter_offers_screen.dart';
import 'package:emdad/modules/transporter_module/transporter_cubits/transporter_offers_cubit/transporter_offers_cubit.dart';
import 'package:emdad/modules/transporter_module/transporter_cubits/transporter_purchase_orders_cubit/transporter_dlivery_orders_cubit.dart';
import 'package:emdad/modules/transporter_module/transporter_cubits/transporter_purchase_orders_cubit/transporter_dlivery_orders_states.dart';
import 'package:emdad/modules/transporter_module/transporter_widgets/transporter_order_item_preview.dart';
import 'package:emdad/modules/user_module/my_orders/orders_build_item.dart';
import 'package:emdad/modules/user_module/offers_module/title_with_filter_build_item.dart';
import 'package:emdad/modules/user_module/order_view/order_view_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/responsive/responsive_widget.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/empty_data.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransporterDeliveryOrdersScreen extends StatelessWidget {
  const TransporterDeliveryOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransporterDeliveryOrdersBlocBuilder(
      builder: (context, state) {
        final deliveryOrdersCubit =
            TransporterDeliveryOrdersCubit.instance(context);
        if (state is GetDeliveryOrdersLoadingState)
          return const DefaultLoader();
        if (state is GetDeliveryOrdersErrorState) {
          return NoDataWidget(
            onPressed: () {
              deliveryOrdersCubit.getDeliveryOrders();
            },
            text: state.error,
          );
        }

        if (deliveryOrdersCubit.errorOrders) {
          return NoDataWidget(
            onPressed: () {
              deliveryOrdersCubit.getDeliveryOrders();
            },
            text: context.tr.error_happened_retry_again,
          );
        }
        final orders = deliveryOrdersCubit.orders;
        return responsiveWidget(
          responsive: (_, deviceInfo) => BlocProvider(
            create: (context) =>
                FilterSuuplyRequestsCubit.transporterOrders(orders),
            child: FilterSuuplyRequestsBlocBuilder(
              builder: (context, _) {
                final orders = FilterSuuplyRequestsCubit.instance(context)
                    .transporterSupplyRequests;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      TitleWithFilterBuildItem(
                        title: context.tr.delivery_orders,
                        filterCubit:
                            FilterSuuplyRequestsCubit.instance(context),
                        changeSortType: (sortType) {},
                        hasSort: false,
                      ),
                      if (orders.isEmpty)
                        EmptyData(emptyText: context.tr.no_delivery_orders)
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16),
                          itemCount: orders.length,
                          itemBuilder: (context, index) =>
                              TransporterOrderItemPreview(
                            order: orders[index],
                            onTap: () {
                              navigateTo(
                                  context,
                                  TransporterOrderDetailsScreen(
                                    transportId: orders[index].id,
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
      },
    );
  }
}
