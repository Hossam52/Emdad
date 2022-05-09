import 'package:emdad/layout/user_layout/layout_components/user_layout_drawer.dart';
import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/layout/widgets/profile_check_wrapper.dart';
import 'package:emdad/modules/vendor_module/screens/vender_add_product_view/vendor_add_new_product_screen.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_offers_view/vendor_offers_cubit/vendor_offers_cubit.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/products_cubit/vendor_product_cubit.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/purchase_orders_cubit/purchase_orders_cubit.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VendorLayout extends StatefulWidget {
  const VendorLayout({Key? key}) : super(key: key);

  @override
  State<VendorLayout> createState() => _VendorLayoutState();
}

class _VendorLayoutState extends State<VendorLayout> {
  @override
  void initState() {
    super.initState();
    final appCubit = AppCubit.get(context);

    appCubit.getUserProfile();
  }

  @override
  void deactivate() {
    AppCubit.get(context).removeCurrentUser();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileCheckWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => VendorOffersCubit()..getVendorOffers(),
          ),
          BlocProvider(
            create: (context) => VendorProductsCubit(),
          ),
          BlocProvider(
            create: (context) => PurchaseOrdersCubit()..getPurchaseOrders(),
          ),
        ],
        child: VendorBlocConsumer(
          listener: (context, state) {},
          builder: (context, state) {
            var vendorCubit = VendorCubit.instance(context);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              drawer: const Drawer(
                child: UserDrawer(),
              ),
              appBar: AppBar(
                leading: Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: SvgPicture.asset('assets/images/menu.svg'),
                  );
                }),
                title: CustomText(
                  text: vendorCubit.titles[vendorCubit.currentPageIndex],
                  textStyle: primaryTextStyle().copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/images/alert.svg'),
                  ),
                  const ChangeLangWidget()
                ],
              ),
              body: vendorCubit.screens[vendorCubit.currentPageIndex],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  navigateTo(
                      context,
                      BlocProvider.value(
                        value: VendorProductsCubit.instance(context),
                        child: const VendorAddNewProductScreen(),
                      ));
                },
                child: Icon(
                  Icons.add,
                  size: 40.r,
                ),
                backgroundColor: AppColors.primaryColor,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                color: Colors.white,
                notchMargin: 10.r,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  height: 80.h,
                  color: AppColors.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: _BottomWidget(
                          iconData: Icons.show_chart_outlined,
                          index: 0,
                          title: 'طلبات عرض سعر',
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: _BottomWidget(
                          iconData: Icons.shopping_cart_outlined,
                          index: 1,
                          title: 'منتجاتي',
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: _BottomWidget(
                          iconData: Icons.how_to_reg_outlined,
                          index: 2,
                          title: 'طلبات أوامر الشراء',
                        ),
                      ),
                      Expanded(
                        child: _BottomWidget(
                          iconData: Icons.settings_outlined,
                          index: 3,
                          title: 'الضبط',
                        ),
                      ),
                    ],
                  ),
                ),

                //////////////////////

                // child: BottomNavigationBar(
                //   currentIndex: vendorCubit.currentPageIndex,
                //   onTap: (index) {
                //     vendorCubit.changeIndex(index);
                //   },
                //   elevation: 10,
                //   selectedItemColor: Colors.white,
                //   backgroundColor: AppColors.primaryColor,
                //   items: [
                //     BottomNavigationBarItem(
                //       label: 'طلبات عرض سعر',
                //       icon: Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 5.w),
                //         child: const Icon(Icons.show_chart_outlined),
                //       ),
                //     ),
                //     BottomNavigationBarItem(
                //       label: 'منتجاتي',
                //       icon: Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 5.w),
                //         child: const Icon(Icons.shopping_cart_outlined),
                //       ),
                //     ),
                //     BottomNavigationBarItem(
                //       label: 'طلبات أوامر الشراء',
                //       icon: Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 5.w),
                //         child: const Icon(Icons.how_to_reg_outlined),
                //       ),
                //     ),
                //     BottomNavigationBarItem(
                //       label: 'الضبط',
                //       icon: Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 5.w),
                //         child: const Icon(Icons.settings_outlined),
                //       ),
                //     ),
                //   ],
                // ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BottomWidget extends StatelessWidget {
  const _BottomWidget(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.index})
      : super(key: key);
  final String title;
  final IconData iconData;
  final int index;
  @override
  Widget build(BuildContext context) {
    return VendorBlocBuilder(
      builder: (context, state) {
        final vendorCubit = VendorCubit.instance(context);
        return InkWell(
          onTap: () {
            vendorCubit.changeIndex(index);
            vendorCubit.currentPageIndex = index;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Icon(
                  iconData,
                  color: vendorCubit.currentPageIndex == index
                      ? Colors.white
                      : Colors.grey,
                ),
              ),
              CustomText(
                text: title,
                textStyle: subTextStyle().copyWith(
                  fontSize: 8.sp,
                  color: vendorCubit.currentPageIndex == index
                      ? Colors.white
                      : Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
