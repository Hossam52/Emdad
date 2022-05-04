//
abstract class VendorProductStates {}

class IntitalProductState extends VendorProductStates {}

//
//GetAllVendorProducts online fetch data
class GetAllVendorProductsLoadingState extends VendorProductStates {}

class GetAllVendorProductsSuccessState extends VendorProductStates {}

class GetAllVendorProductsErrorState extends VendorProductStates {
  final String error;
  GetAllVendorProductsErrorState({required this.error});
}

//GetMoreMyProducts online fetch data
class GetMoreMyProductsLoadingState extends VendorProductStates {}

class GetMoreMyProductsSuccessState extends VendorProductStates {}

class GetMoreMyProductsErrorState extends VendorProductStates {
  final String error;
  GetMoreMyProductsErrorState({required this.error});
}
