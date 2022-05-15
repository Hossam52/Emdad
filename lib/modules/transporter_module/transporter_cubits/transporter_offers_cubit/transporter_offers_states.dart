//
abstract class TransporterOffersStates {}

class IntitalTransporterOffersState extends TransporterOffersStates {}
//

//GetOffers online fetch data
class GetOffersLoadingState extends TransporterOffersStates {}

class GetOffersSuccessState extends TransporterOffersStates {}

class GetOffersErrorState extends TransporterOffersStates {
  final String error;
  GetOffersErrorState({required this.error});
}
//GetMoreOffers online fetch data
class GetMoreOffersLoadingState extends TransporterOffersStates {}
class GetMoreOffersSuccessState extends TransporterOffersStates {}
class GetMoreOffersErrorState extends TransporterOffersStates {
  final String error;
  GetMoreOffersErrorState({required this.error});
}
