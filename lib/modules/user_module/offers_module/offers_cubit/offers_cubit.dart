import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/users/user/supply_requests/all_supply_requests.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './offers_states.dart';

//Bloc builder and bloc consumer methods
typedef OffersBlocBuilder = BlocBuilder<OffersCubit, OffersStates>;
typedef OffersBlocConsumer = BlocConsumer<OffersCubit, OffersStates>;

//
class OffersCubit extends Cubit<OffersStates> {
  OffersCubit() : super(IntitalOffersState());
  static OffersCubit instance(BuildContext context) =>
      BlocProvider.of<OffersCubit>(context);
  final _services = UserServices.instance;
  AllSupplyRequestsModel? _requestOffers;
  bool get emptyOffers => _requestOffers == null;
  //To get offers that has awaiting quotation
  List<SupplyRequest> get offers {
    return _requestOffers!.supplyRequests
        .where((request) =>
            request.requestStatusEnum == SupplyRequestStatus.awaitingQuotation)
        .toList();
  }

  Future<void> getRequestOffers() async {
    try {
      emit(GetRequestOffersLoadingState());
      final map = await _services.requestServices.getRequestOffers();
      _requestOffers = AllSupplyRequestsModel.fromMap(map);
      emit(GetRequestOffersSuccessState());
    } catch (e) {
      emit(GetRequestOffersErrorState(error: e.toString()));
    }
  }
}
