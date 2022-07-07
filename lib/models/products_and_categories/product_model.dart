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
  List<String> imagesUrls;
  String notes;
  ProductModel(
      {required this.id,
      required this.vendorId,
      required this.name,
      required this.description,
      required this.productType,
      required this.units,
      required this.isPriceShown,
      required this.images,
      required this.imagesUrls,
      required this.notes});
  ProductModel.emptyModel()
      : id = '',
        name = '',
        vendorId = '',
        description = '',
        productType = '',
        units = [],
        isPriceShown = true,
        images = [],
        imagesUrls = [],
        notes = '';

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
      'imagesUrls': imagesUrls,
      'notes': notes,
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
      imagesUrls: List<String>.from(map['imagesUrls']),
      notes: map['notes'] ?? '',
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
    List<String>? imagesUrls,
    String? notes,
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
        imagesUrls: imagesUrls ?? this.imagesUrls,
        notes: notes ?? this.notes);
  }
}

class ProductUnit {
  String id;
  String productUnit;
  double pricePerUnit;
  int minimumAmountPerOrder;

  ProductUnit(
      {required this.productUnit,
      required this.pricePerUnit,
      required this.minimumAmountPerOrder,
      required this.id});

  String get generateStringPerUnit {
    return pricePerUnit.toInt().toString() + ' / ' + productUnit;
  }

  Map<String, dynamic> toMap() {
    return {
      'productUnit': productUnit,
      'pricePerUnit': pricePerUnit,
      'minimumAmountPerOrder': minimumAmountPerOrder,
      'id': id,
    };
  }

  factory ProductUnit.fromMap(Map<String, dynamic> map) {
    return ProductUnit(
        productUnit: map['productUnit'] ?? '',
        pricePerUnit: map['pricePerUnit']?.toDouble() ?? 0.0,
        minimumAmountPerOrder: map['minimumAmountPerOrder']?.toInt() ?? 0,
        id: map['_id'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory ProductUnit.fromJson(String source) =>
      ProductUnit.fromMap(json.decode(source));
}
