import 'dart:convert';

import 'package:emdad/models/transportations/offer_transportation_request_model.dart';
import 'package:emdad/models/transportations/transporter_model.dart';

class TransportationOfferModel {
  String id;
  String transporterId;
  String transportationRequestId;
  double price;
  String notes;
  String createdAt;
  String updatedAt;
  TransporterModel transporter;
  OfferTransportationRequestModel transportationRequest;
  TransportationOfferModel({
    required this.id,
    required this.transporterId,
    required this.transportationRequestId,
    required this.price,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.transporter,
    required this.transportationRequest,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'transporterId': transporterId,
      'transportationRequestId': transportationRequestId,
      'price': price,
      'notes': notes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'transporter': transporter.toMap(),
      'transportationRequest': transportationRequest.toMap(),
    };
  }

  factory TransportationOfferModel.fromMap(Map<String, dynamic> map) {
    return TransportationOfferModel(
      id: map['_id'] ?? '',
      transporterId: map['transporterId'] ?? '',
      transportationRequestId: map['transportationRequestId'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      notes: map['notes'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      transporter: TransporterModel.fromMap(map['transporter']),
      transportationRequest:
          OfferTransportationRequestModel.fromMap(map['transportationRequest']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransportationOfferModel.fromJson(String source) =>
      TransportationOfferModel.fromMap(json.decode(source));
}
