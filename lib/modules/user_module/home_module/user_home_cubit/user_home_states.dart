//
abstract class UserHomeStates {}

class IntitalUserHomeState extends UserHomeStates {}
//

//GetHomeData online fetch data
class GetHomeDataLoadingState extends UserHomeStates {}

class GetHomeDataSuccessState extends UserHomeStates {}

class GetHomeDataErrorState extends UserHomeStates {
  final String error;
  GetHomeDataErrorState({required this.error});
}
