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
      '_id': id,
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
      id: map['_id'] ?? '',
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
  String sId;
  String name;
  String city;
  String country;
  RaterModel({
    required this.sId,
    required this.name,
    required this.city,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': sId,
      'name': name,
      'city': city,
      'country': country,
    };
  }

  factory RaterModel.fromMap(Map<String, dynamic> map) {
    return RaterModel(
      sId: map['_id'] ?? '',
      name: map['name'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RaterModel.fromJson(String source) =>
      RaterModel.fromMap(json.decode(source));
}
