import 'package:emdad/models/users/app_user_model.dart';

class UserDataModel extends AppUserModel {
  UserDataModel({
    required String organizationName,
    required String commercialRegister,
    required String country,
    required String city,
    required LocationData locationData,
  }) : super(
          organizationName: organizationName,
          commercialRegister: commercialRegister,
          country: country,
          city: city,
          locationData: locationData,
        );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['userType'] = 'user';
    return data;
  }
}
