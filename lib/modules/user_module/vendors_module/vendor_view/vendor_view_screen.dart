import 'dart:developer';

import 'package:emdad/models/products_and_categories/category_model.dart';
import 'package:emdad/models/users/user/user_response_model.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_cubit.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_states.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_user_preview.dart';
import 'package:emdad/modules/user_module/vendors_module/product_details/product_details_screen.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/cart_cubit/cart_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_reviews_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/empty_data.dart';
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
  const VendorViewScreen(
      {Key? key, required this.title, required this.vendorId})
      : super(key: key);

  final String title;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
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
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                VendorProfileCubit(vendorId: vendorId)..getVendorInfo(),
          ),
          BlocProvider(
            create: (context) => CartCubit(),
            lazy: false,
          ),
        ],
        child: VendorProfileBlocBuilder(
          builder: (context, state) {
            final vendorProfileCubit = VendorProfileCubit.instance(context);
            if (state is GetVendorInfoLoadingState) {
              return const DefaultLoader();
            }
            if (state is GetVendorInfoErrorState) {
              return NoDataWidget(
                  text: state.error,
                  onPressed: () {
                    vendorProfileCubit.getVendorInfo();
                  });
            }
            if (!vendorProfileCubit.isProfileLoaded) {
              return NoDataWidget(onPressed: () {
                vendorProfileCubit.getVendorInfo();
              });
            }
            final user = vendorProfileCubit.getVendorData;
            final categories = vendorProfileCubit.getCategories;
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      VendorInfoBuildItem(
                        name: user.organizationName!,
                        isCart: false,
                        city: user.city,
                        logoUrl: user.logoUrl,
                        vendorType: user.allVendorTypeString,
                        tailing: VendorButtonsBuild(
                          vendor: user,
                        ),
                      ),
                      Builder(builder: (context) {
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            if (categories.isNotEmpty)
                              Text(
                                'المنتجات المتاحة لهذا المورد',
                                style: thirdTextStyle()
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              separatorBuilder: (_, index) => const Divider(),
                              itemBuilder: (_, index) => _CategoryWithProducts(
                                categoryModel: categories[index],
                              ),
                              itemCount: categories.length,
                            ),
                            const SizedBox(height: 60),
                            const _Ratings(),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                const CartBarBuildItem(),
              ],
            );
          },
        ),
      ),
    );
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
                        value: VendorProfileCubit.instance(context),
                        child: const VendorReviewsScreen(),
                      ));
                },
              ),
            ),
            SizedBox(
              height: 180.h,
              width: double.infinity,
              child: Builder(builder: (context) {
                if (ratings.isEmpty) {
                  return const EmptyData(
                    emptyText: 'لا يوجد تعليقات علي هذا المورد',
                    displayImage: false,
                  );
                } else {
                  return ListView.builder(
                    primary: true,
                    itemBuilder: (_, index) => ReviewBuildItem(
                      rateModel: ratings[index],
                    ),
                    itemCount: ratings.length,
                    scrollDirection: Axis.horizontal,
                  );
                }
              }),
            ),
          ],
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
          title: RichText(
            text: TextSpan(
                text: 'التصنيف' ' : ',
                style: secondaryTextStyle()
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: categoryModel.category,
                    style: thirdTextStyle().copyWith(color: Colors.black),
                  ),
                ]),
          ),
          trailing: const Icon(Icons.arrow_forward_ios,
              size: 14, color: Colors.black),
          onTap: () {
            navigateTo(
                context,
                MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: VendorProfileCubit.instance(context),
                    ),
                    BlocProvider.value(
                      value: CartCubit.instance(context),
                    ),
                  ],
                  child: CategoryScreen(
                    categoryName: categoryModel.category,
                    title: categoryModel.category,
                  ),
                ));
          },
        ),
        SizedBox(
          height: 200.h,
          width: double.infinity,
          child: Builder(builder: (context) {
            if (products.isEmpty) {
              return EmptyData(
                emptyText: 'لا يوجد منتجات خاصة ب ${categoryModel.category}',
                displayImage: false,
              );
            }
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              primary: true,
              shrinkWrap: true,
              separatorBuilder: (_, index) => SizedBox(width: 10.w),
              itemBuilder: (_, index) => ProductCardBuildItem(
                product: products[index],
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
              itemCount: products.length,
            );
          }),
        ),
      ],
    );
  }
}
