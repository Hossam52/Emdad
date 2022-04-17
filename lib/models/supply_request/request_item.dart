import 'dart:convert';

class RequestItem {
  String name;
  String productUnit;
  int quantity;
  double totalPrice;
  String id;
  RequestItem({
    required this.name,
    required this.productUnit,
    required this.quantity,
    required this.totalPrice,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'productUnit': productUnit,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'id': id,
    };
  }

  factory RequestItem.fromMap(Map<String, dynamic> map) {
    return RequestItem(
      name: map['name'] ?? '',
      productUnit: map['productUnit'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestItem.fromJson(String source) =>
      RequestItem.fromMap(json.decode(source));
}
