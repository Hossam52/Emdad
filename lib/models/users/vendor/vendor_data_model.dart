import 'package:emdad/models/users/app_user_model.dart';

class VendorDataModel extends AppUserModel {
  late List<String> vendorType = [];

  VendorDataModel({
    required this.vendorType,
    required String commercialRegister,
    required String organizationName,
    required String city,
    required String country,
    required LocationData locationData,
  }) : super(
          commercialRegister: commercialRegister,
          organizationName: organizationName,
          country: country,
          city: city,
          locationData: locationData,
        );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['userType'] = 'vendor';
    data['vendorType'] = vendorType;
    return data;
  }
}
