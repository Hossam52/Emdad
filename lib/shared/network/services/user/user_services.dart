import 'package:emdad/shared/network/services/user/services.dart/home_user_services.dart';
import 'package:emdad/shared/network/services/user/services.dart/product_user_services.dart';
import 'package:emdad/shared/network/services/user/services.dart/supply_requests_services.dart';
import 'package:emdad/shared/network/services/user/services.dart/user_transport_services.dart';
import 'package:emdad/shared/network/services/user/services.dart/user_vendor_services.dart';

class UserServices {
  UserServices._();

  static UserServices get instance => UserServices._();
  HomeUserServices userHomeServices = HomeUserServices.instance;
  UserVendorServices userVendorServices = UserVendorServices.instance;
  ProductServices productServices = ProductServices.instance;
  SupplyRequestServices requestServices = SupplyRequestServices.instance;
  UserTransportServices userTransportServices = UserTransportServices.instance;
}
