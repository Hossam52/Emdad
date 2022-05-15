import 'dart:developer';

import 'package:emdad/models/request_models/pagination_request_model.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/transporter/transporter_endpoints.dart';

class TransporterOrdersServices {
  TransporterOrdersServices._();
  static TransporterOrdersServices get instance =>
      TransporterOrdersServices._();
  Future<Map<String, dynamic>> getOffers(
      {PaginationRequestModel? pagination}) async {
    final response = await DioHelper.getData(
        url: TransporterEndPoints.transportationRequests,
        token: SharedMethods.getUserToken(),
        query: pagination?.toMap());
    log(response.toString());
    return response.data;
  }

  Future<Map<String, dynamic>> getPurchaseOrders(
      {PaginationRequestModel? pagination}) async {
    final response = await DioHelper.getData(
        url: TransporterEndPoints.transportationOrders,
        token: SharedMethods.getUserToken(),
        query: pagination?.toMap());
    log(response.toString());
    return response.data;
  }
}
