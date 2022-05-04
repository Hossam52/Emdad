import 'dart:developer';

import 'package:emdad/models/products_and_categories/category_model.dart';
import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_cubit.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_states.dart';
import 'package:emdad/modules/user_module/vendors_module/product_details/product_details_screen.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/cart_cubit/cart_cubit.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/default_search_field.dart';
import 'package:emdad/shared/widgets/dialogs/add_to_price_request_dialog.dart';
import 'package:emdad/shared/widgets/load_more_data.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    trailing: _CartIcon(
                      product: products[index],
                    ),
                    onProductTapped: () {
                      navigateTo(
                          context,
                          BlocProvider.value(
                            value: CartCubit.instance(context),
                            child: ProductDetailsScreen(
                                productId: products[index].id, isVendor: false),
                          ));
                    },
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

class _CartIcon extends StatelessWidget {
  const _CartIcon({Key? key, required this.product}) : super(key: key);
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return CartBlocBuilder(
      builder: (context, state) {
        final cartCubit = CartCubit.instance(context);
        if (cartCubit.productInCart(product.id)) {
          return _editCartWidget(context);
        }
        return _addCartWidget(context);
      },
    );
  }

  Padding _editCartWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          showPriceRequestDialog(context);
        },
        child: const Icon(Icons.done, color: AppColors.successColor, size: 20),
      ),
    );
  }

  Padding _addCartWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          showPriceRequestDialog(context);
        },
        child: const Icon(Icons.add_shopping_cart, size: 20),
      ),
    );
  }

  void showPriceRequestDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => BlocProvider.value(
        value: CartCubit.instance(context),
        child: AddToPriceRequestDialog(
          product: product,
        ),
      ),
    );
  }
}
