import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/user/user_endpoints.dart';

class ProductServices {
  ProductServices._();
  static ProductServices get instance => ProductServices._();
  Future<Map<String, dynamic>> getProduct(String productId) async {
    final response = await DioHelper.getData(
      url: UserEndPoints.vendorProduct(productId),
      token: Constants.userToken,
    );
    return response.data;
  }
}
