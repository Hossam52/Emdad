import 'package:emdad/modules/user_module/vendors_module/product_details/product_details_screen.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/cart_cubit/cart_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_componants/product_card_build_item.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/products_cubit/vendor_product_cubit.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/products_cubit/vendor_product_states.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/default_search_field.dart';
import 'package:emdad/shared/widgets/load_more_data.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorProductsScreen extends StatefulWidget {
  const VendorProductsScreen({Key? key}) : super(key: key);

  @override
  State<VendorProductsScreen> createState() => _VendorProductsScreenState();
}

class _VendorProductsScreenState extends State<VendorProductsScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final vendorProductsCubit = VendorProductsCubit.instance(context);
    if (vendorProductsCubit.isAllProductsNotLoaded) {
      vendorProductsCubit.getAllVendorProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DefaultSearchField(
                  searchController: searchController,
                  onChanged:
                      VendorProductsCubit.instance(context).onQueryChange,
                ),
              ),
              VendorProductsBlocBuilder(
                builder: (context, state) {
                  final vendorProductsCubit =
                      VendorProductsCubit.instance(context);
                  if (state is GetAllVendorProductsLoadingState) {
                    return const DefaultLoader();
                  }
                  if (state is GetAllVendorProductsErrorState) {
                    return NoDataWidget(onPressed: () {
                      vendorProductsCubit.getAllVendorProducts();
                    });
                  }
                  if (vendorProductsCubit.isAllProductsNotLoaded) {
                    return NoDataWidget(onPressed: () {
                      vendorProductsCubit.getAllVendorProducts();
                    });
                  }
                  final products = vendorProductsCubit.products;
                  return GridView.builder(
                    itemCount: products.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1 / 2,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) => ProductCardBuildItem(
                      product: products[index],
                      isVendor: true,
                      onProductTapped: () {
                        navigateTo(
                          context,
                          ProductDetailsScreen(
                              productId: products[index].id, isVendor: true),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          VendorProductsBlocBuilder(
            builder: (context, state) {
              final vendorProductsCubit = VendorProductsCubit.instance(context);
              return LoadMoreData(
                  isLoading: state is GetMoreMyProductsLoadingState,
                  visible: !vendorProductsCubit.isLastMyProductsPage,
                  onLoadingMore: () {
                    vendorProductsCubit.getMoreMyProducts();
                  });
            },
          ),
          SizedBox(
            height: 0.06.sh,
          )
        ]),
      ),
    );
  }
}
