import 'package:emdad/shared/network/services/generate_path_variable.dart';

class VendorEndpoints {
  VendorEndpoints._();

  static const _path = 'vendor/';
  static const allSupplyRequests = _path + 'supplyRequests';
  static const products = _path + 'products';
  static const transportations = _path + 'transportationRequests';
  static const offers = _path + 'transportationOffers';

  static String supplyRequest(String orderId) {
    return generatePathVariable(allSupplyRequests, orderId);
  }

  static String productDetails(String productId) {
    return generatePathVariable(products, productId);
  }

  static String transportationOffers(String transportationId) {
    final transportationPath =
        generatePathVariable(transportations, transportationId);
    return generatePathVariable(transportationPath, 'transportationOffers');
  }

  static String acceptOffer(String offerId) {
    return generatePathVariable(offers, offerId);
  }
}
