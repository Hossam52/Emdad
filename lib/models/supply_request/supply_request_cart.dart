import 'dart:convert';

import 'package:emdad/models/products_and_categories/product_model.dart';

class SupplyRequestCartModel {
  String id;
  String name;
  String productUnit;
  double unitPrice;
  int quantity;
  List<ProductUnit> units;
  SupplyRequestCartModel({
    required this.id,
    required this.name,
    required this.productUnit,
    required this.unitPrice,
    required this.quantity,
    required this.units,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      'quantity': quantity,
      'productUnit': productUnit,
      // 'unitPrice': unitPrice,
      // 'units': units.map((x) => x.toMap()).toList(),
    };
  }

  factory SupplyRequestCartModel.fromMap(Map<String, dynamic> map) {
    return SupplyRequestCartModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      productUnit: map['productUnit'] ?? '',
      unitPrice: map['unitPrice']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      units: List<ProductUnit>.from(
          map['units']?.map((x) => ProductUnit.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplyRequestCartModel.fromJson(String source) =>
      SupplyRequestCartModel.fromMap(json.decode(source));
}

class ProductModelInCart {
  final ProductModel product;
  final SupplyRequestCartModel selectedProductUnit;

  ProductModelInCart({
    required this.product,
    required this.selectedProductUnit,
  });
}
