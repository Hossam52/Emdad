import 'package:emdad/layout/user_layout/layout_components/user_layout_drawer.dart';
import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/modules/vendor_module/screens/vender_add_product_view/vendor_add_new_product_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VendorLayout extends StatelessWidget {
  const VendorLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VendorBlocConsumer(
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
              navigateTo(context, const VendorAddNewProductScreen());
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
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        vendorCubit.changeIndex(0);
                        vendorCubit.currentPageIndex = 0;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Icon(
                              Icons.show_chart_outlined,
                              color: vendorCubit.currentPageIndex == 0
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                          CustomText(
                            text: 'طلبات عرض سعر',
                            textStyle: subTextStyle().copyWith(
                              fontSize: 8.sp,
                              color: vendorCubit.currentPageIndex == 0
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        vendorCubit.changeIndex(1);
                        vendorCubit.currentPageIndex = 1;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: vendorCubit.currentPageIndex == 1
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                          CustomText(
                            text: 'منتجاتي',
                            textStyle: subTextStyle().copyWith(
                              fontSize: 8.sp,
                              color: vendorCubit.currentPageIndex == 1
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        vendorCubit.changeIndex(2);
                        vendorCubit.currentPageIndex = 2;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Icon(
                              Icons.how_to_reg_outlined,
                              color: vendorCubit.currentPageIndex == 2
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                          CustomText(
                            text: 'طلبات أوامر الشراء',
                            textStyle: subTextStyle().copyWith(
                              fontSize: 8.sp,
                              color: vendorCubit.currentPageIndex == 2
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        vendorCubit.changeIndex(3);
                        vendorCubit.currentPageIndex = 3;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Icon(
                              Icons.settings_outlined,
                              color: vendorCubit.currentPageIndex == 3
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                          CustomText(
                            text: 'الضبط',
                            textStyle: subTextStyle().copyWith(
                              fontSize: 8.sp,
                              color: vendorCubit.currentPageIndex == 3
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
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
    );
  }
}
