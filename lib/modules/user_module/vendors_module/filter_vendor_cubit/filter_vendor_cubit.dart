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
  FilterVendorCubit(this.favoriteVendors) : super(IntitalFilterVendorState());
  static FilterVendorCubit instance(BuildContext context) =>
      BlocProvider.of<FilterVendorCubit>(context);

  final bool favoriteVendors;
  final _services = UserServices.instance;

  //To get all vendors data in filter
  AllVendorsModel? _allVendors;
  List<User> get vendors => _allVendors?.vendors ?? [];
  bool get errorVendors => _allVendors == null;

  //To know if it is last page or not
  bool get isLastVendorPgae {
    if (state is GetVendorsLoadingState) {
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

  Future<void> getVendors() async {
    if (favoriteVendors) {
      await _getFavoriteVendors();
    } else {
      await _getAllVendors();
    }
  }

  Future<void> _getAllVendors() async {
    try {
      emit(GetVendorsLoadingState());
      final map = await _services.userVendorServices
          .allVendors(filterRequest: _filters);
      _allVendors = AllVendorsModel.fromMap(map);
      emit(GetVendorsSuccessState());
    } catch (e) {
      log(e.toString());
      emit(GetVendorsErrorState(error: e.toString()));
    }
  }

  Future<void> _getFavoriteVendors() async {
    try {
      emit(GetVendorsLoadingState());
      final map = await _services.userVendorServices
          .favoriteVendors(filterRequest: _filters);
      _allVendors = FavoriteVendorsModel.fromMap(map);
      emit(GetVendorsSuccessState());
    } catch (e) {
      log(e.toString());
      emit(GetVendorsErrorState(error: e.toString()));
    }
  }

  Future<void> getMoreVendors() async {
    if (_allVendors!.isLastPage) return;
    if (favoriteVendors) {
      await _getMoreFavoriteVendors();
    } else {
      await _getMoreAllVendors();
    }
  }

  Future<void> _getMoreAllVendors() async {
    try {
      emit(GetMoreVendorsLoadingState());
      final map = await _services.userVendorServices.allVendors(
          filterRequest: _filters?.copyWith(paginationToken: vendors.last.id) ??
              FilterVendorRequest(paginationToken: vendors.last.id));
      final vendorsModel = AllVendorsModel.fromMap(map);
      _appendAllVendors(vendorsModel);
      emit(GetMoreVendorsSuccessState());
    } catch (e) {
      emit(GetMoreVendorsErrorState(error: e.toString()));
    }
  }

  Future<void> _getMoreFavoriteVendors() async {
    try {
      emit(GetMoreVendorsLoadingState());
      final map = await _services.userVendorServices.favoriteVendors(
          filterRequest: _filters?.copyWith(paginationToken: vendors.last.id) ??
              FilterVendorRequest(paginationToken: vendors.last.id));
      final vendorsModel = FavoriteVendorsModel.fromMap(map);
      _appendAllVendors(vendorsModel);
      emit(GetMoreVendorsSuccessState());
    } catch (e) {
      emit(GetMoreVendorsErrorState(error: e.toString()));
      rethrow;
    }
  }

  void _appendAllVendors(AllVendorsModel incomingVenodors) {
    _allVendors!.vendors.addAll(incomingVenodors.vendors);
    _allVendors!.setLastPage = incomingVenodors.isLastPage;
  }
}
