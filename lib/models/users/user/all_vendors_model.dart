import 'dart:convert';

import 'user_response_model.dart';

class AllVendorsModel {
  bool status;
  String message;
  List<User> vendors;
  bool isLastPage;
  AllVendorsModel({
    required this.status,
    required this.message,
    required this.vendors,
    this.isLastPage = false,
  }) {
    isLastPage = vendors.isEmpty;
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'vendors': vendors.map((x) => x.toMap()).toList(),
    };
  }

  factory AllVendorsModel.fromMap(Map<String, dynamic> map) {
    return AllVendorsModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
      vendors:
          List<User>.from(map['data']?['vendors']?.map((x) => User.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllVendorsModel.fromJson(String source) =>
      AllVendorsModel.fromMap(json.decode(source));

  void set setLastPage(bool val) => isLastPage = val;
}
