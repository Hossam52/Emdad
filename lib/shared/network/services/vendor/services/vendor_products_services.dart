import 'dart:developer';

import 'package:emdad/models/request_models/pagination_request_model.dart';
import 'package:emdad/models/request_models/vendor/add_product_request_model.dart';
import 'package:emdad/models/request_models/vendor/filter_vendor_products_request_model.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/vendor/vendor_endpoints.dart';

class VendorProductsServices {
  VendorProductsServices._();
  static VendorProductsServices get instance => VendorProductsServices._();
  Future<Map<String, dynamic>> getAllProducts(
      {FilterVendorProductsRequestModel? filterProducts,
      PaginationRequestModel? pagination}) async {
    final Map<String, dynamic> map = filterProducts?.toMap() ?? {};

    map.addAll(pagination?.toMap() ?? {});
    final response = await DioHelper.getData(
        url: VendorEndpoints.products,
        token: SharedMethods.getUserToken(),
        query: map);
    return response.data;
  }

  Future<Map<String, dynamic>> productDetails(String productId) async {
    final response = await DioHelper.getData(
        url: VendorEndpoints.productDetails(productId),
        token: SharedMethods.getUserToken());
    return response.data;
  }

  Future<Map<String, dynamic>> addProduct(
      AddProductRequestModel productModel) async {
    log(productModel.toMap().toString());
    final response = await DioHelper.putData(
        url: VendorEndpoints.products,
        token: SharedMethods.getUserToken(),
        data: productModel.toMap());
    return response.data;
  }
}
