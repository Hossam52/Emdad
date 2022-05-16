import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:emdad/models/general_models/settings_model.dart';
import 'package:emdad/models/users/user/user_response_model.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/network/local/cache_helper.dart';
import 'package:emdad/shared/network/services/auth_services.dart';
import 'package:emdad/shared/network/services/general/general_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  SettingModel? _settingModel;
  //Get app settings
  AllSettingsModel get settings =>
      _settingModel?.data ?? AllSettingsModel.empty();
  UserResponseModel? _loggedInUser;
  User? get getUser => _loggedInUser?.data?.user;
  set setUser(UserResponseModel user) => _loggedInUser = user;
  void removeCurrentUser() => _loggedInUser = null;

  Locale localeApp = Locale(Constants.lang ?? 'ar');

  void changeLocaleApp(String languageCode) {
    if (localeApp.countryCode != languageCode) {
      Constants.lang = languageCode;
      localeApp = Locale(languageCode);
      CacheHelper.saveData(key: 'lang', value: languageCode);
      emit(ChangeLanguageState());
    }
  }

  Future<void> getSettings() async {
    try {
      emit(GetSettingsLoadingState());
      final response = await GeneralServices.instance.getAppSettings();
      final settings = SettingModel.fromMap(response);
      if (settings.status!) {
        _settingModel = settings;
      } else {
        throw 'Status in settings false';
      }

      emit(GetSettingsSuccessState());
    } catch (e) {
      emit(GetSettingsErrorState(error: e.toString()));
    }
  }

  Future<void> getUserProfile() async {
    try {
      emit(GetUserProfileLoadingState());
      final map = await AuthServices.getProfile();
      _loggedInUser = UserResponseModel.fromJson(map);
      emit(GetUserProfileSuccessState());
    } catch (e) {
      emit(GetUserProfileErrorState(error: e.toString()));
    }
  }

  List<String> get getCountryNames =>
      settings.countries!.map((e) => e.countryName!).toList();

  List<String> getCitiesForCountry(String countryName) {
    final country = settings.countries!
        .firstWhere((element) => element.countryName == countryName);
    return country.cities!;
  }

  List<String> get getTransportationMethods => settings.transportationMethods!;
}
