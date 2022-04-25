//
abstract class FilterVendorStates {}

class IntitalFilterVendorState extends FilterVendorStates {}

//
//GetAllVendors online fetch data
class GetAllVendorsLoadingState extends FilterVendorStates {}

class GetAllVendorsSuccessState extends FilterVendorStates {}

class GetAllVendorsErrorState extends FilterVendorStates {
  final String error;
  GetAllVendorsErrorState({required this.error});
}

//GetMoreAllVendors online fetch data
class GetMoreAllVendorsLoadingState extends FilterVendorStates {}

class GetMoreAllVendorsSuccessState extends FilterVendorStates {}

class GetMoreAllVendorsErrorState extends FilterVendorStates {
  final String error;
  GetMoreAllVendorsErrorState({required this.error});
}
