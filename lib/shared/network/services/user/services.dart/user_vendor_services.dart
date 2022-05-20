import 'dart:developer';

import 'package:emdad/models/request_models/user/category_request_model.dart';
import 'package:emdad/models/request_models/user/filter_vendors_request.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/user/user_endpoints.dart';

class UserVendorServices {
  UserVendorServices._();
  static UserVendorServices get instance => UserVendorServices._();
  Future<Map<String, dynamic>> getVendorInfo({required String vendorId}) async {
    log(vendorId);
    final response = await DioHelper.getData(
      url: UserEndPoints.vendor(vendorId),
      token: SharedMethods.getUserToken(),
    );
    log(response.data.toString());
    return response.data;
  }

  Future<Map<String, dynamic>> getProductsInCategory(
      {required String vendorID,
      required CategoryRequestModel categoryRequestModel}) async {
    log(categoryRequestModel.toMap().toString());
    final response = await DioHelper.getData(
        url: UserEndPoints.vendorProducts(vendorID),
        token: SharedMethods.getUserToken(),
        query: categoryRequestModel.toMap());
    log(response.data.toString());
    return response.data;
  }

  Future<Map<String, dynamic>> toggleVendorFavorite(String vendorId) async {
    final response = await DioHelper.postData(
      url: UserEndPoints.vendorFavorite(vendorId),
      token: SharedMethods.getUserToken(),
      data: {},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> allVendors(
      {FilterVendorRequest? filterRequest}) async {
    final response = await DioHelper.getData(
      url: UserEndPoints.vendors,
      token: SharedMethods.getUserToken(),
      query: filterRequest?.toMap(),
    );
    log(filterRequest?.toMap().toString() ?? '');
    return response.data;
  }

  Future<Map<String, dynamic>> favoriteVendors(
      {FilterVendorRequest? filterRequest}) async {
    final response = await DioHelper.getData(
      url: UserEndPoints.getFavoriteVendors,
      token: SharedMethods.getUserToken(),
      query: filterRequest?.toMap(),
    );
    log(filterRequest?.toMap().toString() ?? '');
    return response.data;
  }
}
