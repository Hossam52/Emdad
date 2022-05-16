import 'dart:developer';

import 'package:emdad/models/general_models/settings_model.dart';
import 'package:emdad/modules/user_module/vendors_module/change_filters_cubit/change_filters_states.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

//Bloc builder and bloc consumer methods
typedef ChangeFiltersBlocBuilder
    = BlocBuilder<ChangeFiltersCubit, ChangeFiltersStates>;
typedef ChangeFiltersBlocConsumer
    = BlocConsumer<ChangeFiltersCubit, ChangeFiltersStates>;

//
class ChangeFiltersCubit extends Cubit<ChangeFiltersStates> {
  ChangeFiltersCubit() : super(ChangeFiltersState());
  static ChangeFiltersCubit instance(BuildContext context) =>
      BlocProvider.of<ChangeFiltersCubit>(context);

  //For filteration
  List<String> _countries = [];
  List<Countries> _countriesObject = [];
  List<String> _cities = [];
  List<String> _vendorTypes = [];
  List<String> _transportationMethods = [];

  List<String> get countries => _countries;
  List<String> get cities {
    if (selectedCountry == null) return [];
    return _cities;
  }

  List<String> get vendorTypes => _vendorTypes;
  List<String> get transportationMethods => _transportationMethods;

  String? _selectedCountry;
  String? _selectedCity;
  String? _selectedTransportation;
  Set<String>? _selectedVendorType = {};

  String? get selectedCountry => _selectedCountry;
  String? get selectedCountryCode {
    try {
      return _countriesObject
          .firstWhere(
            (element) => element.countryName == _selectedCountry,
          )
          .countryCode;
    } catch (e) {
      log(e.toString());
    }
  }

  String? get selectedCity => _selectedCity;
  String? get selectedTransportation => _selectedTransportation;
  Set<String>? get selectedVendorType => _selectedVendorType;

  void initFilters(BuildContext context,
      {String? initialCountryCode, String? intialCity}) {
    final appCubit = AppCubit.get(context);

    _vendorTypes = appCubit.settings.vendorTypes!;

    _countries = appCubit.getCountryNames;

    _countriesObject = appCubit.settings.countries!;

    _transportationMethods = appCubit.getTransportationMethods;

    if (initialCountryCode != null) {
      setSelectedCountryByCode(context, initialCountryCode);
    }
    if (intialCity != null) {
      _selectedCity =
          cities.firstWhere((element) => element == intialCity, orElse: () {
        return cities.first;
      });
    }
    emit(ChangeFilters());
  }

  void setSelectedCountryByCode(BuildContext context, String countryCode) {
    final settingIndex = _countriesObject
        .indexWhere((element) => element.countryCode == countryCode);
    if (settingIndex != -1) {
      changeSelectedCountry(
          context, _countriesObject[settingIndex].countryName!);
    }
  }

  void setIntialValues({
    bool setSelectedTransportationToFirst = false,
    bool setSelectedCountryToFirst = false,
  }) {
    if (setSelectedCountryToFirst) {
      _selectedCountry = _countries.first;
    }
    if (setSelectedTransportationToFirst) {
      _selectedTransportation = _transportationMethods.first;
    }
  }

  void changeSelectedCountry(BuildContext context, String country) {
    _selectedCountry = country;
    _cities = AppCubit.get(context).getCitiesForCountry(_selectedCountry!);
    _selectedCity = _cities.first;
    emit(ChangeFiltersState());
  }

  void changeSelectedCity(String city) {
    _selectedCity = city;
    emit(ChangeFilters());
  }

  void changeSelectedTransportation(String transportationMethod) {
    _selectedTransportation = transportationMethod;
    emit(ChangeFilters());
  }

  void addVendorType(String vendorType) {
    _selectedVendorType ??= {};
    _selectedVendorType!.add(vendorType);
    emit(AddVendorTypeState());
  }

  void removeVendorType(String vendorType) {
    _selectedVendorType!.removeWhere((element) => element == vendorType);
    emit(AddVendorTypeState());
  }

  void removeAllFilters() {
    _selectedCountry = null;
    _selectedCity = null;
    _selectedVendorType = null;
    _selectedTransportation = null;
    emit(RemoveAllFiltersState());
  }
}
