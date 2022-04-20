import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/generate_path_variable.dart';
import 'package:emdad/shared/network/services/user/user_endpoints.dart';

class UserVendorServices {
  UserVendorServices._();
  static UserVendorServices get instance => UserVendorServices._();
  Future<Map<String, dynamic>> getVendorInfo({required String vendorId}) async {
    log(vendorId);
    final response = await DioHelper.getData(
      url: generatePathVariable(UserEndPoints.vendors, vendorId),
      token: Constants.userToken,
    );
    log(response.data.toString());
    return response.data;
  }
}
