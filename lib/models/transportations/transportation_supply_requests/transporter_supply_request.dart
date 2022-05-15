import 'dart:convert';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/transportations/transportation_offer_model.dart';
import 'package:emdad/models/transportations/transportation_supply_requests/supply_request_transportation_offer.dart';
import 'package:emdad/models/transportations/transportation_supply_requests/transportation_requester_model.dart';

class TransporterSupplyRequestsModel {
  bool status;
  List<TransporterSupplyRequest> transportationRequests;
  bool isLastPage;
  TransporterSupplyRequestsModel({
    required this.status,
    required this.transportationRequests,
  }) : isLastPage = transportationRequests.isEmpty;
  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'transportationRequests':
          transportationRequests.map((x) => x.toMap()).toList(),
    };
  }

  factory TransporterSupplyRequestsModel.fromMap(Map<String, dynamic> map) {
    return TransporterSupplyRequestsModel(
      status: map['status'] ?? false,
      transportationRequests: List<TransporterSupplyRequest>.from(map['data']
              ['transportationRequests']
          ?.map((x) => TransporterSupplyRequest.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransporterSupplyRequestsModel.fromJson(String source) =>
      TransporterSupplyRequestsModel.fromMap(json.decode(source));
  void appendObjectToCurrent(TransporterSupplyRequestsModel incomeObject) {
    if (incomeObject.status) {
      isLastPage = incomeObject.isLastPage;
      transportationRequests.addAll(incomeObject.transportationRequests);
    }
  }
}

class TransporterSupplyRequest {
  String id;
  String requesterType;
  String requesterId;
  String supplyRequestId;
  String transportationMethod;
  String transportationStatus;
  // TransportationStatus transportationStatusEnum;
  String city;
  String createdAt;
  String updatedAt;
  TransportationRequester requester;
  TransporterSupplyRequestOffer? transportationOffer;
  SupplyRequest supplyRequest;
  TransporterSupplyRequest({
    required this.id,
    required this.requesterType,
    required this.requesterId,
    required this.supplyRequestId,
    required this.transportationMethod,
    required this.transportationStatus,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
    required this.requester,
    required this.transportationOffer,
    required this.supplyRequest,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'requesterType': requesterType,
      'requesterId': requesterId,
      'supplyRequestId': supplyRequestId,
      'transportationMethod': transportationMethod,
      'transportationStatus': transportationStatus,
      'city': city,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'requester': requester.toMap(),
      'transportationOffer': transportationOffer?.toMap(),
      'supplyRequest': supplyRequest.toMap(),
    };
  }

  factory TransporterSupplyRequest.fromMap(Map<String, dynamic> map) {
    return TransporterSupplyRequest(
      id: map['_id'] ?? '',
      requesterType: map['requesterType'] ?? '',
      requesterId: map['requesterId'] ?? '',
      supplyRequestId: map['supplyRequestId'] ?? '',
      transportationMethod: map['transportationMethod'] ?? '',
      transportationStatus: map['transportationStatus'] ?? '',
      city: map['city'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      requester: TransportationRequester.fromMap(map['requester']),
      transportationOffer: map['transportationOffer'] != null
          ? TransporterSupplyRequestOffer.fromMap(map['transportationOffer'])
          : null,
      supplyRequest: SupplyRequest.fromMap(map['supplyRequest']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransporterSupplyRequest.fromJson(String source) =>
      TransporterSupplyRequest.fromMap(json.decode(source));
}
