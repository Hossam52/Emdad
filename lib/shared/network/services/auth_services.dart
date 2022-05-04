import 'package:dio/dio.dart';
import 'package:emdad/models/request_models/change_email_request_model.dart';
import 'package:emdad/models/request_models/change_password_request_model.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/network/end_points.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';

class AuthServices {
  static Future<Response> login(Map<String, dynamic> data) async {
    final Response response = await DioHelper.postData(
      url: EndPoints.login,
      data: data,
    );
    return response;
  }

  static Future<Response> registerUser(Map<String, dynamic> data) async {
    final Response response = await DioHelper.postData(
      url: EndPoints.register,
      data: data,
    );
    return response;
  }

  static Future<Response> verifyOtp(
      Map<String, dynamic> data, String token) async {
    final Response response = await DioHelper.postData(
      url: EndPoints.verifyOtp,
      token: token,
      data: data,
    );
    return response;
  }

  static Future<Response> resendOtp(
      Map<String, dynamic> data, String token) async {
    final Response response = await DioHelper.postData(
      url: EndPoints.resendOtp,
      token: token,
      data: data,
    );
    return response;
  }

  static Future<Response> completeProfile(
      Map<String, dynamic> data, String token) async {
    final Response response = await DioHelper.postData(
      url: EndPoints.completeProfile,
      token: token,
      data: data,
    );
    return response;
  }

  static Future<Response> getUserSettings() async {
    final Response response = await DioHelper.getData(
      url: EndPoints.userSettings,
    );
    return response;
  }

  static Future<Map<String, dynamic>> changePassword(
      {required String token,
      required ChangePasswordRequestModel changePasswordRequestModel}) async {
    final response = await DioHelper.postData(
      url: EndPoints.changePassword,
      token: token,
      data: changePasswordRequestModel.toMap(),
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> changeEmail(
      {required ChangeEmailRequestModel changeEmailRequestModel}) async {
    final response = await DioHelper.postData(
      url: EndPoints.changeEmail,
      token: SharedMethods.getUserToken(),
      data: changeEmailRequestModel.toMap(),
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> getProfile() async {
    final response = await DioHelper.getData(
        url: EndPoints.getProfile, token: SharedMethods.getUserToken());
    return response.data;
  }
}
