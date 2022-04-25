import 'dart:convert';

import 'package:emdad/models/users/user/user_response_model.dart';

class UserPreviewModel {
  String id;
  String name;
  String city;
  String country;
  Location location;
  String oraganizationName;
  String logo;
  String logoUrl;
  LocationObject locationObject;
  UserPreviewModel({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.location,
    required this.oraganizationName,
    required this.logo,
    required this.logoUrl,
    required this.locationObject,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'country': country,
      'location': location.toMap(),
      'oraganizationName': oraganizationName,
      'logo': logo,
      'logoUrl': logoUrl,
      'locationObject': locationObject.toMap(),
    };
  }

  factory UserPreviewModel.fromMap(Map<String, dynamic> map) {
    return UserPreviewModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      location: Location.fromJson(map['location']),
      oraganizationName: map['oraganizationName'] ?? '',
      logo: map['logo'] ?? '',
      logoUrl: map['logoUrl'] ?? '',
      locationObject: LocationObject.fromMap(map['locationObject']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPreviewModel.fromJson(String source) =>
      UserPreviewModel.fromMap(json.decode(source));
}
