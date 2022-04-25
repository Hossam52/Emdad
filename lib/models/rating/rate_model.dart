import 'dart:convert';

class RateModel {
  String id;
  String targetId;
  String userId;
  String comment;
  String createdAt;
  bool isActive;
  double rating;
  String updateAt;
  RaterModel user;
  RateModel({
    required this.id,
    required this.targetId,
    required this.userId,
    required this.comment,
    required this.createdAt,
    required this.isActive,
    required this.rating,
    required this.updateAt,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'targetId': targetId,
      'userId': userId,
      'comment': comment,
      'createdAt': createdAt,
      'isActive': isActive,
      'rating': rating,
      'updateAt': updateAt,
      'user': user.toMap(),
    };
  }

  factory RateModel.fromMap(Map<String, dynamic> map) {
    return RateModel(
      id: map['id'] ?? '',
      targetId: map['targetId'] ?? '',
      userId: map['userId'] ?? '',
      comment: map['comment'] ?? '',
      createdAt: map['createdAt'] ?? '',
      isActive: map['isActive'] ?? false,
      rating: map['rating']?.toDouble() ?? 0.0,
      updateAt: map['updateAt'] ?? '',
      user: RaterModel.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RateModel.fromJson(String source) =>
      RateModel.fromMap(json.decode(source));
}

class RaterModel {
  bool isVerified;
  String name;
  String logo;
  List<String> vendorType;
  String country;
  String city;
  List<String> transportationMethods;
  String id;
  String logoUrl;
  RaterModel({
    required this.isVerified,
    required this.name,
    required this.logo,
    required this.vendorType,
    required this.country,
    required this.city,
    required this.transportationMethods,
    required this.id,
    required this.logoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'isVerified': isVerified,
      'name': name,
      'logo': logo,
      'vendorType': vendorType,
      'country': country,
      'city': city,
      'transportationMethods': transportationMethods,
      'id': id,
      'logoUrl': logoUrl,
    };
  }

  factory RaterModel.fromMap(Map<String, dynamic> map) {
    return RaterModel(
      isVerified: map['isVerified'] ?? false,
      name: map['name'] ?? '',
      logo: map['logo'] ?? '',
      vendorType: List<String>.from(map['vendorType']),
      country: map['country'] ?? '',
      city: map['city'] ?? '',
      transportationMethods: List<String>.from(map['transportationMethods']),
      id: map['id'] ?? '',
      logoUrl: map['logoUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RaterModel.fromJson(String source) =>
      RaterModel.fromMap(json.decode(source));
}
