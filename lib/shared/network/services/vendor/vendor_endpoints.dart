import 'package:emdad/shared/network/services/generate_path_variable.dart';

class VendorEndpoints {
  VendorEndpoints._();

  static const _path = 'vendor/';
  static const allSupplyRequests = _path + 'supplyRequests';
  static const products = _path + 'products';

  static String supplyRequest(String orderId) {
    return generatePathVariable(allSupplyRequests, orderId);
  }

  static String productDetails(String productId) {
    return generatePathVariable(products, productId);
  }
}
