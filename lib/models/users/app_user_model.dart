class AppUserModel {
  late String organizationName;
  late String commercialRegister;
  late String country;
  late String city;
  late LocationData locationData;

  AppUserModel({
    required this.organizationName,
    required this.commercialRegister,
    required this.country,
    required this.city,
    required this.locationData,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oraganizationName'] = organizationName;
    data['country'] = country;
    data['city'] = city;
    data['commercialRegister'] = commercialRegister;
    data['location'] = locationData.toJson();
    return data;
  }

}

class LocationData {
  late double latitude;
  late double longitude;

  LocationData({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = latitude;
    data['lng'] = longitude;
    return data;
  }
}
