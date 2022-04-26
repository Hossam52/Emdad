import 'dart:convert';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/general_models/facility_type_model.dart';
import 'package:emdad/models/supply_request/additional_item.dart';
import 'package:emdad/models/supply_request/order_transportation_request.dart';
import 'package:emdad/models/supply_request/request_item.dart';
import 'package:emdad/models/supply_request/user_preview.dart';
import 'package:emdad/models/users/user/user_response_model.dart';

class SupplyRequest {
  String id;
  String userId;
  String vendorId;
  String requestStatus;
  late SupplyRequestStatus requestStatusEnum;
  //Make enum
  String transportationHandler;
  late FacilityType transportationHandlerEnum;
  List<RequestItem> requestItems;
  List<AdditionalItem> additionalItems;
  String createdAt;
  String updatedAt;
  int iv;
  double
      transportationPrice; //only return when the transportation handler is vendor
  String generatedId;
  String paymentStatus;
  String transportationRequestId;
  UserPreviewModel user;
  UserPreviewModel vendor;
  OrderTransportationRequestModel? transportationRequest;
  double totalOrderPrice = 0;
  SupplyRequest(
      {required this.id,
      required this.userId,
      required this.vendorId,
      required this.requestStatus,
      required this.transportationHandler,
      required this.requestItems,
      required this.additionalItems,
      required this.createdAt,
      required this.updatedAt,
      required this.iv,
      required this.transportationPrice,
      required this.generatedId,
      required this.paymentStatus,
      required this.transportationRequestId,
      required this.user,
      required this.vendor,
      this.transportationRequest}) {
    //Request status enum
    if (requestStatus == SupplyRequestStatus.awaitingApproval.name) {
      requestStatusEnum = SupplyRequestStatus.awaitingApproval;
    } else if (requestStatus == SupplyRequestStatus.awaitingQuotation.name) {
      requestStatusEnum = SupplyRequestStatus.awaitingQuotation;
    } else if (requestStatus ==
        SupplyRequestStatus.awaitingTransportation.name) {
      requestStatusEnum = SupplyRequestStatus.awaitingTransportation;
    } else if (requestStatus == SupplyRequestStatus.delivered.name) {
      requestStatusEnum = SupplyRequestStatus.delivered;
    } else if (requestStatus == SupplyRequestStatus.onWay.name) {
      requestStatusEnum = SupplyRequestStatus.onWay;
    } else if (requestStatus == SupplyRequestStatus.preparing.name) {
      requestStatusEnum = SupplyRequestStatus.preparing;
    } else {
      throw 'unkonwn request status';
    }
    //
    //transportation handler enum
    if (transportationHandler == FacilityType.user.name) {
      transportationHandlerEnum = FacilityType.user;
    } else if (transportationHandler == FacilityType.vendor.name) {
      transportationHandlerEnum = FacilityType.vendor;
    } else {
      throw 'unkown transportation handler';
    }
    //To calculate total price for the order
    for (var requestItem in requestItems) {
      totalOrderPrice += requestItem.totalPrice!;
    }
    for (var additionalItem in additionalItems) {
      totalOrderPrice += additionalItem.price;
    }
    totalOrderPrice += transportationPrice;
  }

  bool get hasTransportation => transportationRequest != null;
  bool get userRequestTransport {
    return (transportationHandlerEnum == FacilityType.user &&
        transportationRequest != null);
  }

  bool get userHasTransport {
    return (transportationHandlerEnum == FacilityType.user &&
        transportationRequest == null);
  }

  bool get vendorAddTransportationOffer {
    return (transportationHandlerEnum == FacilityType.vendor &&
        transportationRequest != null);
  }

  bool get vendorWaitTransportationOffer {
    return (transportationHandlerEnum == FacilityType.vendor &&
        transportationRequest == null);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'vendorId': vendorId,
      'requestStatus': requestStatus,
      'transportationHandler': transportationHandler,
      'requestItems': requestItems.map((x) => x.toMap()).toList(),
      'additionalItems': additionalItems.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iv,
      'transportationPrice': transportationPrice,
      'generatedId': generatedId,
      'paymentStatus': paymentStatus,
      'transportationRequestId': transportationRequestId,
      'user': user.toMap(),
      'vendor': vendor.toMap(),
      'transportationRequest': transportationRequest?.toMap(),
    };
  }

  factory SupplyRequest.fromMap(Map<String, dynamic> map) {
    return SupplyRequest(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      vendorId: map['vendorId'] ?? '',
      requestStatus: map['requestStatus'] ?? '',
      transportationHandler: map['transportationHandler'] ?? '',
      requestItems: List<RequestItem>.from(
          map['requestItems']?.map((x) => RequestItem.fromMap(x))),
      additionalItems: List<AdditionalItem>.from(
          map['additionalItems']?.map((x) => AdditionalItem.fromMap(x))),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      iv: map['__v'] ?? '',
      transportationPrice: map['transportationPrice']?.toDouble() ?? 0.0,
      generatedId: map['generatedId'] ?? '',
      paymentStatus: map['paymentStatus'] ?? '',
      transportationRequestId: map['transportationRequestId'] ?? '',
      user: UserPreviewModel.fromMap(map['user']),
      vendor: UserPreviewModel.fromMap(map['vendor']),
      transportationRequest: map['transportationRequest'] == null
          ? null
          : OrderTransportationRequestModel.fromMap(
              map['transportationRequest']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplyRequest.fromJson(String source) =>
      SupplyRequest.fromMap(json.decode(source));
}
