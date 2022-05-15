import 'dart:convert';

import 'package:emdad/models/users/user/user_response_model.dart';

class TransportationRequester {
  String id;
  String name;
  List<String> vendorType;
  String city;
  String country;
  Location location;
  String oraganizationName;
  String logo;
  TransportationRequester({
    required this.id,
    required this.name,
    required this.vendorType,
    required this.city,
    required this.country,
    required this.location,
    required this.oraganizationName,
    required this.logo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'vendorType': vendorType,
      'city': city,
      'country': country,
      'location': location.toMap(),
      'oraganizationName': oraganizationName,
      'logo': logo,
    };
  }

  factory TransportationRequester.fromMap(Map<String, dynamic> map) {
    return TransportationRequester(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      vendorType: List<String>.from(map['vendorType'] ?? []),
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      location: Location.fromJson(map['location']),
      oraganizationName: map['oraganizationName'] ?? '',
      logo: map['logo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransportationRequester.fromJson(String source) =>
      TransportationRequester.fromMap(json.decode(source));
}
