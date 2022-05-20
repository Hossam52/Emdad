import 'dart:developer';

import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/user/user_endpoints.dart';

class HomeUserServices {
  HomeUserServices._();
  static HomeUserServices get instance => HomeUserServices._();
  Future<Map<String, dynamic>> getHomeData() async {
    final response = await DioHelper.getData(
        url: UserEndPoints.home, token: SharedMethods.getUserToken());
    log(response.data.toString());
    return response.data;
  }
}
