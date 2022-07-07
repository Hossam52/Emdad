import 'dart:convert';

import 'package:emdad/models/products_and_categories/product_model.dart';

abstract class ProductCrudRequestModel {
  final String name;
  final String description;
  final String productType;
  final List<ProductUnit> units;
  final bool isPriceShown;
  final List<String> images;
  final String notes;
  ProductCrudRequestModel({
    required this.name,
    required this.description,
    required this.productType,
    required this.units,
    required this.isPriceShown,
    required this.images,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'productType': productType,
      'units': units.map((x) => x.toMap()).toList(),
      'isPriceShown': isPriceShown,
      'images': images,
      'notes': notes,
    };
  }
}

class AddProductRequestModel extends ProductCrudRequestModel {
  AddProductRequestModel(
      {required String name,
      required String description,
      required String productType,
      required List<ProductUnit> units,
      required bool isPriceShown,
      required List<String> images,
      required String notes})
      : super(
            name: name,
            description: description,
            productType: productType,
            units: units,
            isPriceShown: isPriceShown,
            images: images,
            notes: notes);
}

class EditProductRequestModel extends ProductCrudRequestModel {
  final String productId;
  EditProductRequestModel(
      {required this.productId,
      required String name,
      required String description,
      required String productType,
      required List<ProductUnit> units,
      required bool isPriceShown,
      required List<String> images,
      required String notes})
      : super(
            name: name,
            description: description,
            productType: productType,
            units: units,
            isPriceShown: isPriceShown,
            images: images,
            notes: notes);

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map['productId'] = productId;
    return map;
  }
}

// class AddProductRequestModel {
//   final String name;
//   final String description;
//   final String productType;
//   final List<ProductUnit> units;
//   final bool isPriceShown;
//   final List<String> images;
//   final String notes;
//   AddProductRequestModel({
//     required this.name,
//     required this.description,
//     required this.productType,
//     required this.units,
//     required this.isPriceShown,
//     required this.images,
//     required this.notes,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'description': description,
//       'productType': productType,
//       'units': units.map((x) => x.toMap()).toList(),
//       'isPriceShown': isPriceShown,
//       'images': images,
//       'notes': notes,
//     };
//   }

//   factory AddProductRequestModel.fromMap(Map<String, dynamic> map) {
//     return AddProductRequestModel(
//       name: map['name'] ?? '',
//       description: map['description'] ?? '',
//       productType: map['productType'] ?? '',
//       units: List<ProductUnit>.from(
//           map['units']?.map((x) => ProductUnit.fromMap(x))),
//       isPriceShown: map['isPriceShown'] ?? false,
//       images: List<String>.from(map['images']),
//       notes: map['notes'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory AddProductRequestModel.fromJson(String source) =>
//       AddProductRequestModel.fromMap(json.decode(source));
// }
