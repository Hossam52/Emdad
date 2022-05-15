import 'dart:convert';

class CreatePriceRequestModel {
  String transportationRequestId;
  double price;
  String notes;
  CreatePriceRequestModel({
    required this.transportationRequestId,
    required this.price,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'transportationRequestId': transportationRequestId,
      'price': price,
      'notes': notes,
    };
  }

  factory CreatePriceRequestModel.fromMap(Map<String, dynamic> map) {
    return CreatePriceRequestModel(
      transportationRequestId: map['transportationRequestId'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      notes: map['notes'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatePriceRequestModel.fromJson(String source) =>
      CreatePriceRequestModel.fromMap(json.decode(source));
}
