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
  List<String> _cities = [];
  List<String> _vendorTypes = [];

  List<String> get countries => _countries;
  List<String> get cities {
    if (selectedCountry == null) return [];
    return _cities;
  }

  List<String> get vendorTypes => _vendorTypes;

  String? _selectedCountry;
  String? _selectedCity;
  Set<String>? _selectedVendorType = {};

  String? get selectedCountry => _selectedCountry;
  String? get selectedCity => _selectedCity;
  Set<String>? get selectedVendorType => _selectedVendorType;

  void initFilters(BuildContext context) {
    final appCubit = AppCubit.get(context);

    _vendorTypes = appCubit.settings.vendorTypes!;

    _countries = appCubit.getCountryNames;
    emit(ChangeFilters());
  }

  void changeSelectedCountry(BuildContext context, String country) {
    _selectedCountry = country;
    _cities = AppCubit.get(context).getCitiesForCountry(_selectedCountry!);
    _selectedCity = _cities.first;
    emit(ChangeFiltersState());
  }

  void changeSelectedCity(String city) {
    _selectedCity = city;
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
    emit(RemoveAllFiltersState());
  }
}
