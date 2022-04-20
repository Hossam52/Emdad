import 'dart:convert';

import 'package:emdad/models/products_and_categories/product_model.dart';

class CategoryModel {
  String category;
  List<ProductModel> products;
  CategoryModel({
    required this.category,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      category: map['category'] ?? '',
      products: List<ProductModel>.from(
          map['products']?.map((x) => ProductModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));
}
