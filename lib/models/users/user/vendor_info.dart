import 'dart:convert';
import 'dart:developer';

import 'package:emdad/models/products_and_categories/category_model.dart';
import 'package:emdad/models/rating/rate_model.dart';
import 'package:emdad/models/users/user/user_response_model.dart';

class VendorInfoModel {
  final bool status;
  final String message;
  final User vendorInfo;
  final List<RateModel> ratings;
  double overAllRating;
  List<CategoryModel> categories;
  VendorInfoModel({
    required this.status,
    required this.message,
    required this.vendorInfo,
    required this.ratings,
    required this.overAllRating,
    required this.categories,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'vendorInfo': vendorInfo.toMap(),
      'ratings': ratings.map((x) => x.toMap()).toList(),
      'overAllRating': overAllRating,
      'categories': categories.map((x) => x.toMap()).toList(),
    };
  }

  factory VendorInfoModel.fromMap(Map<String, dynamic> map) {
    return VendorInfoModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
      vendorInfo: User.fromMap(map['data']?['vendorInfo']),
      ratings: List<RateModel>.from(
          map['data']?['ratings']?.map((x) => RateModel.fromMap(x))),
      overAllRating: map['data']?['overAllRating']?.toDouble() ?? 0.0,
      categories: List<CategoryModel>.from(
          map['data']?['categories']?.map((x) => CategoryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory VendorInfoModel.fromJson(String source) =>
      VendorInfoModel.fromMap(json.decode(source));
}
