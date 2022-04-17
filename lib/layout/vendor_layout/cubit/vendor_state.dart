part of 'vendor_cubit.dart';

//
abstract class VendorStates {}

class IntitalVendorState extends VendorStates {}
//

class VendorInitial extends VendorStates {}

class ChangeBottomNavBarState extends VendorStates {}

class ChangeCheckBoxState extends VendorStates {}

class DeletePriceDetailsState extends VendorStates {}

class RemoveProductImageStateState extends VendorStates {}

class RemoveProductOtherImagesStateState extends VendorStates {}

class ProductImagePickedSuccessState extends VendorStates {}

class ProductImagePickedErrorState extends VendorStates {}

class ProductPickedMultiImagesSuccessState extends VendorStates {}

class ProductPickedMultiImagesErrorState extends VendorStates {}

//GetAllSuplyRequests online fetch data
class GetAllSuplyRequestsLoadingState extends VendorStates {}

class GetAllSuplyRequestsSuccessState extends VendorStates {}

class GetAllSuplyRequestsErrorState extends VendorStates {
  final String error;
  GetAllSuplyRequestsErrorState({required this.error});
}
