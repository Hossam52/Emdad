import 'dart:convert';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/general_models/facility_type_model.dart';

class OfferTransportationRequestModel {
  String id;
  String requesterType;
  late FacilityType requesterTypeEnum; //To store enum
  String requesterId;
  String supplyRequestId;
  String transportationMethod;
  String transportationStatus;
  late TransportationStatus transportationStatusEnum;
  String city;
  String createdAt;
  String updatedAt;
  OfferTransportationRequestModel({
    required this.id,
    required this.requesterType,
    required this.requesterId,
    required this.supplyRequestId,
    required this.transportationMethod,
    required this.transportationStatus,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
  }) {
    if (requesterType == 'vendor') {
      requesterTypeEnum = FacilityType.vendor;
    } else if (requesterType == 'user') {
      requesterTypeEnum = FacilityType.user;
    } else {
      throw 'Unsupported requester';
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'requesterType': requesterType,
      'requesterId': requesterId,
      'supplyRequestId': supplyRequestId,
      'transportationMethod': transportationMethod,
      'transportationStatus': transportationStatus,
      'city': city,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory OfferTransportationRequestModel.fromMap(Map<String, dynamic> map) {
    return OfferTransportationRequestModel(
      id: map['id'] ?? '',
      requesterType: map['requesterType'] ?? '',
      requesterId: map['requesterId'] ?? '',
      supplyRequestId: map['supplyRequestId'] ?? '',
      transportationMethod: map['transportationMethod'] ?? '',
      transportationStatus: map['transportationStatus'] ?? '',
      city: map['city'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferTransportationRequestModel.fromJson(String source) =>
      OfferTransportationRequestModel.fromMap(json.decode(source));
}
