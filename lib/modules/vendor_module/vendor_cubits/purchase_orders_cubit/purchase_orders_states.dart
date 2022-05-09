//
abstract class PurchaseOrdersStates {}

class IntitalPurchaseOrdersState extends PurchaseOrdersStates {}

//
//GetPurchaseOrders online fetch data
class GetPurchaseOrdersLoadingState extends PurchaseOrdersStates {}

class GetPurchaseOrdersSuccessState extends PurchaseOrdersStates {}

class GetPurchaseOrdersErrorState extends PurchaseOrdersStates {
  final String error;
  GetPurchaseOrdersErrorState({required this.error});
}

//GetMorePurchaseOrders online fetch data
class GetMorePurchaseOrdersLoadingState extends PurchaseOrdersStates {}

class GetMorePurchaseOrdersSuccessState extends PurchaseOrdersStates {}

class GetMorePurchaseOrdersErrorState extends PurchaseOrdersStates {
  final String error;
  GetMorePurchaseOrdersErrorState({required this.error});
}
