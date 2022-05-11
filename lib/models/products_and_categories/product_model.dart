import 'dart:convert';

class ProductModel {
  String id;
  String vendorId;
  String name;
  String description;
  String productType;
  List<ProductUnit> units;
  bool isPriceShown;
  List<String> images;
  ProductModel({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.description,
    required this.productType,
    required this.units,
    required this.isPriceShown,
    required this.images,
  }) {
    images = images
        .map(
            (e) => 'https://emdad-ecommerce.herokuapp.com/images/products/' + e)
        .toList();
//TODO: Remove the link above as it for test
  }
  ProductModel.emptyModel()
      : id = '',
        name = '',
        vendorId = '',
        description = '',
        productType = '',
        units = [],
        isPriceShown = true,
        images = [];

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'vendorId': vendorId,
      'name': name,
      'description': description,
      'productType': productType,
      'units': units.map((x) => x.toMap()).toList(),
      'isPriceShown': isPriceShown,
      'images': images,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'] ?? '',
      vendorId: map['vendorId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      productType: map['productType'] ?? '',
      units: List<ProductUnit>.from(
          map['units']?.map((x) => ProductUnit.fromMap(x))),
      isPriceShown: map['isPriceShown'] ?? false,
      images: List<String>.from(map['images']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  ProductModel copyWith({
    String? id,
    String? vendorId,
    String? name,
    String? description,
    String? productType,
    List<ProductUnit>? units,
    bool? isPriceShown,
    List<String>? images,
  }) {
    return ProductModel(
      id: id ?? this.id,
      vendorId: vendorId ?? this.vendorId,
      name: name ?? this.name,
      description: description ?? this.description,
      productType: productType ?? this.productType,
      units: units ?? this.units,
      isPriceShown: isPriceShown ?? this.isPriceShown,
      images: images ?? this.images,
    );
  }
}

class ProductUnit {
  String productUnit;
  double pricePerUnit;
  int minimumAmountPerOrder;
  ProductUnit({
    required this.productUnit,
    required this.pricePerUnit,
    required this.minimumAmountPerOrder,
  });

  String get generateStringPerUnit {
    return pricePerUnit.toInt().toString() + ' / ' + productUnit;
  }

  Map<String, dynamic> toMap() {
    return {
      'productUnit': productUnit,
      'pricePerUnit': pricePerUnit,
      'minimumAmountPerOrder': minimumAmountPerOrder,
    };
  }

  factory ProductUnit.fromMap(Map<String, dynamic> map) {
    return ProductUnit(
      productUnit: map['productUnit'] ?? '',
      pricePerUnit: map['pricePerUnit']?.toDouble() ?? 0.0,
      minimumAmountPerOrder: map['minimumAmountPerOrder']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductUnit.fromJson(String source) =>
      ProductUnit.fromMap(json.decode(source));
}
