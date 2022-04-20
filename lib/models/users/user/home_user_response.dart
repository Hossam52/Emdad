import 'dart:convert';

import 'package:emdad/models/users/user/user_response_model.dart';

class HomeUserModel {
  final bool status;
  final String message;
  final List<User> vendors;
  final List<User> favouriteVendors;
  final List<User> featuredVendors;
  HomeUserModel({
    required this.status,
    required this.message,
    required this.vendors,
    required this.favouriteVendors,
    required this.featuredVendors,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'vendors': vendors.map((x) => x.toMap()).toList(),
      'favouriteVendors': favouriteVendors.map((x) => x.toMap()).toList(),
      'featuredVendors': featuredVendors.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeUserModel.fromMap(Map<String, dynamic> map) {
    return HomeUserModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
      vendors: List<User>.from(
          map['data']?['vendors']?.map((x) => User.fromJson(x))),
      favouriteVendors: List<User>.from(
          map['data']?['favouriteVendors']?.map((x) => User.fromJson(x))),
      featuredVendors: List<User>.from(
          map['data']?['featuredVendors']?.map((x) => User.fromJson(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeUserModel.fromJson(String source) =>
      HomeUserModel.fromMap(json.decode(source));
}
