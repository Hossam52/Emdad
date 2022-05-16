//
abstract class UserShippingOffersStates {}

class IntitalUserShippingOffersState extends UserShippingOffersStates {}
//

//GetUserTransportationOffers online fetch data
class GetUserTransportationOffersLoadingState extends UserShippingOffersStates {
}

class GetUserTransportationOffersSuccessState extends UserShippingOffersStates {
}

class GetUserTransportationOffersErrorState extends UserShippingOffersStates {
  final String error;
  GetUserTransportationOffersErrorState({required this.error});
}

//AcceptTransportationOffer online fetch data
class AcceptUserTransportationOfferLoadingState
    extends UserShippingOffersStates {}

class AcceptUserTransportationOfferSuccessState
    extends UserShippingOffersStates {}

class AcceptUserTransportationOfferErrorState extends UserShippingOffersStates {
  final String error;
  AcceptUserTransportationOfferErrorState({required this.error});
}
