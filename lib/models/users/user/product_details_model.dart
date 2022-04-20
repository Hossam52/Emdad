import 'dart:convert';

import 'package:emdad/models/products_and_categories/product_model.dart';

class ProductDetailsModel {
  bool status;
  String message;
  ProductModel product;
  ProductDetailsModel({
    required this.status,
    required this.message,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'product': product.toMap(),
    };
  }

  factory ProductDetailsModel.fromMap(Map<String, dynamic> map) {
    return ProductDetailsModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
      product: ProductModel.fromMap(map['data']?['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetailsModel.fromJson(String source) =>
      ProductDetailsModel.fromMap(json.decode(source));
}
