import 'package:emdad/models/request_models/filter_supply_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/request_models/pagination_request_model.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/users/user/supply_requests/all_supply_requests.dart';
import 'package:emdad/modules/user_module/my_orders/my_orders_cubit/my_orders_states.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';

//Bloc builder and bloc consumer methods
typedef MyOrdersBlocBuilder = BlocBuilder<MyOrdersCubit, MyOrdersStates>;
typedef MyOrdersBlocConsumer = BlocConsumer<MyOrdersCubit, MyOrdersStates>;

//
class MyOrdersCubit extends Cubit<MyOrdersStates> {
  MyOrdersCubit() : super(IntitalMyOrdersState()) {
    details = [
      OrderTabDetails(
          title: 'منتظر النقل',
          supplyRequestStatus: SupplyRequestStatus.awaitingTransportation,
          getOrders: () => getMyOrders(),
          getMoreOrders: () => getMoreMyOrders()),
      OrderTabDetails(
          supplyRequestStatus: SupplyRequestStatus.preparing,
          title: 'قيد التحميل',
          getOrders: () => getMyOrders(),
          getMoreOrders: () => getMoreMyOrders()),
      OrderTabDetails(
          supplyRequestStatus: SupplyRequestStatus.onWay,
          title: 'قيد التوصيل',
          getOrders: () => getMyOrders(),
          getMoreOrders: () => getMoreMyOrders()),
      OrderTabDetails(
          supplyRequestStatus: SupplyRequestStatus.delivered,
          title: 'عمليات ناجحة',
          getOrders: () => getMyOrders(),
          getMoreOrders: () => getMoreMyOrders()),
    ];
  }
  static MyOrdersCubit instance(BuildContext context) =>
      BlocProvider.of<MyOrdersCubit>(context);

  int selectedTabIndex = 0;
  set changeSelectedTabIndex(int val) {
    selectedTabIndex = val;
    emit(ChangeTabIndexState());
    if (orderTab.isOrderNotLoaded) {
      orderTab.getOrders();
    }
  }

  OrderTabDetails get orderTab => details[selectedTabIndex];

  final _services = UserServices.instance;
  late List<OrderTabDetails> details;
  //To get all my orders
  Future<void> getMyOrders() async {
    try {
      emit(GetMyOrdersLoadingState());
      final map = await _services.requestServices.getMyOrders(
          FilterSupplyRequestModel(
              requestStatus: [orderTab.supplyRequestStatus.name]),
          pagination: PaginationRequestModel(limit: orderTab.orders.length));
      // _supplyRequests = AllSupplyRequestsModel.fromMap(map);
      orderTab.setOrders = AllSupplyRequestsModel.fromMap(map);
      emit(GetMyOrdersSuccessState());
    } catch (e) {
      emit(GetMyOrdersErrorState(error: e.toString()));
    }
  }

  Future<void> getMoreMyOrders() async {
    if (orderTab.isOrderNotLoaded ||
        orderTab.isLastPage ||
        orderTab.orders.isEmpty) return;

    emit(GetMoreMyOrdersLoadingState());
    final map = await _services.requestServices.getMyOrders(
      FilterSupplyRequestModel(
          requestStatus: [orderTab.supplyRequestStatus.name]),
      pagination: PaginationRequestModel(
        paginationToken: orderTab.orders.last.id,
      ),
    );
    final incomingRequests = AllSupplyRequestsModel.fromMap(map);
    // _supplyRequests!.appendObjectToCurrent(incomingRequests);
    orderTab._orders!.appendObjectToCurrent(incomingRequests);
    emit(GetMoreMyOrdersSuccessState());
    try {} catch (e) {
      emit(GetMoreMyOrdersErrorState(error: e.toString()));
    }
  }
}

class OrderTabDetails {
  String title;
  SupplyRequestStatus supplyRequestStatus;
  Future<void> Function() getOrders;
  Future<void> Function() getMoreOrders;
  AllSupplyRequestsModel? _orders;
  OrderTabDetails({
    required this.title,
    required this.supplyRequestStatus,
    required this.getOrders,
    required this.getMoreOrders,
  });
  set setOrders(AllSupplyRequestsModel allSupplyRequestsModel) {
    _orders = allSupplyRequestsModel;
  }

  bool get isOrderNotLoaded => _orders == null;
  bool get isLastPage => isOrderNotLoaded ? true : _orders!.isLastPage;
  List<SupplyRequest> get orders => _orders?.supplyRequests ?? [];
}
