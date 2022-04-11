import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  Locale localeApp = Locale(Constants.lang ?? 'ar');


  void changeLocaleApp(String languageCode) {
    if (localeApp.countryCode != languageCode) {
      Constants.lang = languageCode;
      localeApp = Locale(languageCode);
      CacheHelper.saveData(key: 'lang', value: languageCode);
      emit(ChangeLanguageState());
    }
  }
}
