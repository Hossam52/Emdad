import 'dart:developer';

import 'package:emdad/models/request_models/user/create_transportation_request_model.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/user/user_endpoints.dart';

class UserTransportServices {
  UserTransportServices._();
  static UserTransportServices get instance => UserTransportServices._();

  Future<Map<String, dynamic>> createTransportRequest(
      CreateTransportationRequestModel transportRequestModel) async {
    final response = await DioHelper.putData(
        data: transportRequestModel.toMap(),
        url: UserEndPoints.transportationRequests,
        token: SharedMethods.getUserToken());
    return response.data;
  }

  Future<Map<String, dynamic>> getTransportationOffers(
      final transportationId) async {
    final response = await DioHelper.getData(
        url: UserEndPoints.transportationOffers(transportationId),
        token: SharedMethods.getUserToken());
    return response.data;
  }

  Future<Map<String, dynamic>> acceptOffer(String offerId) async {
    log('Before');
    final response = await DioHelper.postData(
        url: UserEndPoints.acceptOffer(offerId),
        token: SharedMethods.getUserToken(),
        data: {});
    log(response.data.toString());

    return response.data;
  }
}
