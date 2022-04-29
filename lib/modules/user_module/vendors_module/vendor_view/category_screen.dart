import 'dart:developer';

import 'package:emdad/models/products_and_categories/category_model.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_cubit.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_states.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/default_search_field.dart';
import 'package:emdad/shared/widgets/load_more_data.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'vendor_view_componants/product_card_build_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    Key? key,
    required this.title,
    this.categoryName,
  }) : super(key: key);

  final String title;
  final String?
      categoryName; //If null that mean i get all products for that vendor
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() {
    VendorProfileCubit.instance(context).getCategoryProducts(
      category: widget.categoryName,
    );
  }

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: VendorProfileBlocBuilder(
        builder: (context, state) {
          final vendorProfileCubit = VendorProfileCubit.instance(context);
          // log(vendorProfileCubit
          //     .lastProductsPage(widget.categoryModel.category)
          //     .toString());
          if (state is GetCategoryProductsLoadingState) {
            return const DefaultLoader();
          }
          if (state is GetCategoryProductsErrorState) {
            return NoDataWidget(onPressed: () {
              getProducts();
            });
          }
          final products = vendorProfileCubit.allProducts;
          log(products.length.toString());
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DefaultSearchField(
                    searchController: searchController,
                    // hasFilter: false,
                  ),
                ),
                GridView.builder(
                  itemCount: products.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1 / 2,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) => ProductCardBuildItem(
                    product: products[index],
                  ),
                ),
                LoadMoreData(
                  visible: !vendorProfileCubit.isLastProductPage,
                  isLoading: state is GetMoreCategoryProductsLoadingState,
                  onLoadingMore: () {
                    vendorProfileCubit.getMoreCategoryProducts(
                        category: widget.categoryName);
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
