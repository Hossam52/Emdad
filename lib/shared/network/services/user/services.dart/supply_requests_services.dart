import 'dart:developer';

import 'package:emdad/shared/componants/constants.dart';
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
}
