import 'package:emdad/shared/network/services/generate_path_variable.dart';

class UserEndPoints {
  UserEndPoints._();
  //Original path
  static const _path = 'user/';
  //
  static const home = _path + 'home';
  static const vendors = _path + 'vendors';
  static const supplyRequests = _path + 'supplyRequests';
  static const transportationRequests = _path + 'transportationRequests';

//
  static const products = 'products';

  static const favorite = 'favourite';

  static const resend = 'resend';
  static const accept = 'accept';

  static String vendor(String vendorID) {
    return generatePathVariable(vendors, vendorID);
  }

  static String vendorProducts(String vendorID) {
    return generatePathVariable(vendor(vendorID), products);
  }

  static String vendorFavorite(String vendorID) {
    return generatePathVariable(vendor(vendorID), favorite);
  }

  static String vendorProduct(String productId) {
    final productsPath = generatePathVariable(vendors, products);
    return generatePathVariable(productsPath, productId);
  }

  static String getSupplyRequestInfo(String orderId) {
    return generatePathVariable(supplyRequests, orderId);
  }

  static String supplyRequestInfo(String orderId) {
    return generatePathVariable(supplyRequests, orderId);
  }

  static String resendSupplyRequest(String orderId) {
    final orderInfoPath = supplyRequestInfo(orderId);
    return generatePathVariable(orderInfoPath, resend);
  }

  static String acceptSupplyRequest(String orderId) {
    final orderInfoPath = supplyRequestInfo(orderId);
    return generatePathVariable(orderInfoPath, accept);
  }
}
