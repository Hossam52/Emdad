import 'dart:developer';

import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/vendor/vendor_endpoints.dart';

class VendorServices {
  VendorServices._();

  static VendorServices get instance => VendorServices._();

  Future<Map<String, dynamic>> getAllSuplayRequests() async {
    log(Constants.token.toString());
    final res = await DioHelper.getData(
        url: VendorEndpoints.allSupplyRequests, token: Constants.vendorToken);
    log(res.data.toString());
    return res.data;
  }
}
