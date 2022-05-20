import 'package:emdad/layout/custom_drawer.dart';
import 'package:emdad/layout/user_layout/cubit/user_layout_cubit.dart';
import 'package:emdad/layout/user_layout/layout_components/drawer_list_build_item.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({Key? key}) : super(key: key);

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
