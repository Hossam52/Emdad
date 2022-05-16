import 'dart:convert';

import 'package:emdad/models/users/user/user_response_model.dart';

class UpdateProfileRequestModel {
  String? logo;
  String? oraganizationName;
  String? commercialRegister;
  String? city;
  String? country;
  LocationObject? location;
  UpdateProfileRequestModel({
    this.logo,
    this.oraganizationName,
    this.commercialRegister,
    this.city,
    this.country,
    this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      if (logo != null) 'logo': logo,
      if (oraganizationName != null) 'oraganizationName': oraganizationName,
      if (commercialRegister != null) 'commercialRegister': commercialRegister,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
      if (location != null) 'location': location?.toMap(),
    };
  }

  factory UpdateProfileRequestModel.fromMap(Map<String, dynamic> map) {
    return UpdateProfileRequestModel(
      logo: map['logo'],
      oraganizationName: map['oraganizationName'],
      commercialRegister: map['commercialRegister'],
      city: map['city'],
      country: map['country'],
      location: map['location'] != null
          ? LocationObject.fromMap(map['location'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateProfileRequestModel.fromJson(String source) =>
      UpdateProfileRequestModel.fromMap(json.decode(source));
}
