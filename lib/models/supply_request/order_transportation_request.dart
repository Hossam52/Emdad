import 'dart:convert';
import 'dart:developer';

import 'package:emdad/models/enums/enums.dart';

class OrderTransportationRequestModel {
  String id;
  String transportationMethod;
  String transportationStatus;
  late TransportationStatus transportationStatusEnum;
  TransportationOffer? transportationOffer;
  OrderTransportationRequestModel({
    required this.id,
    required this.transportationMethod,
    required this.transportationStatus,
    this.transportationOffer,
  }) {
    if (transportationStatus == TransportationStatus.awaitingOffers.name) {
      transportationStatusEnum = TransportationStatus.awaitingOffers;
    } else if (transportationStatus == TransportationStatus.pending.name) {
      transportationStatusEnum = TransportationStatus.pending;
    } else if (transportationStatus ==
        TransportationStatus.pickupLocation.name) {
      transportationStatusEnum = TransportationStatus.pickupLocation;
    } else if (transportationStatus ==
        TransportationStatus.deliveryLocation.name) {
      transportationStatusEnum = TransportationStatus.deliveryLocation;
    } else if (transportationStatus == TransportationStatus.delivered.name) {
      transportationStatusEnum = TransportationStatus.delivered;
    } else {
      log(transportationStatus);
      throw 'Transportation status is unkonw';
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transportationMethod': transportationMethod,
      'transportationStatus': transportationStatus,
      'transportationOffer': transportationOffer?.toMap(),
    };
  }

  factory OrderTransportationRequestModel.fromMap(Map<String, dynamic> map) {
    return OrderTransportationRequestModel(
      id: map['id'] ?? '',
      transportationMethod: map['transportationMethod'] ?? '',
      transportationStatus: map['transportationStatus'] ?? '',
      transportationOffer: map['transportationOffer'] != null
          ? TransportationOffer.fromMap(map['transportationOffer'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderTransportationRequestModel.fromJson(String source) =>
      OrderTransportationRequestModel.fromMap(json.decode(source));
}

class TransportationOffer {
  String offerId;
  String transporterId;
  String transportationRequestId;
  double price;
  String notes;
  TransportationOffer({
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

  factory TransportationOffer.fromMap(Map<String, dynamic> map) {
    return TransportationOffer(
      offerId: map['offerId'] ?? '',
      transporterId: map['transporterId'] ?? '',
      transportationRequestId: map['transportationRequestId'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      notes: map['notes'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransportationOffer.fromJson(String source) =>
      TransportationOffer.fromMap(json.decode(source));
}
