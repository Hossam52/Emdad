import 'dart:convert';

class ToggleFavoriteModel {
  bool status;
  String message;
  ToggleFavoriteModel({
    required this.status,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory ToggleFavoriteModel.fromMap(Map<String, dynamic> map) {
    return ToggleFavoriteModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ToggleFavoriteModel.fromJson(String source) =>
      ToggleFavoriteModel.fromMap(json.decode(source));
}
