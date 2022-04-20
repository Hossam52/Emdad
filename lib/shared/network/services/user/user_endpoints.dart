import 'package:emdad/shared/network/services/generate_path_variable.dart';

class UserEndPoints {
  UserEndPoints._();
  //Original path
  static const _path = 'user/';
  //
  static const home = _path + 'home';
  static const vendors = _path + 'vendors';

//
  static const products = 'products';
  static const favorite = 'favourite';

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
}
