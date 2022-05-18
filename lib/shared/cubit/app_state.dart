part of 'app_cubit.dart';

abstract class AppState {}

class AppInitial extends AppState {}

class ChangeLanguageState extends AppState {}

class ChangeUserData extends AppState {}

//GetSettings online fetch data
class GetSettingsLoadingState extends AppState {}

class GetSettingsSuccessState extends AppState {}

class GetSettingsErrorState extends AppState {
  final String error;
  GetSettingsErrorState({required this.error});
}

//GetUserProfile online fetch data
class GetUserProfileLoadingState extends AppState {}

class GetUserProfileSuccessState extends AppState {}

class GetUserProfileErrorState extends AppState {
  final String error;
  GetUserProfileErrorState({required this.error});
}
