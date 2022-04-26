import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/users/user/supply_requests/all_supply_requests.dart';
import 'package:emdad/modules/user_module/my_orders/my_orders_cubit/my_orders_states.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

//Bloc builder and bloc consumer methods
typedef MyOrdersBlocBuilder = BlocBuilder<MyOrdersCubit, MyOrdersStates>;
typedef MyOrdersBlocConsumer = BlocConsumer<MyOrdersCubit, MyOrdersStates>;

//
class MyOrdersCubit extends Cubit<MyOrdersStates> {
  MyOrdersCubit() : super(IntitalMyOrdersState());
  static MyOrdersCubit instance(BuildContext context) =>
      BlocProvider.of<MyOrdersCubit>(context);
  final _services = UserServices.instance;

  AllSupplyRequestsModel? _supplyRequests;

  List<SupplyRequest> get awaitTransporationOrders =>
      _supplyRequests?.supplyRequests ?? [];

  List<SupplyRequest> get preparingOrders =>
      _supplyRequests?.supplyRequests ?? [];

  List<SupplyRequest> get onWayOrders => _supplyRequests?.supplyRequests ?? [];

  List<SupplyRequest> get deliveredOrders =>
      _supplyRequests?.supplyRequests ?? [];

  bool get errorInMyOrders =>
      _supplyRequests == null; //To know if loaded data successifully
  bool get isLastPage => _supplyRequests!.isLastPage;
  //To get all my orders
  Future<void> getMyOrders() async {
    try {
      emit(GetMyOrdersLoadingState());
      final map = await _services.requestServices.getMyOrders();
      _supplyRequests = AllSupplyRequestsModel.fromMap(map);
      emit(GetMyOrdersSuccessState());
    } catch (e) {
      emit(GetMyOrdersErrorState(error: e.toString()));
    }
  }

  Future<void> getMoreMyOrders() async {
    if (errorInMyOrders ||
        isLastPage ||
        _supplyRequests!.supplyRequests.isEmpty) return;
    try {
      emit(GetMoreMyOrdersLoadingState());
      final map = await _services.requestServices.getMyOrders(
        paginationToken: _supplyRequests!.supplyRequests.last.id,
      );
      final incomingRequests = AllSupplyRequestsModel.fromMap(map);
      _supplyRequests!.appendObjectToCurrent(incomingRequests);
      emit(GetMoreMyOrdersSuccessState());
    } catch (e) {
      emit(GetMoreMyOrdersErrorState(error: e.toString()));
    }
  }
}
