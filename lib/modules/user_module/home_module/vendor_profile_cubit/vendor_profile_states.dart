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

//GetCategoryProducts online fetch data
class GetCategoryProductsLoadingState extends VendorProfileStates {}

class GetCategoryProductsSuccessState extends VendorProfileStates {}

class GetCategoryProductsErrorState extends VendorProfileStates {
  final String error;
  GetCategoryProductsErrorState({required this.error});
}

//GetMoreCategoryProducts online fetch data
class GetMoreCategoryProductsLoadingState extends VendorProfileStates {}

class GetMoreCategoryProductsSuccessState extends VendorProfileStates {}

class GetMoreCategoryProductsErrorState extends VendorProfileStates {
  final String error;
  GetMoreCategoryProductsErrorState({required this.error});
}

//ToggleFavorite online fetch data
class ToggleFavoriteLoadingState extends VendorProfileStates {}

class ToggleFavoriteSuccessState extends VendorProfileStates {}

class ToggleFavoriteErrorState extends VendorProfileStates {
  final String error;
  ToggleFavoriteErrorState({required this.error});
}
