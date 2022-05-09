//
abstract class VendorShippingOffersStates {}

class IntitalVendorShippingOffersState extends VendorShippingOffersStates {}
//

//GetVendorTransportationOffers online fetch data
class GetVendorTransportationOffersLoadingState
    extends VendorShippingOffersStates {}

class GetVendorTransportationOffersSuccessState
    extends VendorShippingOffersStates {}

class GetVendorTransportationOffersErrorState
    extends VendorShippingOffersStates {
  final String error;
  GetVendorTransportationOffersErrorState({required this.error});
}

//AcceptTransportationOffer online fetch data
class AcceptTransportationOfferLoadingState extends VendorShippingOffersStates {
}

class AcceptTransportationOfferSuccessState extends VendorShippingOffersStates {
}

class AcceptTransportationOfferErrorState extends VendorShippingOffersStates {
  final String error;
  AcceptTransportationOfferErrorState({required this.error});
}
