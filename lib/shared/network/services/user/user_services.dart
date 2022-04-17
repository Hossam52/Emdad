import 'package:emdad/shared/network/services/user/services.dart/home_user_services.dart';

class UserServices {
  UserServices._();

  static UserServices get instance => UserServices._();
  HomeUserServices userHomeServices = HomeUserServices.instance;
}
