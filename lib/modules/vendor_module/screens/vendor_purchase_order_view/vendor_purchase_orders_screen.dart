import 'package:emdad/common_cubits/filter_supply_requests_cubit/filter_supply_requests_cubit.dart';
import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/my_orders/orders_build_item.dart';
import 'package:emdad/modules/user_module/offers_module/title_with_filter_build_item.dart';
import 'package:emdad/modules/user_module/order_view/order_view_screen.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_offers_view/vendor_offers_cubit/vendor_offers_cubit.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/vendor_orders_details_screen.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/vendor_purchase_order_details_screen.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/purchase_orders_cubit/purchase_orders_cubit.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/purchase_orders_cubit/purchase_orders_states.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/widgets/custom_refresh_widget.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/empty_data.dart';
import 'package:emdad/shared/widgets/load_more_data.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorPurchaseOrdersScreen extends StatelessWidget {
  const VendorPurchaseOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PurchaseOrdersBlocBuilder(
      builder: (context, state) {
        final purchaseOrdersCubit = PurchaseOrdersCubit.instance(context);
        if (state is GetPurchaseOrdersLoadingState) {
          return const DefaultLoader();
        }
        if (state is GetPurchaseOrdersErrorState) {
          return NoDataWidget(
              onPressed: () {
                purchaseOrdersCubit.getPurchaseOrders();
              },
              text: state.error);
        }

        if (purchaseOrdersCubit.errorInOrders) {
          return NoDataWidget(
              onPressed: () {
                purchaseOrdersCubit.getPurchaseOrders();
              },
              text: 'حدث خطأ اعد المحاولة');
        }
        final orders = purchaseOrdersCubit.orders;
        return BlocProvider(
          create: (_) => FilterSuuplyRequestsCubit(orders),
          child: FilterSuuplyRequestsBlocBuilder(
            builder: (context, _) {
              final orders =
                  FilterSuuplyRequestsCubit.instance(context).supplyRequests;
              return CustomRefreshWidget(
                onRefresh: () {
                  return PurchaseOrdersCubit.instance(context)
                      .getPurchaseOrders();
                },
                child: ListView(
                  primary: false,
                  children: [
                    TitleWithFilterBuildItem(
                      filterCubit: FilterSuuplyRequestsCubit.instance(context),
                      title: 'اوامر الشراء',
                      changeSortType: (sortType) {},
                      hasSort: false,
                    ),
                    if (orders.isEmpty)
                      const EmptyData(emptyText: 'لا يوجد اوامر شراء')
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        padding: const EdgeInsets.all(16),
                        itemCount: orders.length,
                        itemBuilder: (context, index) => OrderBuildItem(
                          // order: orders[index],
                          title: orders[index].id,
                          subTitleText: orders[index].orderItemsString,

                          date: orders[index].createdAt,
                          image: orders[index].user.logoUrl,
                          hasBadge: false,
                          onTap: () {
                            navigateTo(
                                context,
                                VendorPurchaseOrderDetailsScreen(
                                  orderId: orders[index].id,
                                ));
                          },
                        ),
                      ),
                    LoadMoreData(
                        isLoading: state is GetMorePurchaseOrdersLoadingState,
                        visible: !purchaseOrdersCubit.isLastPage,
                        onLoadingMore: () {
                          purchaseOrdersCubit.getMorePurchaseOrders();
                        }),
                    SizedBox(height: 30.h),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
