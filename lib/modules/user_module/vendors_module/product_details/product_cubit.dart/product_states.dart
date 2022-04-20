//
abstract class ProductStates {}

class IntitalProductState extends ProductStates {}

//
//GetProduct online fetch data
class GetProductLoadingState extends ProductStates {}

class GetProductSuccessState extends ProductStates {}

class GetProductErrorState extends ProductStates {
  final String error;
  GetProductErrorState({required this.error});
}

//ToggleProductFavorite online fetch data
class ToggleProductFavoriteLoadingState extends ProductStates {}

class ToggleProductFavoriteSuccessState extends ProductStates {}

class ToggleProductFavoriteErrorState extends ProductStates {
  final String error;
  ToggleProductFavoriteErrorState({required this.error});
}
