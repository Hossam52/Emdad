//
abstract class FilterVendorStates {}

class IntitalFilterVendorState extends FilterVendorStates {}

//
//GetAllVendors online fetch data
class GetVendorsLoadingState extends FilterVendorStates {}

class GetVendorsSuccessState extends FilterVendorStates {}

class GetVendorsErrorState extends FilterVendorStates {
  final String error;
  GetVendorsErrorState({required this.error});
}

//GetMoreAllVendors online fetch data
class GetMoreVendorsLoadingState extends FilterVendorStates {}

class GetMoreVendorsSuccessState extends FilterVendorStates {}

class GetMoreVendorsErrorState extends FilterVendorStates {
  final String error;
  GetMoreVendorsErrorState({required this.error});
}
