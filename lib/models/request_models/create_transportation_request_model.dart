import 'dart:convert';

class CreateTransportationRequestModel {
  String supplyRequestId;

  String transportationMethod;
  String city;
  CreateTransportationRequestModel({
    required this.supplyRequestId,
    required this.transportationMethod,
    required this.city,
  });

  Map<String, dynamic> toMap() {
    return {
      'supplyRequestId': supplyRequestId,
      'transportationMethod': transportationMethod,
      'city': city,
    };
  }

  factory CreateTransportationRequestModel.fromMap(Map<String, dynamic> map) {
    return CreateTransportationRequestModel(
      supplyRequestId: map['supplyRequestId'] ?? '',
      transportationMethod: map['transportationMethod'] ?? '',
      city: map['city'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateTransportationRequestModel.fromJson(String source) =>
      CreateTransportationRequestModel.fromMap(json.decode(source));
}
