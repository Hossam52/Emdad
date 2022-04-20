import 'dart:convert';

class CategoryRequestModel {
  List<String>? productType;
  String? paginationToken;
  CategoryRequestModel({
    this.productType,
    this.paginationToken,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    for (int i = 0; i < productType!.length; i++) {
      map['productType[$i]'] = productType![i];
    }
    map['paginationToken'] = paginationToken;
    return map;
    // return {
    //   'productType': productType,
    //   'paginationToken': paginationToken,
    // };
  }

  factory CategoryRequestModel.fromMap(Map<String, dynamic> map) {
    return CategoryRequestModel(
      productType: List<String>.from(map['productType']),
      paginationToken: map['paginationToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryRequestModel.fromJson(String source) =>
      CategoryRequestModel.fromMap(json.decode(source));
}
