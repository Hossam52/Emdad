import 'dart:convert';

import 'package:emdad/models/users/auth/user_register_data_model.dart';

class UserResponseModel {
  bool? status;
  String? message;
  Data? data;

  UserResponseModel({this.status, this.message, this.data});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  User? user;
  String? accessToken;

  Data({this.user, this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromMap(json['user']) : null;
    accessToken = json['accessToken'];
  }
}

class User {
  String? sId;
  String? name;
  bool? isVerified;
  String? password;
  PhoneNumberDataModel? primaryPhoneNumber;
  String? primaryEmail;
  String? secondaryEmail;
  String? modificationDate;
  List<String>? vendorType = [];
  String? firebaseToken;
  String? creationDate;
  int? iV;
  String? city;
  String? commercialRegister;
  String? country;
  Location? location;
  String? organizationName;
  String? updatedAt;
  String? logo;
  String? id;
  String? logoUrl;
  LocationObject? locationObject;
  bool? isFavourite;
  String? userType;
  User({
    this.sId,
    this.name,
    this.isVerified,
    this.password,
    this.primaryPhoneNumber,
    this.primaryEmail,
    this.secondaryEmail,
    this.modificationDate,
    this.vendorType,
    this.firebaseToken,
    this.creationDate,
    this.iV,
    this.city,
    this.commercialRegister,
    this.country,
    this.location,
    this.organizationName,
    this.updatedAt,
    this.logo,
    this.id,
    this.logoUrl,
    this.locationObject,
    this.isFavourite,
    this.userType,
  });

  Map<String, dynamic> toMap() {
    return {
      'sId': sId,
      'name': name,
      'isVerified': isVerified,
      'password': password,
      'primaryPhoneNumber': primaryPhoneNumber?.toMap(),
      'primaryEmail': primaryEmail,
      'secondaryEmail': secondaryEmail,
      'modificationDate': modificationDate,
      'vendorType': vendorType,
      'firebaseToken': firebaseToken,
      'creationDate': creationDate,
      'iV': iV,
      'city': city,
      'commercialRegister': commercialRegister,
      'country': country,
      'location': location?.toMap(),
      'organizationName': organizationName,
      'updatedAt': updatedAt,
      'logo': logo,
      'id': id,
      'logoUrl': logoUrl,
      'locationObject': locationObject?.toMap(),
      'isFavourite': isFavourite,
      'userType': userType,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      sId: map['sId'],
      name: map['name'],
      isVerified: map['isVerified'],
      password: map['password'],
      primaryPhoneNumber: map['primaryPhoneNumber'] != null
          ? PhoneNumberDataModel.fromJson(map['primaryPhoneNumber'])
          : null,
      primaryEmail: map['primaryEmail'],
      secondaryEmail: map['secondaryEmail'],
      modificationDate: map['modificationDate'],
      vendorType: map['vendorType'] == null
          ? null
          : List<String>.from(map['vendorType']),
      firebaseToken: map['firebaseToken'],
      creationDate: map['creationDate'],
      iV: map['iV']?.toInt(),
      city: map['city'],
      commercialRegister: map['commercialRegister'],
      country: map['country'],
      location:
          map['location'] != null ? Location.fromJson(map['location']) : null,
      organizationName: map['oraganizationName'],
      updatedAt: map['updatedAt'],
      logo: map['logo'],
      id: map['id'],
      logoUrl: map['logoUrl'],
      locationObject: map['locationObject'] != null
          ? LocationObject.fromMap(map['locationObject'])
          : null,
      isFavourite: map['isFavourite'] ?? false,
      userType: map['userType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  String get allVendorTypeString {
    if (vendorType != null && vendorType!.isNotEmpty) {
      return vendorType!.join(' - ');
    } else {
      return 'لا يوجد قسم';
    }
  }

  String get firstVendorType {
    if (vendorType == null || vendorType!.isEmpty) {
      return ' ';
    } else {
      return vendorType!.first;
    }
  }
}

class Location {
  String? type;
  List<double>? coordinates = [];
  String? sId;

  Location({this.type, this.coordinates, this.sId});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
    sId = json['_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {};
    json['type'] = type;
    json['coordinates'] = coordinates;
    json['_id'] = sId;
    return json;
  }
}

class LocationObject {
  double lat;
  double lng;
  LocationObject({
    required this.lat,
    required this.lng,
  });
  factory LocationObject.empty() {
    return LocationObject(lat: 0, lng: 0);
  }
  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory LocationObject.fromMap(Map<String, dynamic> map) {
    return LocationObject(
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationObject.fromJson(String source) =>
      LocationObject.fromMap(json.decode(source));
}
