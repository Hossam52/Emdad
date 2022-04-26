import 'dart:developer';

import 'package:emdad/models/request_models/create_supply_request_model.dart';
import 'package:emdad/models/request_models/create_transportation_request_model.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/user/user_endpoints.dart';

class SupplyRequestServices {
  SupplyRequestServices._();
  static SupplyRequestServices get instance => SupplyRequestServices._();
  Future<Map<String, dynamic>> getRequestOffers() async {
    final response = await DioHelper.getData(
        url: UserEndPoints.supplyRequests, token: Constants.userToken);
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

  Future<Map<String, dynamic>> getMyOrders({String? paginationToken}) async {
    final response = await DioHelper.getData(
        url: UserEndPoints.supplyRequests,
        token: Constants.userToken,
        query: {
          if (paginationToken != null) 'paginationToken': paginationToken
        });
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
}
