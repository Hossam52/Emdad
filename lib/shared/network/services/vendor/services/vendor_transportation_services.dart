import 'dart:developer';

import 'package:emdad/models/request_models/user/create_transportation_request_model.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/vendor/vendor_endpoints.dart';

class VendorTransportationServices {
  VendorTransportationServices._();
  static VendorTransportationServices get instance =>
      VendorTransportationServices._();

  Future<Map<String, dynamic>> getTransportationOffers(
      final transportationId) async {
    final response = await DioHelper.getData(
        url: VendorEndpoints.transportationOffers(transportationId),
        token: SharedMethods.getUserToken());
    return response.data;
  }

  Future<Map<String, dynamic>> acceptOffer(String offerId) async {
    log('Before');
    final response = await DioHelper.postData(
        url: VendorEndpoints.acceptOffer(offerId),
        token: SharedMethods.getUserToken(),
        data: {});
    log(response.data.toString());

    return response.data;
  }

  Future<Map<String, dynamic>> createTransportRequest(
      CreateTransportationRequestModel transportRequestModel) async {
    final response = await DioHelper.putData(
        data: transportRequestModel.toMap(),
        url: VendorEndpoints.transportations,
        token: SharedMethods.getUserToken());
    return response.data;
  }
}
