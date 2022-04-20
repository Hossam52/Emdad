import 'dart:convert';

class UserRegisterDataModel {
  late String name;
  late String password;
  late PhoneNumberDataModel primaryPhoneNumber;
  late PhoneNumberDataModel? secondaryPhoneNumber;
  late String primaryEmail;
  late String? secondaryEmail;
  late String firebaseToken;

  UserRegisterDataModel({
    required this.name,
    required this.password,
    required this.primaryPhoneNumber,
    this.secondaryPhoneNumber,
    required this.primaryEmail,
    this.secondaryEmail,
    required this.firebaseToken,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['password'] = password;
    data['primaryPhoneNumber'] = primaryPhoneNumber.toJson();
    if (secondaryPhoneNumber != null) {
      data['secondaryPhoneNumber'] = secondaryPhoneNumber!.toJson();
    }
    data['primaryEmail'] = primaryEmail;
    data['secondaryEmail'] = secondaryEmail;
    data['firebaseToken'] = firebaseToken;
    return data;
  }
}

class PhoneNumberDataModel {
  late String countryCode;
  late String number;
  String? sId;

  PhoneNumberDataModel({
    required this.countryCode,
    required this.number,
  });
  PhoneNumberDataModel.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    number = json['number'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countryCode'] = countryCode;
    data['number'] = number;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'countryCode': countryCode,
      'number': number,
      'sId': sId,
    };
  }
}
