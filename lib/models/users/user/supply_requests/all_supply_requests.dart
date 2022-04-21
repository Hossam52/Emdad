import 'dart:convert';

import 'package:emdad/models/supply_request/supply_request.dart';

class AllSupplyRequestsModel {
  bool status;
  String message;
  List<SupplyRequest> supplyRequests;
  AllSupplyRequestsModel({
    required this.status,
    required this.message,
    required this.supplyRequests,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'supplyRequests': supplyRequests.map((x) => x.toMap()).toList(),
    };
  }

  factory AllSupplyRequestsModel.fromMap(Map<String, dynamic> map) {
    return AllSupplyRequestsModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
      supplyRequests: List<SupplyRequest>.from(
          map['data']?['supplyRequests']?.map((x) => SupplyRequest.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllSupplyRequestsModel.fromJson(String source) =>
      AllSupplyRequestsModel.fromMap(json.decode(source));
}
