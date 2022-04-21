//
abstract class OffersStates {}

class IntitalOffersState extends OffersStates {}

//
//GetRequestOffers online fetch data
class GetRequestOffersLoadingState extends OffersStates {}

class GetRequestOffersSuccessState extends OffersStates {}

class GetRequestOffersErrorState extends OffersStates {
  final String error;
  GetRequestOffersErrorState({required this.error});
}
