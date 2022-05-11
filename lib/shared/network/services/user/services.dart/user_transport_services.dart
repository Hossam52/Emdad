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
}
