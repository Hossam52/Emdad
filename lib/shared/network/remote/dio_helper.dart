import 'package:dio/dio.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/network/end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) => true,
        headers: {
          'Content-Type': 'application/json',
          'Accept-Language': Constants.lang,
        },
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    Options? options,
  }) async {
    dio.options.headers = {
      'Authorization': token != null ? 'Bearer $token' : '',
      'Accept-Language': Constants.lang,
    };

    return await dio.get(
      url,
      queryParameters: query,
      options: options,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
    Options? options,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token != null ? 'Bearer $token' : '',
      'Accept-Language': Constants.lang,
    };

    return await dio.post(
      url,
      queryParameters: query,
      data: data,
      options: options,
    );
  }

  static Future<Response> postFormData({
    required String url,
    required FormData formData,
    Map<String, dynamic>? query,
    String? token,
    Options? options,
  }) async {
    dio.options.headers = {
      'Authorization': token != null ? 'Bearer $token' : '',
      'Accept-Language': Constants.lang,
    };

    return await dio.post(
      url,
      queryParameters: query,
      data: formData,
      options: options,
    );
  }

  /// Put Data Function
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept-Language': Constants.lang,
      'Authorization': token != null ? 'Bearer $token' : '',
    };
    return dio.put(
      url,
      data: (data)!,
      queryParameters: query,
    );
  }

  /// Delete data function
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept-Language': Constants.lang,
      'Authorization': token != null ? 'Bearer $token' : '',
    };

    return dio.delete(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
