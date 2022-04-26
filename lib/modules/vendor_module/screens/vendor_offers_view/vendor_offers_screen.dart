import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/modules/user_module/my_orders/orders_build_item.dart';
import 'package:emdad/modules/user_module/offers_module/title_with_filter_build_item.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/vendor_orders_details_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/widgets/ui_componants/default_loader.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';

class VendorOffersScreen extends StatefulWidget {
  const VendorOffersScreen({Key? key}) : super(key: key);

  @override
  State<VendorOffersScreen> createState() => _VendorOffersScreenState();
}

class _VendorOffersScreenState extends State<VendorOffersScreen> {
  @override
  void initState() {
    super.initState();

    VendorCubit.instance(context).getAllSupplyRequests();
  }

  @override
  Widget build(BuildContext context) {
    return VendorBlocConsumer(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetAllSuplyRequestsLoadingState)
          return const DefaultLoader();

        final vendorCubit = VendorCubit.instance(context);
        if (vendorCubit.allVendorRequests == null ||
            vendorCubit.allVendorRequests!.supplyRequests.isEmpty) {
          return NoDataWidget(onPressed: () {
            vendorCubit.getAllSupplyRequests();
          });
        }
        final requests = vendorCubit.allVendorRequests!.supplyRequests;
        return SingleChildScrollView(
          child: Column(
            children: [
              const TitleWithFilterBuildItem(title: 'طلبات عروض سعر'),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: requests.length,
                itemBuilder: (context, index) => OrderBuildItem(
                  order: requests[index],
                  hasBadge: false,
                  onTap: () {
                    navigateTo(
                        context,
                        const VendorOrderDetailsScreen(
                          title: 'طلب عرض سعر',
                        ));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
