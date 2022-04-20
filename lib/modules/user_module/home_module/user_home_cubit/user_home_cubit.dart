import 'package:emdad/models/users/user/home_user_response.dart';
import 'package:emdad/models/users/user/user_response_model.dart';
import 'package:emdad/modules/user_module/home_module/user_home_cubit/user_home_states.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

//Bloc builder and bloc consumer methods
typedef UserHomeBlocBuilder = BlocBuilder<UserHomeCubit, UserHomeStates>;
typedef UserHomeBlocConsumer = BlocConsumer<UserHomeCubit, UserHomeStates>;

//
class UserHomeCubit extends Cubit<UserHomeStates> {
  UserHomeCubit() : super(IntitalUserHomeState());
  static UserHomeCubit instance(BuildContext context) =>
      BlocProvider.of<UserHomeCubit>(context);
  final userServices = UserServices.instance;
  //Home data
  HomeUserModel? _homeModel;
  bool get isLoadedHomeData => _homeModel != null;
  //For favorite vendors
  List<User> get favoriteVendors {
    return _homeModel?.favouriteVendors ?? [];
  }

  //For featreched vendors
  List<User> get featcherdVendors {
    return _homeModel?.featuredVendors ?? [];
  }

  //For vendors
  List<User> get vendors {
    return _homeModel?.vendors ?? [];
  }

  void toggleFavoriteVendor(User user) {
    int index = favoriteVendors.indexWhere((element) => element.id == user.id);
    if (index != -1) {
      _homeModel!.favouriteVendors.removeAt(index);
    } else {
      _homeModel!.favouriteVendors.add(user);
    }
    emit(ToggleFavoriteVendorState());
  }

  Future<void> getHomeData() async {
    try {
      emit(GetHomeDataLoadingState());
      final response = await userServices.userHomeServices.getHomeData();
      _homeModel = HomeUserModel.fromMap(response);
      emit(GetHomeDataSuccessState());
    } catch (e) {
      emit(GetHomeDataErrorState(error: e.toString()));
    }
  }
}
