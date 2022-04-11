part of 'vendor_cubit.dart';

@immutable
abstract class VendorState {}

class VendorInitial extends VendorState {}

class ChangeBottomNavBarState extends VendorState {}

class ChangeCheckBoxState extends VendorState {}

class DeletePriceDetailsState extends VendorState {}

class RemoveProductImageStateState extends VendorState {}

class RemoveProductOtherImagesStateState extends VendorState {}

class ProductImagePickedSuccessState extends VendorState {}

class ProductImagePickedErrorState extends VendorState {}

class ProductPickedMultiImagesSuccessState extends VendorState {}

class ProductPickedMultiImagesErrorState extends VendorState {}

