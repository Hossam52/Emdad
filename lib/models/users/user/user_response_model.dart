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
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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
  String? userType;

  User(
      {this.sId,
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
        this.userType});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    isVerified = json['isVerified'];
    password = json['password'];
    primaryPhoneNumber = json['primaryPhoneNumber'] != null
        ? PhoneNumberDataModel.fromJson(json['primaryPhoneNumber'])
        : null;
    primaryEmail = json['primaryEmail'];
    secondaryEmail = json['secondaryEmail'];
    modificationDate = json['modificationDate'];
    if (json['vendorType'] != null) {
      vendorType = json['vendorType'].cast<String>();
    }
    firebaseToken = json['firebaseToken'];
    creationDate = json['creationDate'];
    iV = json['__v'];
    city = json['city'];
    commercialRegister = json['commercialRegister'];
    country = json['country'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    organizationName = json['oraganizationName'];
    userType = json['userType'];
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
}
