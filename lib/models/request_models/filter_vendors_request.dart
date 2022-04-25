import 'dart:convert';

class FilterVendorRequest {
  String? searchQuery;
  List<String>? vendorType;
  String? city;
  String? paginationToken;
  FilterVendorRequest({
    this.searchQuery,
    this.vendorType,
    this.city,
    this.paginationToken,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    if (searchQuery != null) map['searchQuery'] = searchQuery;
    if (vendorType != null && vendorType!.isNotEmpty) {
      for (int i = 0; i < vendorType!.length; i++) {
        map['vendorType[$i]'] = vendorType![i];
      }
    }
    if (city != null) map['city'] = city;
    if (paginationToken != null) map['paginationToken'] = paginationToken;
    return map;
  }

  factory FilterVendorRequest.fromMap(Map<String, dynamic> map) {
    return FilterVendorRequest(
      searchQuery: map['searchQuery'],
      vendorType: map['vendorType'],
      city: map['city'],
      paginationToken: map['paginationToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterVendorRequest.fromJson(String source) =>
      FilterVendorRequest.fromMap(json.decode(source));

  FilterVendorRequest copyWith({
    String? searchQuery,
    List<String>? vendorType,
    String? city,
    String? paginationToken,
  }) {
    return FilterVendorRequest(
      searchQuery: searchQuery ?? this.searchQuery,
      vendorType: vendorType ?? this.vendorType,
      city: city ?? this.city,
      paginationToken: paginationToken ?? this.paginationToken,
    );
  }
}
