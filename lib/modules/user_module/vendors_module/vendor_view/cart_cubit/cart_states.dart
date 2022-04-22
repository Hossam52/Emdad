//
abstract class CartStates {}

class IntitalCartState extends CartStates {}

//
class EditAndAddToCartState extends CartStates {}

class RemoveFromCartState extends CartStates {}

class ToggleHasTransportationState extends CartStates {}

class RemoveAdditionalItem extends CartStates {}

class SuccessAddAdditionalItem extends CartStates {}

class ErrorAddAdditionalItem extends CartStates {
  final String error;

  ErrorAddAdditionalItem(this.error);
}

//CreateRequest online fetch data
class CreateRequestLoadingState extends CartStates {}

class CreateRequestSuccessState extends CartStates {}

class CreateRequestErrorState extends CartStates {
  final String error;
  CreateRequestErrorState({required this.error});
}
