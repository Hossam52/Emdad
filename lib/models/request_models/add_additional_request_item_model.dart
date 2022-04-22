import 'dart:convert';

class AddAdditionalItemRequestModel {
  String description;
  AddAdditionalItemRequestModel({
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
    };
  }

  factory AddAdditionalItemRequestModel.fromMap(Map<String, dynamic> map) {
    return AddAdditionalItemRequestModel(
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddAdditionalItemRequestModel.fromJson(String source) =>
      AddAdditionalItemRequestModel.fromMap(json.decode(source));
}
