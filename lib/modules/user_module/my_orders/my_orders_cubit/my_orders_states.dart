//
abstract class MyOrdersStates {}

class IntitalMyOrdersState extends MyOrdersStates {}

//
//GetMyOrders online fetch data
class GetMyOrdersLoadingState extends MyOrdersStates {}

class GetMyOrdersSuccessState extends MyOrdersStates {}

class GetMyOrdersErrorState extends MyOrdersStates {
  final String error;
  GetMyOrdersErrorState({required this.error});
}

//GetMoreMyOrders online fetch data
class GetMoreMyOrdersLoadingState extends MyOrdersStates {}

class GetMoreMyOrdersSuccessState extends MyOrdersStates {}

class GetMoreMyOrdersErrorState extends MyOrdersStates {
  final String error;
  GetMoreMyOrdersErrorState({required this.error});
}
