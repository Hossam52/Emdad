import 'package:emdad/models/request_models/transporter/create_price_request_model.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/transporter/transporter_endpoints.dart';

class TransporterOrderServices {
  TransporterOrderServices._();
  static TransporterOrderServices get instance => TransporterOrderServices._();
  Future<Map<String, dynamic>> getOrderDetails(String transportId) async {
    final response = await DioHelper.getData(
      url: TransporterEndPoints.transportDetails(transportId),
      token: SharedMethods.getUserToken(),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> createTransportPrice(
      CreatePriceRequestModel priceRequestModel) async {
    final response = await DioHelper.putData(
        url: TransporterEndPoints.transportationoffers,
        token: SharedMethods.getUserToken(),
        data: priceRequestModel.toMap());
    return response.data;
  }
}
