import 'dart:convert';

import 'package:emdad/models/transportations/transportation_offer_model.dart';

class TransportationOffersModel {
  bool status;
  String message;
  List<TransportationOfferModel> transportationOffers;
  TransportationOffersModel({
    required this.status,
    required this.message,
    required this.transportationOffers,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'transportationOffers':
          transportationOffers.map((x) => x.toMap()).toList(),
    };
  }

  factory TransportationOffersModel.fromMap(Map<String, dynamic> map) {
    return TransportationOffersModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
      transportationOffers: List<TransportationOfferModel>.from(map['data']
              ?['transportationOffers']
          ?.map((x) => TransportationOfferModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransportationOffersModel.fromJson(String source) =>
      TransportationOffersModel.fromMap(json.decode(source));
}
