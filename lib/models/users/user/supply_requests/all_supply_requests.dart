import 'dart:convert';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/supply_request/supply_request.dart';

class AllSupplyRequestsModel {
  bool status;
  String message;
  List<SupplyRequest> supplyRequests;

  List<SupplyRequest> awaitTransportationRequests = [];
  List<SupplyRequest> awaitingApproval = [];
  List<SupplyRequest> awaitingQuotation = [];
  List<SupplyRequest> preparingRequests = [];
  List<SupplyRequest> onWayRequests = [];
  List<SupplyRequest> deliverdRequests = [];
  bool isLastPage;
  AllSupplyRequestsModel({
    required this.status,
    required this.message,
    required this.supplyRequests,
  }) : isLastPage = supplyRequests.isEmpty {
    _separateOrders();
  }
  void _separateOrders() {
    _assignAwaitTransportation();
    _assignPreparing();
    _assignOnWay();
    _assignDeliverd();
    _assignAwaitingQuotation();
    _assignAwaitingApproval();
  }

  // For separate requests every to its own type
  void _assignAwaitTransportation() {
    awaitTransportationRequests = supplyRequests
        .where((request) =>
            request.requestStatusEnum ==
            SupplyRequestStatus.awaitingTransportation)
        .toList();
  }

  void _assignPreparing() {
    preparingRequests = supplyRequests
        .where((request) =>
            request.requestStatusEnum == SupplyRequestStatus.preparing)
        .toList();
  }

  void _assignOnWay() {
    onWayRequests = supplyRequests
        .where(
            (request) => request.requestStatusEnum == SupplyRequestStatus.onWay)
        .toList();
  }

  void _assignDeliverd() {
    deliverdRequests = supplyRequests
        .where((request) =>
            request.requestStatusEnum == SupplyRequestStatus.delivered)
        .toList();
  }

  void _assignAwaitingQuotation() {
    awaitingQuotation = supplyRequests
        .where((request) =>
            request.requestStatusEnum == SupplyRequestStatus.awaitingQuotation)
        .toList();
  }

  void _assignAwaitingApproval() {
    awaitingApproval = supplyRequests
        .where((request) =>
            request.requestStatusEnum == SupplyRequestStatus.awaitingApproval)
        .toList();
  }

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

  // To Append requests to current object
  void appendObjectToCurrent(AllSupplyRequestsModel requestsModel) {
    isLastPage = requestsModel.isLastPage; //to override current last page
    supplyRequests
        .addAll(requestsModel.supplyRequests); //add model to current model
    _separateOrders(); //To separate every request according to type
  }
}
