import 'package:emdad/models/request_models/vendor/add_offer_request_model.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/vendor/vendor_endpoints.dart';

class VendorSupplyRequestServices {
  VendorSupplyRequestServices._();
  static VendorSupplyRequestServices get instance =>
      VendorSupplyRequestServices._();

  Future<Map<String, dynamic>> getOrder(String orderId) async {
    final response = await DioHelper.getData(
        url: VendorEndpoints.supplyRequest(orderId),
        token: SharedMethods.getUserToken());
    return response.data;
  }

  Future<Map<String, dynamic>> quoteOrder(
      {required String orderId,
      required AddOfferRequestModel offerRequestModel}) async {
    final response = await DioHelper.postData(
      url: VendorEndpoints.supplyRequest(orderId),
      token: SharedMethods.getUserToken(),
      data: offerRequestModel.toMap(),
    );
    return response.data;
  }
}
