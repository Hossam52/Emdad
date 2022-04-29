import 'dart:convert';

import 'package:emdad/shared/componants/constants.dart';

class PaginationRequestModel {
  String? paginationToken;
  int limit;
  PaginationRequestModel({
    this.paginationToken,
    this.limit = Constants.paginationSize,
  });

  Map<String, dynamic> toMap() {
    return {
      if (paginationToken != null) 'paginationToken': paginationToken,
      'limit': limit,
    };
  }

  factory PaginationRequestModel.fromMap(Map<String, dynamic> map) {
    return PaginationRequestModel(
      paginationToken: map['paginationToken'] ?? '',
      limit: map['limit']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginationRequestModel.fromJson(String source) =>
      PaginationRequestModel.fromMap(json.decode(source));
}
