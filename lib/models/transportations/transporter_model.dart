import 'dart:convert';

import 'package:emdad/models/users/app_user_model.dart';

class TransporterModel {
  String id;
  String name;
  List<String> vendorType;
  String city;
  String country;
  // LocationData locationData; //TODO: Replace it with correct object
  String oraganizationName;
  String logo;
  TransporterModel({
    required this.id,
    required this.name,
    required this.vendorType,
    required this.city,
    required this.country,
    required this.oraganizationName,
    required this.logo,
  }) {
    logo = 'https://emdad-ecommerce.herokuapp.com/images/products/' +
        logo; //TODO: Replace this link
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'vendorType': vendorType,
      'city': city,
      'country': country,
      'oraganizationName': oraganizationName,
      'logo': logo,
    };
  }

  factory TransporterModel.fromMap(Map<String, dynamic> map) {
    return TransporterModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      vendorType: List<String>.from(map['vendorType']),
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      oraganizationName: map['oraganizationName'] ?? '',
      logo: map['logo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransporterModel.fromJson(String source) =>
      TransporterModel.fromMap(json.decode(source));
}
