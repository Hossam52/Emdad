import 'dart:convert';

class TransporterSupplyRequestOffer {
  String offerId;
  String transporterId;
  String transportationRequestId;
  double price;
  String notes;
  TransporterSupplyRequestOffer({
    required this.offerId,
    required this.transporterId,
    required this.transportationRequestId,
    required this.price,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'offerId': offerId,
      'transporterId': transporterId,
      'transportationRequestId': transportationRequestId,
      'price': price,
      'notes': notes,
    };
  }

  factory TransporterSupplyRequestOffer.fromMap(Map<String, dynamic> map) {
    return TransporterSupplyRequestOffer(
      offerId: map['offerId'] ?? '',
      transporterId: map['transporterId'] ?? '',
      transportationRequestId: map['transportationRequestId'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      notes: map['notes'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransporterSupplyRequestOffer.fromJson(String source) =>
      TransporterSupplyRequestOffer.fromMap(json.decode(source));
}
