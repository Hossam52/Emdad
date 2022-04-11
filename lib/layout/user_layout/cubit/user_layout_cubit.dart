import 'package:bloc/bloc.dart';
import 'package:emdad/modules/settings/setting_screen.dart';
import 'package:emdad/modules/user_module/home_module/user_home/user_home_screen.dart';
import 'package:emdad/modules/user_module/my_orders/my_orders_screen.dart';
import 'package:emdad/modules/user_module/offers_module/offers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_layout_state.dart';

class UserLayoutCubit extends Cubit<UserLayoutState> {
  UserLayoutCubit() : super(UserLayoutInitial());

  static UserLayoutCubit get(context) => BlocProvider.of(context);

  // Current nav index
  int currentIndex = 0;

  // List of nav screens
  List<Widget> selectedScreens = const [
    UserHomeScreen(),
    MyOrdersScreen(),
    OffersScreen(),
    SettingsScreen(),
  ];

  String selectedTitle() {
    final String title;
    switch (currentIndex) {
      case 0:
        title = 'الرئيسية';
        break;
      case 1:
        title = 'طلباتي';
        break;
      case 2:
        title = 'عروض اسعار';
        break;
      default:
        title = 'الضبط';
        break;
    }
    return title;
  }

  // Change nav function
  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeTestBottomNavState());
  }
}
