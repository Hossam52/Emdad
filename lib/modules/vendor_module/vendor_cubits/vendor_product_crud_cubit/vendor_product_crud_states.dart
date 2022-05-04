//
abstract class VendorProductCrudStates {}

class IntitalVendorProductCrudCubitState extends VendorProductCrudStates {}
//

class ChangePriceVisibility extends VendorProductCrudStates {}

class RemovePriceUnit extends VendorProductCrudStates {}

class AddPriceUnit extends VendorProductCrudStates {}

class RemoveImage extends VendorProductCrudStates {}

class PickImagesSuccess extends VendorProductCrudStates {}

class PickImagesError extends VendorProductCrudStates {
  final String error;
  PickImagesError({
    required this.error,
  });
}

//EditProduct online fetch data
class EditProductLoadingState extends VendorProductCrudStates {}

class EditProductSuccessState extends VendorProductCrudStates {}

class EditProductErrorState extends VendorProductCrudStates {
  final String error;
  EditProductErrorState({required this.error});
}
