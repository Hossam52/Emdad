import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/request_models/pagination_request_model.dart';
import 'package:emdad/models/request_models/filter_supply_request_model.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/users/user/supply_requests/all_supply_requests.dart';
import 'package:emdad/modules/user_module/vendors_module/change_filters_cubit/change_filters_states.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';

import './offers_states.dart';

//Bloc builder and bloc consumer methods
typedef OffersBlocBuilder = BlocBuilder<OffersCubit, OffersStates>;
typedef OffersBlocConsumer = BlocConsumer<OffersCubit, OffersStates>;

//
class OffersCubit extends Cubit<OffersStates> {
  OffersCubit() : super(IntitalOffersState()) {
    tabItems = [
      OfferTabItem(title: 'بانتظار الموافقة'),
      OfferTabItem(title: 'بانتظار التسعير'),
      OfferTabItem(title: 'الكل'),
    ];
  }
  static OffersCubit instance(BuildContext context) =>
      BlocProvider.of<OffersCubit>(context);
  final _services = UserServices.instance;
  AllSupplyRequestsModel? _requestOffers;
  bool get emptyOffers => _requestOffers == null;
  bool get canLoadMoreOffers => !emptyOffers && !_requestOffers!.isLastPage;
  SortBy _sortOffersBy = SortBy.none;

  //To get offers that has awaiting quotation
  List<SupplyRequest> get offers {
    _assignOrders();
    final offersRequests = tabItems[_selectedTab].orders!;
    // final offersRequests = _requestOffers!.supplyRequests;
    // if (_sortOffersBy == SortBy.none) {
    //   return offersRequests;
    // } else if (_sortOffersBy == SortBy.name) {
    //   return _sortByName(offersRequests);
    // } else if (_sortOffersBy == SortBy.date) {
    //   return _sortByDate(offersRequests);
    // } else {
    // }
    return offersRequests;
  }

  late List<OfferTabItem> tabItems;
  int _selectedTab = 0;
  void changeTabIndex(int index) {
    _selectedTab = index;
    _assignOrders();
    emit(ChangeSortType());
  }

  void _assignOrders() {
    switch (_selectedTab) {
      case 0:
        tabItems[_selectedTab].setOrders = _requestOffers!.awaitingApproval;
        break;
      case 1:
        tabItems[_selectedTab].setOrders = _requestOffers!.awaitingQuotation;
        break;
      case 2:
        tabItems[_selectedTab].setOrders = _requestOffers!.supplyRequests;
        break;
      default:
    }
  }

  bool get sortByName => _sortOffersBy == SortBy.name;
  bool get sortByDate => _sortOffersBy == SortBy.date;
  bool get notSort => _sortOffersBy == SortBy.none;

  void changeSortType(SortBy sortBy) {
    if (sortBy == _sortOffersBy) return;
    _sortOffersBy = sortBy;

    emit(ChangeSortType());
  }

  List<SupplyRequest> _sortByName(List<SupplyRequest> offersRequests) {
    offersRequests.sort(((first, second) => first.vendor.oraganizationName
        .compareTo(second.vendor.oraganizationName)));
    return offersRequests;
  }

  List<SupplyRequest> _sortByDate(List<SupplyRequest> offersRequests) {
    offersRequests
        .sort(((first, second) => first.createdAt.compareTo(second.createdAt)));
    return offersRequests.reversed.toList();
  }

  final _filterSupplyRequest = FilterSupplyRequestModel(requestStatus: [
    SupplyRequestStatus.awaitingQuotation.name,
    SupplyRequestStatus.awaitingApproval.name,
  ]);
  Future<void> getRequestOffers() async {
    try {
      emit(GetRequestOffersLoadingState());
      final map = await _services.requestServices.getRequestOffers(
          _filterSupplyRequest,
          pagination: PaginationRequestModel(
              limit: _requestOffers?.supplyRequests.length ??
                  Constants.paginationSize));
      _requestOffers = AllSupplyRequestsModel.fromMap(map);
      emit(GetRequestOffersSuccessState());
    } catch (e) {
      log(e.toString());
      emit(GetRequestOffersErrorState(error: e.toString()));
      rethrow;
    }
  }

  Future<void> getMoreRequestOffers() async {
    try {
      emit(GetMoreRequestOffersLoadingState());
      final map = await _services.requestServices.getRequestOffers(
          _filterSupplyRequest,
          pagination: PaginationRequestModel(
              paginationToken: _requestOffers!.supplyRequests.last.id
              //  offers.last.id
              ));
      final incomingSupply = AllSupplyRequestsModel.fromMap(map);
      _requestOffers!.appendObjectToCurrent(incomingSupply);

      emit(GetMoreRequestOffersSuccessState());
    } catch (e) {
      emit(GetMoreRequestOffersErrorState(error: e.toString()));
    }
  }
}

class OfferTabItem {
  String title;
  List<SupplyRequest>? orders;
  OfferTabItem({
    required this.title,
    this.orders,
  });
  set setOrders(List<SupplyRequest> orders) => this.orders = orders;
  bool get isErrorOrders => orders == null;
}
