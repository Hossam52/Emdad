import 'package:emdad/layout/user_layout/cubit/user_layout_cubit.dart';
import 'package:emdad/layout/user_layout/layout_components/user_bottom_navigation_bar.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'layout_components/user_layout_drawer.dart';

class UserLayout extends StatelessWidget {
  const UserLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserLayoutCubit(),
      child: BlocConsumer<UserLayoutCubit, UserLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          UserLayoutCubit cubit = UserLayoutCubit.get(context);
          return DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                title: Text(cubit.selectedTitle()),
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
                actions: [
                  IconButton(
                    icon: SvgPicture.asset('${Constants.defaultIconUrl}/notification.svg'),
                    onPressed: () {},
                  ),
                ],
              ),
              bottomNavigationBar: UserBottomNavigationBar(cubit: cubit),
              drawer: const Drawer(
                child: UserDrawer(),
              ),
              body: cubit.selectedScreens[cubit.currentIndex],
            ),
          );
        },
      ),
    );
  }
}
