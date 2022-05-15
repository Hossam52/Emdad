import 'package:emdad/models/request_models/pagination_request_model.dart';
import 'package:emdad/models/transportations/transportation_supply_requests/transporter_supply_request.dart';
import 'package:emdad/shared/network/services/transporter/transporter_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './transporter_dlivery_orders_states.dart';

//Bloc builder and bloc consumer methods
typedef TransporterDeliveryOrdersBlocBuilder = BlocBuilder<
    TransporterDeliveryOrdersCubit, TransporterDeliveryOrdersStates>;
typedef TransporterDeliveryOrdersBlocConsumer = BlocConsumer<
    TransporterDeliveryOrdersCubit, TransporterDeliveryOrdersStates>;

//
class TransporterDeliveryOrdersCubit
    extends Cubit<TransporterDeliveryOrdersStates> {
  TransporterDeliveryOrdersCubit()
      : super(IntitalTransporterDeliveryOrdersState());
  static TransporterDeliveryOrdersCubit instance(BuildContext context) =>
      BlocProvider.of<TransporterDeliveryOrdersCubit>(context);
  final _services = TransporterServices.instance;

  TransporterSupplyRequestsModel? _model;
  bool get errorOrders => _model == null;
  List<TransporterSupplyRequest> get orders =>
      errorOrders ? List.empty() : _model!.transportationRequests;
  bool get emptyOffers => orders.isEmpty;
  bool get isLastPage => _model?.isLastPage ?? true;

  Future<void> getDeliveryOrders() async {
    try {
      emit(GetDeliveryOrdersLoadingState());
      final map = await _services.ordersServices.getPurchaseOrders(
          pagination: PaginationRequestModel(limit: orders.length));
      _model = TransporterSupplyRequestsModel.fromMap(map);
      emit(GetDeliveryOrdersSuccessState());
    } catch (e) {
      emit(GetDeliveryOrdersErrorState(error: e.toString()));
    }
  }

  Future<void> getMoreDeliveryOrders() async {
    try {
      emit(GetMoreDeliveryOrdersLoadingState());
      final map = await _services.ordersServices.getPurchaseOrders(
          pagination: PaginationRequestModel(paginationToken: orders.last.id));
      final incoming = TransporterSupplyRequestsModel.fromMap(map);
      _model?.appendObjectToCurrent(incoming);
      emit(GetMoreDeliveryOrdersSuccessState());
    } catch (e) {
      emit(GetMoreDeliveryOrdersErrorState(error: e.toString()));
    }
  }
}
