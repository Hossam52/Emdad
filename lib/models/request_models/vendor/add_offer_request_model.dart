import 'dart:convert';

class AddOfferRequestModel {
  double estimationInSeconds;
  double transportationPrice;
  List<RequestItemRequestModel> requestItems;
  List<AdditionalItemRequestModel> additionalItems;
  AddOfferRequestModel({
    required this.estimationInSeconds,
    required this.transportationPrice,
    required this.requestItems,
    required this.additionalItems,
  });

  Map<String, dynamic> toMap() {
    return {
      'estimationInSeconds': estimationInSeconds,
      'transportationPrice': transportationPrice,
      'requestItems': requestItems.map((x) => x.toMap()).toList(),
      'additionalItems': additionalItems.map((x) => x.toMap()).toList(),
    };
  }

  factory AddOfferRequestModel.fromMap(Map<String, dynamic> map) {
    return AddOfferRequestModel(
      estimationInSeconds: map['estimationInSeconds']?.toDouble() ?? 0.0,
      transportationPrice: map['transportationPrice']?.toDouble() ?? 0.0,
      requestItems: List<RequestItemRequestModel>.from(
          map['requestItems']?.map((x) => RequestItemRequestModel.fromMap(x))),
      additionalItems: List<AdditionalItemRequestModel>.from(
          map['additionalItems']
              ?.map((x) => AdditionalItemRequestModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddOfferRequestModel.fromJson(String source) =>
      AddOfferRequestModel.fromMap(json.decode(source));
}

class RequestItemRequestModel {
  String itemId;
  double totalPrice;
  RequestItemRequestModel({
    required this.itemId,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'totalPrice': totalPrice,
    };
  }

  factory RequestItemRequestModel.fromMap(Map<String, dynamic> map) {
    return RequestItemRequestModel(
      itemId: map['itemId'] ?? '',
      totalPrice: map['totalPrice'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestItemRequestModel.fromJson(String source) =>
      RequestItemRequestModel.fromMap(json.decode(source));
}

class AdditionalItemRequestModel {
  String itemId;
  double price;
  AdditionalItemRequestModel({
    required this.itemId,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'price': price,
    };
  }

  factory AdditionalItemRequestModel.fromMap(Map<String, dynamic> map) {
    return AdditionalItemRequestModel(
      itemId: map['itemId'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdditionalItemRequestModel.fromJson(String source) =>
      AdditionalItemRequestModel.fromMap(json.decode(source));
}
