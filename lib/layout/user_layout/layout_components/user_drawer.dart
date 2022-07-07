import 'package:emdad/layout/custom_drawer.dart';
import 'package:emdad/layout/user_layout/cubit/user_layout_cubit.dart';
import 'package:emdad/layout/user_layout/layout_components/drawer_list_build_item.dart';
import 'package:emdad/modules/notifications/notifications_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = UserLayoutCubit.get(context);

    return CustomDrawer(
      drawerItems: [
        DrawerListBuildItem(
          title: context.tr.main_page,
          icon: MyIcons.home,
          onTap: () {
            userCubit.changeToMainPage();
          },
        ),
        DrawerListBuildItem(
          title: context.tr.offers,
          icon: MyIcons.money,
          size: 15,
          onTap: () {
            userCubit.changeToOffers();
          },
        ),
        DrawerListBuildItem(
          title: context.tr.notifications,
          icon: MyIcons.bell2,
          onTap: () {
            navigateTo(context, const NotificationsScreen());
          },
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
            userCubit.changeToSettings();
          },
        ),
      ],
    );
  }
}
