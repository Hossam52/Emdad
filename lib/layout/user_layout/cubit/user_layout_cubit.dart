import 'package:bloc/bloc.dart';
import 'package:emdad/layout/widgets/custom_bottom_nav_item.dart';
import 'package:emdad/modules/settings/setting_screen.dart';
import 'package:emdad/modules/user_module/home_module/user_home/user_home_screen.dart';
import 'package:emdad/modules/user_module/my_orders/my_orders_screen.dart';
import 'package:emdad/modules/user_module/offers_module/offers_screen.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_layout_state.dart';

class UserLayoutCubit extends Cubit<UserLayoutState> {
  UserLayoutCubit() : super(UserLayoutInitial()) {
    bottomItems = [
      CustomBottomNavItemModel(
        child: UserHomeScreen(),
        title: 'الرئيسية',
        icon: MyIcons.home,
      ),
      CustomBottomNavItemModel(
        child: const MyOrdersScreen(),
        title: 'طلباتي',
        icon: MyIcons.my_orders,
      ),
      CustomBottomNavItemModel(
        child: OffersScreen(),
        title: 'عروض اسعار',
        icon: MyIcons.tag,
      ),
      CustomBottomNavItemModel(
        child: const SettingsScreen(),
        title: 'الضبط',
        icon: MyIcons.settings,
      ),
    ];
  }

  static UserLayoutCubit get(context) => BlocProvider.of(context);
  late List<CustomBottomNavItemModel> bottomItems;
  // Current nav index
  int currentIndex = 0;

  CustomBottomNavItemModel get selectedBottom => bottomItems[currentIndex];

  void changeToMainPage() {
    changeBottomNav(0);
  }

  void changeToOrders() {
    changeBottomNav(1);
  }

  void changeToOffers() {
    changeBottomNav(2);
  }

  void changeToSettings() {
    changeBottomNav(3);
  }

  // Change nav function
  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeTestBottomNavState());
  }
}
