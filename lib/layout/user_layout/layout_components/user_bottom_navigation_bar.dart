import 'package:emdad/layout/user_layout/cubit/user_layout_cubit.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class UserBottomNavigationBar extends StatelessWidget {
  const UserBottomNavigationBar({Key? key, required this.cubit}) : super(key: key);

  final UserLayoutCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      height: 75,
      snakeViewColor: AppColors.myGreyColor,
      snakeShape: SnakeShape.indicator,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        )
      ),
      currentIndex: cubit.currentIndex,
      onTap: (index) {
        cubit.changeBottomNav(index);
      },
      elevation: 5,
      selectedItemColor: Colors.white,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.white38,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(MyIcons.home),
          label: 'الرئيسية',
          tooltip: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(MyIcons.my_orders),
          label: 'طلباتي',
          tooltip: 'طلباتي',
        ),
        BottomNavigationBarItem(
          icon: Icon(MyIcons.tag),
          label: 'عروض اسعار',
          tooltip: 'عروض اسعار',
        ),
        BottomNavigationBarItem(
          icon: Icon(MyIcons.settings),
          label: 'الضبط',
          tooltip: 'الضبط',
        ),
      ],
    );
  }
}
