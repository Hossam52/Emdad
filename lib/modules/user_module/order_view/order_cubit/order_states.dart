//
abstract class OrderStates {}

class IntitalOrderState extends OrderStates {}
//

//GetOrder online fetch data
class GetOrderLoadingState extends OrderStates {}

class GetOrderSuccessState extends OrderStates {}

class GetOrderErrorState extends OrderStates {
  final String error;
  GetOrderErrorState({required this.error});
}

//CreateTransportationRequest online fetch data
class CreateTransportationRequestLoadingState extends OrderStates {}

class CreateTransportationRequestSuccessState extends OrderStates {}

class CreateTransportationRequestErrorState extends OrderStates {
  final String error;
  CreateTransportationRequestErrorState({required this.error});
}

//AcceptSupplyOffer online fetch data
class AcceptSupplyOfferLoadingState extends OrderStates {}

class AcceptSupplyOfferSuccessState extends OrderStates {}

class AcceptSupplyOfferErrorState extends OrderStates {
  final String error;
  AcceptSupplyOfferErrorState({required this.error});
}

//CreateTransportRequest online fetch data
class CreateTransportRequestLoadingState extends OrderStates {}

class CreateTransportRequestSuccessState extends OrderStates {}

class CreateTransportRequestErrorState extends OrderStates {
  final String error;
  CreateTransportRequestErrorState({required this.error});
}
