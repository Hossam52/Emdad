import 'dart:convert';

class SettingModel {
  bool? status;
  AllSettingsModel? data;

  SettingModel({this.status, this.data});

  SettingModel.fromMap(Map<String, dynamic> map) {
    status = map['status'];
    data = map['data'] != null
        ? AllSettingsModel.fromMap(map['data']['settings'])
        : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toMap();
    }
    return data;
  }
}

class AllSettingsModel {
  String? id;
  List<String>? vendorTypes;
  List<String>? transportationMethods;
  String? key;
  List<Countries>? countries;

  AllSettingsModel(
      {this.id,
      this.vendorTypes,
      this.transportationMethods,
      this.key,
      this.countries});
  AllSettingsModel.empty()
      : vendorTypes = [],
        countries = [],
        transportationMethods = [],
        key = '';
  AllSettingsModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    vendorTypes = json['vendorTypes'].cast<String>();
    transportationMethods = json['transportationMethods'].cast<String>();
    key = json['key'];
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(Countries.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendorTypes'] = vendorTypes;
    data['transportationMethods'] = transportationMethods;
    data['key'] = key;
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class Countries {
  String? countryCode;
  String? countryName;
  List<String>? cities;
  Countries({
    this.countryCode,
    this.countryName,
    this.cities,
  });

  Map<String, dynamic> toMap() {
    return {
      'countryCode': countryCode,
      'countryName': countryName,
      'cities': cities,
    };
  }

  factory Countries.fromMap(Map<String, dynamic> map) {
    return Countries(
      countryCode: map['countryCode'],
      countryName: map['countryName'],
      cities: List<String>.from(map['cities']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Countries.fromJson(String source) =>
      Countries.fromMap(json.decode(source));
}
