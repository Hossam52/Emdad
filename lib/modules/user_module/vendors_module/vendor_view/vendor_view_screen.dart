import 'package:emdad/models/products_and_categories/category_model.dart';
import 'package:emdad/models/users/user/user_response_model.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_cubit.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_states.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_reviews_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'category_screen.dart';
import 'vendor_view_componants/cart_bar_build_item.dart';
import 'vendor_view_componants/product_card_build_item.dart';
import 'vendor_view_componants/review_build_item.dart';
import 'vendor_view_componants/vendor_buttons_build.dart';
import 'vendor_view_componants/vendor_info_build_item.dart';

class VendorViewScreen extends StatelessWidget {
  const VendorViewScreen({Key? key, required this.title, this.user})
      : super(key: key);

  final String title;
  final User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.name!, style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        actions: const [
          ChangeLangWidget(
            color: Colors.white,
          )
        ],
      ),
      floatingActionButton: const CartBarBuildItem(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocProvider(
        create: (context) =>
            VendorProfileCubit()..getVendorInfo(vendorId: user!.id!),
        child: VendorProfileBlocBuilder(
          builder: (context, state) {
            final vendorProfileCubit = VendorProfileCubit.instance(context);
            if (state is GetVendorInfoLoadingState) {
              return const DefaultLoader();
            }
            if (!vendorProfileCubit.isProfileLoaded) {
              return NoDataWidget(onPressed: () {
                vendorProfileCubit.getVendorInfo(vendorId: user!.id!);
              });
            }
            final categories = vendorProfileCubit.getCategories;
            return SingleChildScrollView(
              child: Column(
                children: [
                  VendorInfoBuildItem(
                    isCart: false,
                    city: user!.city,
                    logoUrl: user!.logoUrl,
                    vendorType: getVendorType(),
                    tailing: const VendorButtonsBuild(),
                  ),
                  Builder(builder: (context) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: DefaultHomeTitleBuildItem(
                            title: 'التعليقات',
                            hasButton: true,
                            onPressed: () {
                              navigateTo(
                                  context,
                                  BlocProvider.value(
                                    value: vendorProfileCubit,
                                    child: const VendorReviewsScreen(),
                                  ));
                            },
                          ),
                        ),
                        const _Ratings(),
                        const SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (_, index) => _CategoryWithProducts(
                            categoryModel: categories[index],
                          ),
                          itemCount: categories.length,
                        ),
                        const SizedBox(height: 60),
                      ],
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String getVendorType() {
    return user!.vendorType?.first ?? '';
  }
}

class _Ratings extends StatelessWidget {
  const _Ratings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VendorProfileBlocBuilder(
      builder: (context, state) {
        var ratings = VendorProfileCubit.instance(context).getRatings;
        ratings =
            ratings.take(ratings.length > 10 ? 10 : ratings.length).toList();
        return SizedBox(
          height: 180.h,
          width: double.infinity,
          child: ListView.builder(
            primary: true,
            itemBuilder: (_, index) => ReviewBuildItem(
              rateModel: ratings[index],
            ),
            itemCount: ratings.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }
}

class _CategoryWithProducts extends StatelessWidget {
  const _CategoryWithProducts({Key? key, required this.categoryModel})
      : super(key: key);
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    var products = categoryModel.products;
    products =
        products.take(products.length > 10 ? 10 : products.length).toList();
    return Column(
      children: [
        ListTile(
          title: Text(categoryModel.category),
          trailing: const Icon(Icons.arrow_forward_ios,
              size: 14, color: Colors.black),
          onTap: () {
            navigateTo(
                context,
                BlocProvider.value(
                  value: VendorProfileCubit.instance(context),
                  child: CategoryScreen(
                    categoryModel: categoryModel,
                  ),
                ));
          },
        ),
        SizedBox(
          height: 250.h,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            primary: true,
            shrinkWrap: true,
            itemBuilder: (_, index) => ProductCardBuildItem(
              image: products[index].images.first,
              name: products[index].name,
              hasCart: false,
              isList: true,
              product: products[index],
            ),
            itemCount: products.length,
          ),
        ),
      ],
    );
  }
}
