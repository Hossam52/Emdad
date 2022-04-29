import 'dart:convert';

import 'package:emdad/models/request_models/user/add_additional_request_item_model.dart';
import 'package:emdad/models/supply_request/supply_request_cart.dart';

class ResendSupplyRequestModel {
  List<SupplyRequestCartModel> requestItems;
  List<AddAdditionalItemRequestModel> additionalItems;
  ResendSupplyRequestModel({
    required this.requestItems,
    required this.additionalItems,
  });

  Map<String, dynamic> toMap() {
    return {
      'requestItems': requestItems.map((x) => x.toMap()).toList(),
      'additionalItems': additionalItems.map((x) => x.toMap()).toList(),
    };
  }

  factory ResendSupplyRequestModel.fromMap(Map<String, dynamic> map) {
    return ResendSupplyRequestModel(
      requestItems: List<SupplyRequestCartModel>.from(
          map['requestItems']?.map((x) => SupplyRequestCartModel.fromMap(x))),
      additionalItems: List<AddAdditionalItemRequestModel>.from(
          map['additionalItems']
              ?.map((x) => AddAdditionalItemRequestModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResendSupplyRequestModel.fromJson(String source) =>
      ResendSupplyRequestModel.fromMap(json.decode(source));
}
