import 'package:emdad/layout/custom_drawer.dart';
import 'package:emdad/layout/user_layout/cubit/user_layout_cubit.dart';
import 'package:emdad/layout/user_layout/layout_components/drawer_list_build_item.dart';
import 'package:emdad/layout/user_layout/layout_components/user_bottom_navigation_bar.dart';
import 'package:emdad/layout/user_layout/layout_components/user_drawer.dart';
import 'package:emdad/layout/widgets/profile_check_wrapper.dart';
import 'package:emdad/models/users/user/user_response_model.dart';
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

class GuestUserLayout extends StatefulWidget {
  const GuestUserLayout({Key? key}) : super(key: key);

  @override
  State<GuestUserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<GuestUserLayout> {
  @override
  void initState() {
    AppCubit.get(context).setUser = GuestUserModel();
    super.initState();
  }

  @override
  void deactivate() {
    AppCubit.get(context).removeCurrentUser();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserLayoutCubit(context, isGuest: true),
        ),
        BlocProvider(
          create: (_) => UserHomeCubit()..getHomeData(),
        ),
        BlocProvider(create: (_) => OffersCubit(context)..getRequestOffers()),
        BlocProvider(create: (_) => MyOrdersCubit(context)..getMyOrders())
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
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                }),
                actions: const [
                  ChangeLangWidget(),
                ],
              ),
              bottomNavigationBar: UserBottomNavigationBar(cubit: cubit),
              drawer: const UserDrawer(),
              body: cubit.selectedBottom.child,
            ),
          );
        },
      ),
    );
  }
}
