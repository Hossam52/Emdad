import 'dart:convert';

class UploadImageModel {
  bool status;
  List<String> images;
  UploadImageModel({
    required this.status,
    required this.images,
  });
  factory UploadImageModel.empty() {
    return UploadImageModel(status: true, images: []);
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'images': images,
    };
  }

  factory UploadImageModel.fromMap(Map<String, dynamic> map) {
    return UploadImageModel(
      status: map['status'] ?? false,
      images: List<String>.from(map['data']?['images']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadImageModel.fromJson(String source) =>
      UploadImageModel.fromMap(json.decode(source));
}
