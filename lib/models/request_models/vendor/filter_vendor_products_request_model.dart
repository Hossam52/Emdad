import 'dart:convert';

class FilterVendorProductsRequestModel {
  String searchQuery;
  FilterVendorProductsRequestModel({
    required this.searchQuery,
  });

  Map<String, dynamic> toMap() {
    return {
      'searchQuery': searchQuery,
    };
  }

  factory FilterVendorProductsRequestModel.fromMap(Map<String, dynamic> map) {
    return FilterVendorProductsRequestModel(
      searchQuery: map['searchQuery'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterVendorProductsRequestModel.fromJson(String source) =>
      FilterVendorProductsRequestModel.fromMap(json.decode(source));
}
