//TODO: implement the search cubit to be used in transporter, user and vendor

import 'package:emdad/common_cubits/filter_supply_requests_cubit/filter_supply_requests_states.dart';
import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/transportations/transportation_offer_model.dart';
import 'package:emdad/models/transportations/transportation_supply_requests/transporter_supply_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

//Bloc builder and bloc consumer methods
typedef FilterSuuplyRequestsBlocBuilder
    = BlocBuilder<FilterSuuplyRequestsCubit, FilterSuuplyRequestsStates>;
typedef FilterSuuplyRequestsBlocConsumer
    = BlocConsumer<FilterSuuplyRequestsCubit, FilterSuuplyRequestsStates>;

//
class FilterSuuplyRequestsCubit extends Cubit<FilterSuuplyRequestsStates> {
  FilterSuuplyRequestsCubit(this._originalSupplyRequests)
      : super(IntitalFilterSuuplyRequestsState()); //To filter supply requests

  FilterSuuplyRequestsCubit.transporterOrders(this._originalTransSupplyRequests)
      : super(IntitalFilterSuuplyRequestsState());

  FilterSuuplyRequestsCubit.transportationOffers(
      this._originalTransportationOffers)
      : super(IntitalFilterSuuplyRequestsState());

  static FilterSuuplyRequestsCubit instance(BuildContext context) =>
      BlocProvider.of<FilterSuuplyRequestsCubit>(context);

  late final List<SupplyRequest> _originalSupplyRequests;
  late final List<TransporterSupplyRequest> _originalTransSupplyRequests;
  late final List<TransportationOfferModel> _originalTransportationOffers;
  SortBy _sortOffersBy = SortBy.date;

  bool get sortByName => _sortOffersBy == SortBy.name;
  bool get sortByDate => _sortOffersBy == SortBy.date;
  bool get notSort => _sortOffersBy == SortBy.none;

  void changeSortType(SortBy sortBy) {
    if (sortBy == _sortOffersBy) return;
    _sortOffersBy = sortBy;

    emit(ChangeSortType());
  }

//For sort supply requests
  List<SupplyRequest> _sortSupplyRequestsByName(
      List<SupplyRequest> offersRequests) {
    offersRequests.sort(
        ((first, second) => first.vendor.name.compareTo(second.vendor.name)));
    return offersRequests;
  }

  List<SupplyRequest> _sortSupplyRequestsByDate(
      List<SupplyRequest> offersRequests) {
    offersRequests
        .sort(((first, second) => first.createdAt.compareTo(second.createdAt)));
    return offersRequests.reversed.toList();
  }

  List<SupplyRequest> get supplyRequests {
    switch (_sortOffersBy) {
      case SortBy.name:
        return _sortSupplyRequestsByName(_originalSupplyRequests);
      case SortBy.date:
        return _sortSupplyRequestsByDate(_originalSupplyRequests);
      default:
        return _originalSupplyRequests;
    }
  }

//For sort transporter requests
  List<TransporterSupplyRequest> _sortTransportSupplyRequestsByName() {
    final requests =
        List<TransporterSupplyRequest>.from(_originalTransSupplyRequests);
    requests.sort(((first, second) => first.requester.oraganizationName
        .compareTo(second.requester.oraganizationName)));
    return requests;
  }

  List<TransporterSupplyRequest> _sortTransportSupplyRequestsByDate() {
    final requests =
        List<TransporterSupplyRequest>.from(_originalTransSupplyRequests);
    requests
        .sort(((first, second) => first.createdAt.compareTo(second.createdAt)));
    return requests.reversed.toList();
  }

  List<TransporterSupplyRequest> get transporterSupplyRequests {
    switch (_sortOffersBy) {
      case SortBy.name:
        return _sortTransportSupplyRequestsByName();
      case SortBy.date:
        return _sortTransportSupplyRequestsByDate();
      default:
        return _originalTransSupplyRequests;
    }
  }

//For sort transporter offers
  List<TransportationOfferModel> _sortTransportationOffersByName() {
    final requests =
        List<TransportationOfferModel>.from(_originalTransportationOffers);
    requests.sort(((first, second) => first.transporter.oraganizationName
        .compareTo(second.transporter.oraganizationName)));
    return requests;
  }

  List<TransportationOfferModel> _sortTransportationOffersByDate() {
    final requests =
        List<TransportationOfferModel>.from(_originalTransportationOffers);
    requests
        .sort(((first, second) => first.createdAt.compareTo(second.createdAt)));
    return requests.reversed.toList();
  }

  List<TransportationOfferModel> get transportationOffers {
    switch (_sortOffersBy) {
      case SortBy.name:
        return _sortTransportationOffersByName();
      case SortBy.date:
        return _sortTransportationOffersByDate();
      default:
        return _originalTransportationOffers;
    }
  }
}
