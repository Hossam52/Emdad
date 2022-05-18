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

class UploadPersonalImageModel {
  bool status;
  String logo;
  UploadPersonalImageModel({
    required this.status,
    required this.logo,
  });
  factory UploadPersonalImageModel.empty() {
    return UploadPersonalImageModel(status: false, logo: '');
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'logo': logo,
    };
  }

  factory UploadPersonalImageModel.fromMap(Map<String, dynamic> map) {
    return UploadPersonalImageModel(
      status: map['status'] ?? false,
      logo: map['data']?['logo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadPersonalImageModel.fromJson(String source) =>
      UploadPersonalImageModel.fromMap(json.decode(source));
}
