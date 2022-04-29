import 'dart:developer';

import 'package:emdad/models/request_models/user/filter_vendors_request.dart';
import 'package:emdad/models/users/user/all_vendors_model.dart';
import 'package:emdad/models/users/user/user_response_model.dart';
import 'package:emdad/modules/user_module/vendors_module/filter_vendor_cubit/filter_vendor_states.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

//Bloc builder and bloc consumer methods
typedef FilterVendorBlocBuilder
    = BlocBuilder<FilterVendorCubit, FilterVendorStates>;
typedef FilterVendorBlocConsumer
    = BlocConsumer<FilterVendorCubit, FilterVendorStates>;

//
class FilterVendorCubit extends Cubit<FilterVendorStates> {
  FilterVendorCubit() : super(IntitalFilterVendorState());
  static FilterVendorCubit instance(BuildContext context) =>
      BlocProvider.of<FilterVendorCubit>(context);
  final _services = UserServices.instance;

  //To get all vendors data in filter
  AllVendorsModel? _allVendors;
  List<User> get vendors => _allVendors?.vendors ?? [];
  bool get errorVendors => _allVendors == null;

  //To know if it is last page or not
  bool get isLastVendorPgae {
    if (state is GetAllVendorsLoadingState) {
      return true;
    }
    return (_allVendors?.isLastPage ?? false);
  }

  FilterVendorRequest? _filters;

  void setFilters({String? query, String? city, List<String>? vendorType}) =>
      _filters = FilterVendorRequest(
          searchQuery: query, city: city, vendorType: vendorType);

  void removeVendorTypeFromFilters(String vendorType) {
    _filters?.vendorType?.removeWhere((element) => element == vendorType);
  }

  Future<void> getAllVendors() async {
    try {
      emit(GetAllVendorsLoadingState());
      final map = await _services.userVendorServices
          .allVendors(filterRequest: _filters);
      _allVendors = AllVendorsModel.fromMap(map);
      emit(GetAllVendorsSuccessState());
    } catch (e) {
      log(e.toString());
      emit(GetAllVendorsErrorState(error: e.toString()));
    }
  }

  Future<void> getMoreAllVendors() async {
    if (_allVendors!.isLastPage) return;
    try {
      emit(GetMoreAllVendorsLoadingState());
      final map = await _services.userVendorServices.allVendors(
          filterRequest: _filters?.copyWith(paginationToken: vendors.last.id) ??
              FilterVendorRequest(paginationToken: vendors.last.id));
      final vendorsModel = AllVendorsModel.fromMap(map);
      _appendAllVendors(vendorsModel);
      emit(GetMoreAllVendorsSuccessState());
    } catch (e) {
      emit(GetMoreAllVendorsErrorState(error: e.toString()));
    }
  }

  void _appendAllVendors(AllVendorsModel incomingVenodors) {
    _allVendors!.vendors.addAll(incomingVenodors.vendors);
    _allVendors!.setLastPage = incomingVenodors.isLastPage;
  }
}
