import 'dart:developer';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/request_models/pagination_request_model.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/users/vendor/all_vendor_request_model.dart';
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
  AllVendorRequestsModel? _allVendorRequests;
  bool get hasErrorOnLoadOffers => _allVendorRequests == null;

  List<SupplyRequest> get offers {
    if (hasErrorOnLoadOffers) {
      return [];
    } else {
      return _allVendorRequests!.supplyRequests
          .where((order) =>
              order.requestStatusEnum == SupplyRequestStatus.awaitingQuotation)
          .toList();
    }
  }

  Future<void> getVendorOffers() async {
    try {
      emit(GetVendorOffersLoadingState());
      final map = await _vendorServices.getAllSuplayRequests(
          pagination: PaginationRequestModel(
              paginationToken: '627905e6754d91ac363d5c67'));
      final allRequestModel = AllVendorRequestsModel.fromMap(map);
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
}
