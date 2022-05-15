//
abstract class TransporterDeliveryOrdersStates {}

class IntitalTransporterDeliveryOrdersState
    extends TransporterDeliveryOrdersStates {}

//
//GetDeliveryOrders online fetch data
class GetDeliveryOrdersLoadingState extends TransporterDeliveryOrdersStates {}

class GetDeliveryOrdersSuccessState extends TransporterDeliveryOrdersStates {}

class GetDeliveryOrdersErrorState extends TransporterDeliveryOrdersStates {
  final String error;
  GetDeliveryOrdersErrorState({required this.error});
}

//GetMoreDeliveryOrders online fetch data
class GetMoreDeliveryOrdersLoadingState
    extends TransporterDeliveryOrdersStates {}

class GetMoreDeliveryOrdersSuccessState
    extends TransporterDeliveryOrdersStates {}

class GetMoreDeliveryOrdersErrorState extends TransporterDeliveryOrdersStates {
  final String error;
  GetMoreDeliveryOrdersErrorState({required this.error});
}
