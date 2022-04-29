//
abstract class VendorOffersStates {}

class IntitalVendorOffersState extends VendorOffersStates {}

//
//GetVendorOffers online fetch data
class GetVendorOffersLoadingState extends VendorOffersStates {}

class GetVendorOffersSuccessState extends VendorOffersStates {}

class GetVendorOffersErrorState extends VendorOffersStates {
  final String error;
  GetVendorOffersErrorState({required this.error});
}
