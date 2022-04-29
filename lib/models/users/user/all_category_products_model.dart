import 'dart:convert';

import 'package:emdad/models/products_and_categories/product_model.dart';

class AllCategoryProductsModel {
  bool status;
  String message;
  List<ProductModel> products;
  bool isLastPage;
  AllCategoryProductsModel(
      {required this.status,
      required this.message,
      required this.products,
      this.isLastPage = false}) {
    isLastPage = products.isEmpty;
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory AllCategoryProductsModel.fromMap(Map<String, dynamic> map) {
    return AllCategoryProductsModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
      products: List<ProductModel>.from(
          map['data']?['products']?.map((x) => ProductModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllCategoryProductsModel.fromJson(String source) =>
      AllCategoryProductsModel.fromMap(json.decode(source));
  void appendProducts({required List<ProductModel> otherProducts}) {
    products.addAll(otherProducts);
  }

  set changeLastProducts(bool val) {
    isLastPage = val;
  }
}
