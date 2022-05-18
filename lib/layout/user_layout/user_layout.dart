import 'package:emdad/layout/custom_drawer.dart';
import 'package:emdad/layout/user_layout/cubit/user_layout_cubit.dart';
import 'package:emdad/layout/user_layout/layout_components/drawer_list_build_item.dart';
import 'package:emdad/layout/user_layout/layout_components/user_bottom_navigation_bar.dart';
import 'package:emdad/layout/widgets/profile_check_wrapper.dart';
import 'package:emdad/modules/user_module/home_module/user_home_cubit/user_home_cubit.dart';
import 'package:emdad/modules/user_module/my_orders/my_orders_cubit/my_orders_cubit.dart';
import 'package:emdad/modules/user_module/offers_module/offers_cubit/offers_cubit.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'layout_components/user_layout_drawer.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({Key? key}) : super(key: key);

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
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
            create: (context) => UserLayoutCubit(),
          ),
          BlocProvider(
            create: (context) => UserHomeCubit()..getHomeData(),
          ),
          BlocProvider(create: (_) => OffersCubit()..getRequestOffers()),
          BlocProvider(create: (_) => MyOrdersCubit()..getMyOrders())
        ],
        child: BlocConsumer<UserLayoutCubit, UserLayoutState>(
          listener: (context, state) {},
          builder: (context, state) {
            UserLayoutCubit cubit = UserLayoutCubit.get(context);
            return DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(cubit.selectedBottom.title),
                  centerTitle: true,
                  leading: Builder(builder: (context) {
                    return IconButton(
                      icon: const Icon(
                        MyIcons.menu,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  }),
                  actions: [
                    const ChangeLangWidget(),
                    IconButton(
                      icon: SvgPicture.asset(
                          '${Constants.defaultIconUrl}/notification.svg'),
                      onPressed: () {},
                    ),
                  ],
                ),
                bottomNavigationBar: UserBottomNavigationBar(cubit: cubit),
                drawer: const _UserDrawer(),
                body: cubit.selectedBottom.child,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _UserDrawer extends StatelessWidget {
  const _UserDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = UserLayoutCubit.get(context);

    return CustomDrawer(
      drawerItems: [
        DrawerListBuildItem(
          title: 'الرئيسية',
          icon: MyIcons.home,
          onTap: () {
            userCubit.changeToMainPage();
          },
        ),
        DrawerListBuildItem(
          title: 'عروض',
          icon: MyIcons.money,
          size: 15,
          onTap: () {
            userCubit.changeToOffers();
          },
        ),
        DrawerListBuildItem(
          title: 'الاشعارات',
          icon: MyIcons.bell2,
          onTap: () {},
        ),
        DrawerListBuildItem(
          title: 'طلب مساعدة',
          icon: MyIcons.question,
          onTap: () {},
        ),
        DrawerListBuildItem(
          title: 'الدعم والخصوصية',
          icon: MyIcons.support,
          onTap: () {},
        ),
        DrawerListBuildItem(
          title: 'عنا',
          icon: Icons.info_outlined,
          size: 24,
          onTap: () {},
        ),
        DrawerListBuildItem(
          title: 'الضبط',
          icon: MyIcons.settings,
          onTap: () {
            userCubit.changeToSettings();
          },
        ),
      ],
    );
  }
}
