import 'dart:convert';

import 'package:emdad/models/request_models/add_additional_request_item_model.dart';
import 'package:emdad/models/supply_request/supply_request_cart.dart';

class CreateSupplyRequestModel {
  String vendorId;
  bool isTransportationNeeded;
  List<SupplyRequestCartModel> requestItems;
  List<AddAdditionalItemRequestModel> additionalItems;
  CreateSupplyRequestModel({
    required this.vendorId,
    required this.isTransportationNeeded,
    required this.requestItems,
    required this.additionalItems,
  });

  Map<String, dynamic> toMap() {
    return {
      'vendorId': vendorId,
      'isTransportationNeeded': isTransportationNeeded,
      'requestItems': requestItems.map((x) => x.toMap()).toList(),
      'additionalItems': additionalItems.map((x) => x.toMap()).toList(),
    };
  }

  factory CreateSupplyRequestModel.fromMap(Map<String, dynamic> map) {
    return CreateSupplyRequestModel(
      vendorId: map['vendorId'] ?? '',
      isTransportationNeeded: map['isTransportationNeeded'] ?? false,
      requestItems: List<SupplyRequestCartModel>.from(
          map['requestItems']?.map((x) => SupplyRequestCartModel.fromMap(x))),
      additionalItems: List<AddAdditionalItemRequestModel>.from(
          map['additionalItems']
              ?.map((x) => AddAdditionalItemRequestModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateSupplyRequestModel.fromJson(String source) =>
      CreateSupplyRequestModel.fromMap(json.decode(source));
}
