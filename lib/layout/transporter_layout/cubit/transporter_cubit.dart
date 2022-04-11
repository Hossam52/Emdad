import 'package:bloc/bloc.dart';
import 'package:emdad/layout/transporter_layout/cubit/transporter_state.dart';
import 'package:emdad/modules/transporter_module/screens/transporter_delivery_orders_view/transporter_delivery_orders_screen.dart';
import 'package:emdad/modules/transporter_module/screens/transporter_offers_view/transporter_offers_screen.dart';
import 'package:emdad/modules/transporter_module/screens/transporter_profile_screen.dart';
import 'package:emdad/modules/transporter_module/screens/transporter_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransporterCubit extends Cubit<TransporterState> {
  TransporterCubit() : super(TransporterInitial());

  static TransporterCubit get(context) => BlocProvider.of(context);

  // Current nav index
  int currentIndex = 0;

  // List of nav screens
  List<Widget> selectedScreens = [
    //
    const TransporterOffersScreen(),
    const TransporterDeliveryOrdersScreen(),
    const TransporterProfileScreen(),
    const TransporterSettingScreen(),
  ];

  String selectedTitle() {
    final String title;
    switch (currentIndex) {
      case 0:
        title = 'طلبات عرض سعر';
        break;
      case 1:
        title = 'طلبات أوامر توصيل';
        break;
      case 2:
        title = 'الملف الشخصي';
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
