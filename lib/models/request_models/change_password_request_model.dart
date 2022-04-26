import 'dart:convert';

class ChangePasswordRequestModel {
  String oldPassword;
  String newPassword;
  String newPasswordConfirm;
  ChangePasswordRequestModel({
    required this.oldPassword,
    required this.newPassword,
    required this.newPasswordConfirm,
  });

  Map<String, dynamic> toMap() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'newPasswordConfirm': newPasswordConfirm,
    };
  }

  factory ChangePasswordRequestModel.fromMap(Map<String, dynamic> map) {
    return ChangePasswordRequestModel(
      oldPassword: map['oldPassword'] ?? '',
      newPassword: map['newPassword'] ?? '',
      newPasswordConfirm: map['newPasswordConfirm'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangePasswordRequestModel.fromJson(String source) =>
      ChangePasswordRequestModel.fromMap(json.decode(source));
}
