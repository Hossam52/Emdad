import 'dart:convert';

class FilterSupplyRequestModel {
  List<String> requestStatus;
  FilterSupplyRequestModel({
    required this.requestStatus,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    if (requestStatus.isNotEmpty) {
      for (int i = 0; i < requestStatus.length; i++) {
        map['requestStatus[$i]'] = requestStatus[i];
      }
    }
    return map;
  }

  factory FilterSupplyRequestModel.fromMap(Map<String, dynamic> map) {
    return FilterSupplyRequestModel(
      requestStatus: List<String>.from(map['requestStatus']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterSupplyRequestModel.fromJson(String source) =>
      FilterSupplyRequestModel.fromMap(json.decode(source));
}
