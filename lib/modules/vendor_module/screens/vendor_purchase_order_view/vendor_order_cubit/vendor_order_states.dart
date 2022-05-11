//
abstract class VendorOrderStates {}

class IntitalVendorOrderState extends VendorOrderStates {}

//
class EditItemPriceState extends VendorOrderStates {}

class EditAdditionalItemPriceState extends VendorOrderStates {}

class EditShippingPriceState extends VendorOrderStates {}

class ChangeVendorManageTransportationState extends VendorOrderStates {}

//GetVendorOrder online fetch data
class GetVendorOrderLoadingState extends VendorOrderStates {}

class GetVendorOrderSuccessState extends VendorOrderStates {}

class GetVendorOrderErrorState extends VendorOrderStates {
  final String error;
  GetVendorOrderErrorState({required this.error});
}

//QuoteOrder online fetch data
class QuoteOrderLoadingState extends VendorOrderStates {}

class QuoteOrderSuccessState extends VendorOrderStates {}

class QuoteOrderErrorState extends VendorOrderStates {
  final String error;
  QuoteOrderErrorState({required this.error});
}

//CreateVendorTransportationRequest online fetch data
class CreateVendorTransportationRequestLoadingState extends VendorOrderStates {}

class CreateVendorTransportationRequestSuccessState extends VendorOrderStates {}

class CreateVendorTransportationRequestErrorState extends VendorOrderStates {
  final String error;
  CreateVendorTransportationRequestErrorState({required this.error});
}
