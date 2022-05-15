import 'dart:convert';

import 'package:emdad/models/transportations/transportation_supply_requests/transporter_supply_request.dart';

class TransporterOrderDetailsModel {
  bool status;
  TransporterSupplyRequest transportationRequest;
  TransporterOrderDetailsModel({
    required this.status,
    required this.transportationRequest,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'transportationRequest': transportationRequest.toMap(),
    };
  }

  factory TransporterOrderDetailsModel.fromMap(Map<String, dynamic> map) {
    return TransporterOrderDetailsModel(
      status: map['status'] ?? false,
      transportationRequest: TransporterSupplyRequest.fromMap(
          map['data']['transportationRequest']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransporterOrderDetailsModel.fromJson(String source) =>
      TransporterOrderDetailsModel.fromMap(json.decode(source));
}
