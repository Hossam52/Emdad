class UserSettingsModel {
  bool? status;
  Data? data;

  UserSettingsModel({this.status, this.data});

  UserSettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  Settings? settings;

  Data({this.settings});

  Data.fromJson(Map<String, dynamic> json) {
    settings =
        json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  }
}

class Settings {
  String? sId;
  List<String>? vendorTypes = [];
  List<String>? transportationMethods = [];
  String? key;
  List<Countries>? countries = [];

  Settings(
      {this.sId,
        this.vendorTypes,
        this.transportationMethods,
        this.key,
        this.countries});

  Settings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vendorTypes = json['vendorTypes'].cast<String>();
    transportationMethods = json['transportationMethods'].cast<String>();
    key = json['key'];
    if (json['countries'] != null) {
      json['countries'].forEach((v) {
        countries!.add(Countries.fromJson(v));
      });
    }
  }
}

class Countries {
  String? countryCode;
  List<String>? cities = [];

  Countries({this.countryCode, this.cities});

  Countries.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    cities = json['cities'].cast<String>();
  }
}