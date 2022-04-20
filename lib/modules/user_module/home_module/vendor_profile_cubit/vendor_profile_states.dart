//
abstract class VendorProfileStates {}

class IntitalVendorProfileState extends VendorProfileStates {}

//
//GetVendorInfo online fetch data
class GetVendorInfoLoadingState extends VendorProfileStates {}

class GetVendorInfoSuccessState extends VendorProfileStates {}

class GetVendorInfoErrorState extends VendorProfileStates {
  final String error;
  GetVendorInfoErrorState({required this.error});
}
