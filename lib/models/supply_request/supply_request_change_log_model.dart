import 'dart:convert';

import 'package:emdad/models/enums/enums.dart';

class SupplyRequestChangeLogsModel {
  String? awaitingQuotation;
  String? awaitingApproval;
  String? preparing;
  String? awaitingTransportation;
  String? onWay;
  String? delivered;
  SupplyRequestChangeLogsModel({
    this.awaitingQuotation,
    this.awaitingApproval,
    this.preparing,
    this.awaitingTransportation,
    this.onWay,
    this.delivered,
  });

  Map<String, dynamic> toMap() {
    return {
      'awaitingQuotation': awaitingQuotation,
      'awaitingApproval': awaitingApproval,
      'preparing': preparing,
      'awaitingTransportation': awaitingTransportation,
      'onWay': onWay,
      'delivered': delivered,
    };
  }

  factory SupplyRequestChangeLogsModel.fromMap(Map<String, dynamic> map) {
    return SupplyRequestChangeLogsModel(
      awaitingQuotation: map['awaitingQuotation'],
      awaitingApproval: map['awaitingApproval'],
      preparing: map['preparing'],
      awaitingTransportation: map['awaitingTransportation'],
      onWay: map['onWay'],
      delivered: map['delivered'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplyRequestChangeLogsModel.fromJson(String source) =>
      SupplyRequestChangeLogsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SupplyRequestChangeLogsModel(awaitingQuotation: $awaitingQuotation, awaitingApproval: $awaitingApproval, preparing: $preparing, awaitingTransportation: $awaitingTransportation, onWay: $onWay, delivered: $delivered)';
  }
}
