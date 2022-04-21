import 'dart:convert';

import 'package:emdad/models/supply_request/supply_request.dart';

class OrderRequestModel {
  bool status;
  String messages;
  SupplyRequest supplyRequest;
  OrderRequestModel({
    required this.status,
    required this.messages,
    required this.supplyRequest,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'messages': messages,
      'supplyRequest': supplyRequest.toMap(),
    };
  }

  factory OrderRequestModel.fromMap(Map<String, dynamic> map) {
    return OrderRequestModel(
      status: map['status'] ?? false,
      messages: map['messages'] ?? '',
      supplyRequest: SupplyRequest.fromMap(map['data']?['supplyRequest']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderRequestModel.fromJson(String source) =>
      OrderRequestModel.fromMap(json.decode(source));
}
