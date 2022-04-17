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

  Future<void> getHomeData() async {
    try {
      emit(GetHomeDataLoadingState());
      await userServices.userHomeServices.getHomeData();
      emit(GetHomeDataSuccessState());
    } catch (e) {
      emit(GetHomeDataErrorState(error: e.toString()));
    }
  }
}
