import 'dart:developer';

import 'package:emdad/models/request_models/filter_supply_request_model.dart';
import 'package:emdad/models/request_models/pagination_request_model.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/vendor/services/vendor_products_services.dart';
import 'package:emdad/shared/network/services/vendor/services/vendor_supply_request_services.dart';
import 'package:emdad/shared/network/services/vendor/services/vendor_transportation_services.dart';
import 'package:emdad/shared/network/services/vendor/vendor_endpoints.dart';

class VendorServices {
  VendorServices._();

  static VendorServices get instance => VendorServices._();
  VendorSupplyRequestServices get supplyRequestServices =>
      VendorSupplyRequestServices.instance;
  VendorProductsServices get productServices => VendorProductsServices.instance;
  VendorTransportationServices get transportationServices =>
      VendorTransportationServices.instance;

  Future<Map<String, dynamic>> getAllSuplayRequests(
      {FilterSupplyRequestModel? filterOrders,
      PaginationRequestModel? pagination}) async {
    final Map<String, dynamic> map = filterOrders?.toMap() ?? {};
    map.addAll(pagination?.toMap() ?? {});
    log(map.toString());
    final res = await DioHelper.getData(
        url: VendorEndpoints.allSupplyRequests,
        token: Constants.vendorToken,
        query: map);
    return res.data;
  }
}
