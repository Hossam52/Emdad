import 'dart:developer';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/request_models/filter_supply_request_model.dart';
import 'package:emdad/models/request_models/pagination_request_model.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/users/user/supply_requests/all_supply_requests.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/network/services/vendor/vendor_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './vendor_offers_states.dart';

//Bloc builder and bloc consumer methods
typedef VendorOffersBlocBuilder
    = BlocBuilder<VendorOffersCubit, VendorOffersStates>;
typedef VendorOffersBlocConsumer
    = BlocConsumer<VendorOffersCubit, VendorOffersStates>;

//
class VendorOffersCubit extends Cubit<VendorOffersStates> {
  VendorOffersCubit() : super(IntitalVendorOffersState());
  static VendorOffersCubit instance(BuildContext context) =>
      BlocProvider.of<VendorOffersCubit>(context);
  final _vendorServices = VendorServices.instance;

  //APIS
  AllSupplyRequestsModel? _allVendorRequests;
  bool get hasErrorOnLoadOffers => _allVendorRequests == null;
  bool get isLastPage =>
      hasErrorOnLoadOffers || _allVendorRequests!.isLastPage ? true : false;

  List<SupplyRequest> get offers {
    if (hasErrorOnLoadOffers) {
      return [];
    } else {
      return _allVendorRequests!.supplyRequests;
    }
  }

  FilterSupplyRequestModel get _getFilters => FilterSupplyRequestModel(
      requestStatus: [SupplyRequestStatus.awaitingQuotation.name]);

  Future<void> getVendorOffers() async {
    try {
      emit(GetVendorOffersLoadingState());
      final map = await _vendorServices.getAllSuplayRequests(
          filterOrders: _getFilters,
          pagination: PaginationRequestModel(limit: offers.length));
      final allRequestModel = AllSupplyRequestsModel.fromMap(map);
      if (allRequestModel.status) {
        _allVendorRequests = allRequestModel;
        for (var e in allRequestModel.supplyRequests) {
          log(e.requestStatus);
        }
      } else {
        throw allRequestModel.message;
      }
      emit(GetVendorOffersSuccessState());
    } catch (e) {
      emit(GetVendorOffersErrorState(error: e.toString()));
    }
  }

  Future<void> getMoreVendorOffers() async {
    try {
      emit(GetMoreVendorOffersLoadingState());
      final map = await _vendorServices.getAllSuplayRequests(
          filterOrders: _getFilters,
          pagination: PaginationRequestModel(paginationToken: offers.last.id));
      final allRequestModel = AllSupplyRequestsModel.fromMap(map);
      if (allRequestModel.status) {
        _allVendorRequests!.appendObjectToCurrent(allRequestModel);
      } else {
        throw allRequestModel.message;
      }
      emit(GetMoreVendorOffersSuccessState());
    } catch (e) {
      emit(GetMoreVendorOffersErrorState(error: e.toString()));
    }
  }
}
