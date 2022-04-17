import 'dart:convert';

import 'package:emdad/models/users/user/user_response_model.dart';

class UserPreviewModel {
  String id;
  String name;
  String city;
  Location location;
  String oraganizationName;
  String logo;
  UserPreviewModel({
    required this.id,
    required this.name,
    required this.city,
    required this.location,
    required this.oraganizationName,
    required this.logo,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'city': city,
      'location': location.toMap(),
      'oraganizationName': oraganizationName,
      'logo': logo,
    };
  }

  factory UserPreviewModel.fromMap(Map<String, dynamic> map) {
    return UserPreviewModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      city: map['city'] ?? '',
      location: Location.fromJson(map['location']),
      oraganizationName: map['oraganizationName'] ?? '',
      logo: map['logo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPreviewModel.fromJson(String source) =>
      UserPreviewModel.fromMap(json.decode(source));
}
