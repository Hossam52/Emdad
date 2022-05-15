import 'package:emdad/models/request_models/pagination_request_model.dart';
import 'package:emdad/models/transportations/transportation_supply_requests/transporter_supply_request.dart';
import 'package:emdad/shared/network/services/transporter/transporter_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './transporter_offers_states.dart';

//Bloc builder and bloc consumer methods
typedef TransporterOffersBlocBuilder
    = BlocBuilder<TransporterOffersCubit, TransporterOffersStates>;
typedef TransporterOffersBlocConsumer
    = BlocConsumer<TransporterOffersCubit, TransporterOffersStates>;

//
class TransporterOffersCubit extends Cubit<TransporterOffersStates> {
  TransporterOffersCubit() : super(IntitalTransporterOffersState());
  static TransporterOffersCubit instance(BuildContext context) =>
      BlocProvider.of<TransporterOffersCubit>(context);
  final _services = TransporterServices.instance;

  TransporterSupplyRequestsModel? _model;
  bool get errorOffers => _model == null;
  List<TransporterSupplyRequest> get offers =>
      errorOffers ? List.empty() : _model!.transportationRequests;
  bool get emptyOffers => offers.isEmpty;
  bool get isLastPage => _model?.isLastPage ?? true;

  Future<void> getOffers() async {
    try {
      emit(GetOffersLoadingState());
      final map = await _services.ordersServices
          .getOffers(pagination: PaginationRequestModel(limit: offers.length));
      _model = TransporterSupplyRequestsModel.fromMap(map);
      emit(GetOffersSuccessState());
    } catch (e) {
      emit(GetOffersErrorState(error: e.toString()));
      rethrow;
    }
  }

  Future<void> getMoreOffers() async {
    if (offers.isEmpty) return;
    try {
      emit(GetMoreOffersLoadingState());
      final map = await _services.ordersServices.getOffers(
          pagination: PaginationRequestModel(paginationToken: offers.last.id));
      final incoming = TransporterSupplyRequestsModel.fromMap(map);
      _model?.appendObjectToCurrent(incoming);
      emit(GetMoreOffersSuccessState());
    } catch (e) {
      emit(GetMoreOffersErrorState(error: e.toString()));
    }
  }
}
