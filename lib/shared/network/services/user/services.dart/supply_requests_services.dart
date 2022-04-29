import 'dart:developer';

import 'package:emdad/models/request_models/user/create_supply_request_model.dart';
import 'package:emdad/models/request_models/user/create_transportation_request_model.dart';
import 'package:emdad/models/request_models/pagination_request_model.dart';
import 'package:emdad/models/request_models/user/create_transportation_request_model.dart';
import 'package:emdad/models/request_models/user/resend_supply_request_model.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/user/user_endpoints.dart';

class SupplyRequestServices {
  SupplyRequestServices._();
  static SupplyRequestServices get instance => SupplyRequestServices._();
  Future<Map<String, dynamic>> getRequestOffers(
      {PaginationRequestModel? pagination}) async {
    final response = await DioHelper.getData(
        query: pagination?.toMap(),
        url: UserEndPoints.supplyRequests,
        token: Constants.userToken);
    return response.data;
  }

  //Get specific order details
  Future<Map<String, dynamic>> getOrder({required String orderId}) async {
    final response = await DioHelper.getData(
      url: UserEndPoints.getSupplyRequestInfo(orderId),
      token: Constants.userToken,
    );
    log(response.data.toString());
    return response.data;
  }

  Future<Map<String, dynamic>> createSupplyRequest(
      CreateSupplyRequestModel requestModel) async {
    log(requestModel.toMap().toString());
    final response = await DioHelper.putData(
        url: UserEndPoints.supplyRequests,
        token: Constants.userToken,
        data: requestModel.toMap());
    log(response.data.toString());
    return response.data;
  }

  Future<Map<String, dynamic>> getMyOrders(
      {PaginationRequestModel? pagination}) async {
    final response = await DioHelper.getData(
        url: UserEndPoints.supplyRequests,
        token: Constants.userToken,
        query: pagination?.toMap());
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
