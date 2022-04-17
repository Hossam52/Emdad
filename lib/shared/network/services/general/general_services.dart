import 'dart:developer';

import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/network/services/general/general_endpoints.dart';

class GeneralServices {
  GeneralServices._();
  static GeneralServices get instance => GeneralServices._();
  Future<Map<String, dynamic>> getAppSettings() async {
    final res = await DioHelper.getData(url: GeneralEndPoints.settings);
    log(res.data.toString());
    return res.data;
  }
}
