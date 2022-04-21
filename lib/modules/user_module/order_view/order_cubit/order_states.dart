//
abstract class OrderStates {}

class IntitalOrderState extends OrderStates {}
//

//GetOrder online fetch data
class GetOrderLoadingState extends OrderStates {}

class GetOrderSuccessState extends OrderStates {}

class GetOrderErrorState extends OrderStates {
  final String error;
  GetOrderErrorState({required this.error});
}
