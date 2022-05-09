import 'package:emdad/models/request_models/pagination_request_model.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/users/user/supply_requests/all_supply_requests.dart';
import 'package:emdad/shared/network/services/vendor/vendor_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './purchase_orders_states.dart';

//Bloc builder and bloc consumer methods
typedef PurchaseOrdersBlocBuilder
    = BlocBuilder<PurchaseOrdersCubit, PurchaseOrdersStates>;
typedef PurchaseOrdersBlocConsumer
    = BlocConsumer<PurchaseOrdersCubit, PurchaseOrdersStates>;

//
class PurchaseOrdersCubit extends Cubit<PurchaseOrdersStates> {
  PurchaseOrdersCubit() : super(IntitalPurchaseOrdersState());
  static PurchaseOrdersCubit instance(BuildContext context) =>
      BlocProvider.of<PurchaseOrdersCubit>(context);
  final _vendorServices = VendorServices.instance;

  AllSupplyRequestsModel? _ordersModel;
  List<SupplyRequest> get orders => _ordersModel?.preparingRequests ?? [];
  bool get errorInOrders => _ordersModel == null;
  bool get isLastPage => _ordersModel?.isLastPage ?? true;

  Future<void> getPurchaseOrders() async {
    try {
      emit(GetPurchaseOrdersLoadingState());
      final map = await _vendorServices.getAllSuplayRequests(
          pagination: PaginationRequestModel(limit: orders.length));
      _ordersModel = AllSupplyRequestsModel.fromMap(map);
      emit(GetPurchaseOrdersSuccessState());
    } catch (e) {
      emit(GetPurchaseOrdersErrorState(error: e.toString()));
    }
  }

  Future<void> getMorePurchaseOrders() async {
    try {
      emit(GetMorePurchaseOrdersLoadingState());
      final map = await _vendorServices.getAllSuplayRequests(
          pagination: PaginationRequestModel(paginationToken: orders.last.id));
      final incomingOrders = AllSupplyRequestsModel.fromMap(map);
      _ordersModel!.appendObjectToCurrent(incomingOrders);
      emit(GetMorePurchaseOrdersSuccessState());
    } catch (e) {
      emit(GetMorePurchaseOrdersErrorState(error: e.toString()));
    }
  }
}
