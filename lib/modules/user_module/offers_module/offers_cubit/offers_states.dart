//
abstract class OffersStates {}

class IntitalOffersState extends OffersStates {}

class ChangeSortType extends OffersStates {}

//
//GetRequestOffers online fetch data
class GetRequestOffersLoadingState extends OffersStates {}

class GetRequestOffersSuccessState extends OffersStates {}

class GetRequestOffersErrorState extends OffersStates {
  final String error;
  GetRequestOffersErrorState({required this.error});
}

//GetMoreRequestOffers online fetch data
class GetMoreRequestOffersLoadingState extends OffersStates {}

class GetMoreRequestOffersSuccessState extends OffersStates {}

class GetMoreRequestOffersErrorState extends OffersStates {
  final String error;
  GetMoreRequestOffersErrorState({required this.error});
}
