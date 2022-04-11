import 'package:emdad/models/users/app_user_model.dart';
import 'package:emdad/models/users/user/user_data_model.dart';

class TransporterDataModel extends AppUserModel{
  List<String> transportationMethods = [];

  TransporterDataModel({
    required String organizationName,
    required String commercialRegister,
    required String country,
    required String city,
    required LocationData locationData,
    required this.transportationMethods,
  }) : super(
    organizationName: organizationName,
    commercialRegister: commercialRegister,
    country: country,
    city: city,
    locationData: locationData,
  );
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = super.toJson();
    map['userType'] = 'transporter';
    map['transportationMethods'] = transportationMethods;
    return map;
  }
}
