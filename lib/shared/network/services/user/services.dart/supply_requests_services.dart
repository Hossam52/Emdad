import 'dart:developer';

import 'package:emdad/models/request_models/user/create_supply_request_model.dart';
import 'package:emdad/models/request_models/user/create_transportation_request_model.dart';
import 'package:emdad/models/request_models/pagination_request_model.dart';
import 'package:emdad/models/request_models/user/create_transportation_request_model.dart';
import 'package:emdad/models/request_models/filter_supply_request_model.dart';
import 'package:emdad/models/request_models/user/resend_supply_request_model.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/user/user_endpoints.dart';

class SupplyRequestServices {
  SupplyRequestServices._();
  static SupplyRequestServices get instance => SupplyRequestServices._();
  Future<Map<String, dynamic>> getRequestOffers(
      FilterSupplyRequestModel filterSupplyRequestModel,
      {PaginationRequestModel? pagination}) async {
    final map = filterSupplyRequestModel.toMap();
    map.addAll(pagination?.toMap() ?? {});
    final response = await DioHelper.getData(
        query: map,
        url: UserEndPoints.supplyRequests,
        token: SharedMethods.getUserToken());
    return response.data;
  }

  //Get specific order details
  Future<Map<String, dynamic>> getOrder({required String orderId}) async {
    final response = await DioHelper.getData(
      url: UserEndPoints.getSupplyRequestInfo(orderId),
      token: SharedMethods.getUserToken(),
    );
    log(response.data.toString());
    return response.data;
  }

  Future<Map<String, dynamic>> createSupplyRequest(
      CreateSupplyRequestModel requestModel) async {
    log(requestModel.toMap().toString());
    final response = await DioHelper.putData(
        url: UserEndPoints.supplyRequests,
        token: SharedMethods.getUserToken(),
        data: requestModel.toMap());
    log(response.data.toString());
    return response.data;
  }

  Future<Map<String, dynamic>> getMyOrders(
      FilterSupplyRequestModel filterSupplyRequestModel,
      {PaginationRequestModel? pagination}) async {
    final Map<String, dynamic> map = filterSupplyRequestModel.toMap();
    map.addAll(pagination?.toMap() ?? <String, dynamic>{});
    final response = await DioHelper.getData(
        url: UserEndPoints.supplyRequests,
        token: SharedMethods.getUserToken(),
        query: map);
    return response.data;
  }

  Future<Map<String, dynamic>> createTransportationRequest(
      CreateTransportationRequestModel transportationRequestModel) async {
    final response = await DioHelper.putData(
        url: UserEndPoints.transportationRequests,
        token: SharedMethods.getUserToken(),
        data: transportationRequestModel.toMap());
    return response.data;
  }

  Future<Map<String, dynamic>> resendSupplyRequestData(
      String orderId, ResendSupplyRequestModel resendModel) async {
    final response = await DioHelper.postData(
        url: UserEndPoints.resendSupplyRequest(orderId),
        token: SharedMethods.getUserToken(),
        data: resendModel.toMap());
    return response.data;
  }

  Future<Map<String, dynamic>> acceptOffer(String orderId) async {
    final response = await DioHelper.postData(
      url: UserEndPoints.acceptSupplyRequest(orderId),
      token: SharedMethods.getUserToken(),
      data: {},
    );
    return response.data;
  }
}
