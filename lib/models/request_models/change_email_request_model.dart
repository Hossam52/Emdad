import 'dart:convert';

class ChangeEmailRequestModel {
  String password;
  String oldEmail;
  String newEmail;
  ChangeEmailRequestModel({
    required this.password,
    required this.oldEmail,
    required this.newEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'oldEmail': oldEmail,
      'newEmail': newEmail,
    };
  }

  factory ChangeEmailRequestModel.fromMap(Map<String, dynamic> map) {
    return ChangeEmailRequestModel(
      password: map['password'] ?? '',
      oldEmail: map['oldEmail'] ?? '',
      newEmail: map['newEmail'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangeEmailRequestModel.fromJson(String source) =>
      ChangeEmailRequestModel.fromMap(json.decode(source));
}
