import 'package:carousel_slider/carousel_slider.dart';
import 'package:emdad/modules/user_module/home_module/user_home/product_slider_build_item.dart';
import 'package:emdad/modules/user_module/home_module/user_home_cubit/user_home_cubit.dart';
import 'package:emdad/modules/user_module/home_module/user_home_cubit/user_home_states.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_screen.dart';
import 'package:emdad/modules/user_module/vendors_module/vendors_list_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/responsive/device_information.dart';
import 'package:emdad/shared/responsive/responsive_widget.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/empty_data.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_vendor_build_item.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserHomeBlocBuilder(
      builder: (context, state) {
        final userHomeCubit = UserHomeCubit.instance(context);
        if (state is GetHomeDataLoadingState) {
          return const DefaultLoader();
        } else if (!userHomeCubit.isLoadedHomeData) {
          return NoDataWidget(onPressed: () {
            userHomeCubit.getHomeData();
          });
        }

        return RefreshIndicator(
          onRefresh: () {
            userHomeCubit.getHomeData();
            return Future.value();
          },
          child: responsiveWidget(
            responsive: (_, deviceInfo) => UserHomeBlocBuilder(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      DefaultHomeTitleBuildItem(
                        title: 'الموردون المفضلون',
                        onPressed: () {
                          navigateTo(context,
                              VendorsListScreen(title: 'الموردون المفضلون'));
                        },
                      ),
                      const SizedBox(height: 5),
                      const _FavoriteVendors(),
                      SizedBox(height: 15.h),
                      const _FeaturedVendors(),
                      SizedBox(height: 8.h),
                      DefaultHomeTitleBuildItem(
                        title: 'جميع الموردين',
                        onPressed: () {
                          navigateTo(context,
                              VendorsListScreen(title: 'جميع الموردين'));
                        },
                      ),
                      const SizedBox(height: 5),
                      _AllVendors(deviceInfo: deviceInfo),
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

class _FavoriteVendors extends StatelessWidget {
  const _FavoriteVendors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserHomeBlocBuilder(
      builder: (context, state) {
        final favoriteVendors = UserHomeCubit.instance(context).favoriteVendors;
        if (favoriteVendors.isEmpty) {
          return const EmptyData(
            emptyText: 'No Favorite vendors upt till now',
          );
        }
        return SizedBox(
          height: 265.h,
          child: ListView.separated(
            itemCount: favoriteVendors.length,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) => HomeVendorBuildItem(
              user: favoriteVendors[index],
              width: 100.w,
              isFavorite: false,
              onTap: () {
                navigateTo(
                    context,
                    VendorViewScreen(
                      title: favoriteVendors[index].name!,
                      user: favoriteVendors[index],
                    ));
              },
            ),
          ),
        );
      },
    );
  }
}

class _FeaturedVendors extends StatelessWidget {
  const _FeaturedVendors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserHomeBlocBuilder(
      builder: (context, state) {
        final featuredVendors =
            UserHomeCubit.instance(context).featcherdVendors;
        return SizedBox(
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: featuredVendors.length,
            options: CarouselOptions(
              autoPlay: true,
              pauseAutoPlayOnTouch: true,
              viewportFraction: 0.9,
              height: 180.h,
            ),
            itemBuilder: (context, index, int pageViewIndex) => Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: DefaultCachedNetworkImage(
                imageUrl: featuredVendors[index].logoUrl!,
                // 'https://images.unsplash.com/photo-1557844352-761f2565b576?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AllVendors extends StatelessWidget {
  const _AllVendors({Key? key, required this.deviceInfo}) : super(key: key);
  final DeviceInformation deviceInfo;
  @override
  Widget build(BuildContext context) {
    return UserHomeBlocBuilder(
      builder: (context, state) {
        final vendors = UserHomeCubit.instance(context).vendors;
        if (vendors.isEmpty) return const EmptyData(emptyText: 'No Vendors');
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: vendors.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) => HomeVendorBuildItem(
            width: deviceInfo.screenwidth * 0.5,
            user: vendors[index],
            isFavorite: true,
            onTap: () {
              navigateTo(
                  context, const VendorViewScreen(title: 'الهدي للتوريدات'));
            },
          ),
        );
      },
    );
  }
}
