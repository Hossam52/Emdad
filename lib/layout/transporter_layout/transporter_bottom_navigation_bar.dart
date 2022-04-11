import 'package:emdad/layout/transporter_layout/cubit/transporter_cubit.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class TransporterBottomNavigationBar extends StatelessWidget {
  const TransporterBottomNavigationBar({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final TransporterCubit cubit;

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
      )),
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
          label: 'عروض سعر',
          tooltip: 'طلبات عرض سعر',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: 'أوامر توصيل',
          tooltip: 'طلبات أوامر توصيل',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add_alt),
          label: 'الملف الشخصي',
          tooltip: 'الملف الشخصي',
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
