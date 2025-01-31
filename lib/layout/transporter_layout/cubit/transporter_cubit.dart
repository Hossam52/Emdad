import 'package:bloc/bloc.dart';
import 'package:emdad/layout/transporter_layout/cubit/transporter_state.dart';
import 'package:emdad/layout/widgets/custom_bottom_nav_item.dart';
import 'package:emdad/modules/settings/setting_screen.dart';
import 'package:emdad/modules/transporter_module/screens/transporter_delivery_orders_view/transporter_delivery_orders_screen.dart';
import 'package:emdad/modules/transporter_module/screens/transporter_offers_view/transporter_offers_screen.dart';
import 'package:emdad/modules/transporter_module/screens/transporter_profile_screen.dart';
import 'package:emdad/modules/transporter_module/screens/transporter_setting_screen.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransporterCubit extends Cubit<TransporterState> {
  TransporterCubit(BuildContext context) : super(TransporterInitial()) {
    bottomItems = [
      CustomBottomNavItemModel(
        child: const TransporterOffersScreen(),
        title: context.tr.price_offers,
        icon: MyIcons.home,
      ),
      CustomBottomNavItemModel(
        child: const TransporterDeliveryOrdersScreen(),
        title: context.tr.delivery_orders,
        icon: Icons.person_add_alt,
      ),
      CustomBottomNavItemModel(
        child: const SettingsScreen(),
        title: context.tr.settings,
        icon: MyIcons.settings,
      ),
    ];
  }

  static TransporterCubit get(context) => BlocProvider.of(context);
  late List<CustomBottomNavItemModel> bottomItems;
  // Current nav index
  int currentIndex = 0;
  CustomBottomNavItemModel get selectedBottom => bottomItems[currentIndex];

  // Change nav function
  void changeToOffers() {
    changeBottomNav(0);
  }

  void changeToPurchase() {
    changeBottomNav(1);
  }

  void changeToSettings() {
    changeBottomNav(2);
  }

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeTestBottomNavState());
  }
}
