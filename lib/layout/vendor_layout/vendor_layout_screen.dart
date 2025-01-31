import 'package:emdad/layout/custom_drawer.dart';
import 'package:emdad/layout/user_layout/layout_components/drawer_list_build_item.dart';
import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/layout/widgets/profile_check_wrapper.dart';
import 'package:emdad/modules/vendor_module/screens/vender_add_product_view/vendor_add_new_product_screen.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_offers_view/vendor_offers_cubit/vendor_offers_cubit.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/products_cubit/vendor_product_cubit.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/purchase_orders_cubit/purchase_orders_cubit.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/notifications_button.dart';
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
            create: (_) => VendorOffersCubit()..getVendorOffers(),
          ),
          BlocProvider(
            create: (_) => VendorProductsCubit(),
          ),
          BlocProvider(
            create: (_) => PurchaseOrdersCubit()..getPurchaseOrders(),
          ),
        ],
        child: VendorBlocConsumer(
          listener: (context, state) {},
          builder: (context, state) {
            var vendorCubit = VendorCubit.instance(context);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              drawer: const _VendorDrawer(),
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
                  text: vendorCubit.selectedBottomItem.title,
                  textStyle: primaryTextStyle().copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                actions: const [
                  ChangeLangWidget(),
                  NotificationsButton(),
                ],
              ),
              body: vendorCubit.selectedBottomItem.child,
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
                    children: [
                      for (int i = 0; i < vendorCubit.bottomItems.length; i++)
                        Expanded(
                          flex:
                              i != vendorCubit.bottomItems.length - 1 && i != 0
                                  ? 2
                                  : 1,
                          child: _BottomWidget(
                            iconData: vendorCubit.bottomItems[i].icon,
                            index: i,
                            title: vendorCubit.bottomItems[i].title,
                          ),
                        ),
                    ],
                  ),
                ),
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

class _VendorDrawer extends StatelessWidget {
  const _VendorDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = VendorCubit.instance(context);
    return CustomDrawer(
      drawerItems: [
        DrawerListBuildItem(
          title: context.tr.main_page,
          icon: MyIcons.home,
          onTap: () {
            cubit.changeToOffers();
          },
        ),
        DrawerListBuildItem(
          title: context.tr.add_new,
          icon: MyIcons.note,
          onTap: () {
            navigateTo(context, const VendorAddNewProductScreen());
          },
        ),
        DrawerListBuildItem(
          title: context.tr.my_products,
          icon: MyIcons.money,
          size: 15,
          onTap: () {
            cubit.changeToProducts();
          },
        ),
        DrawerListBuildItem(
          title: context.tr.notifications,
          icon: MyIcons.bell2,
          onTap: () {},
        ),
        DrawerListBuildItem(
          title: context.tr.ask_help,
          icon: MyIcons.question,
          onTap: () {},
        ),
        DrawerListBuildItem(
          title: context.tr.support_and_privacy,
          icon: MyIcons.support,
          onTap: () {},
        ),
        DrawerListBuildItem(
          title: context.tr.about_us,
          icon: Icons.info_outlined,
          size: 24,
          onTap: () {},
        ),
        DrawerListBuildItem(
          title: context.tr.settings,
          icon: MyIcons.settings,
          onTap: () {
            cubit.chnageeToSettings();
          },
        ),
      ],
    );
  }
}
