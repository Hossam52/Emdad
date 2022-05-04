import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:emdad/models/request_models/upload_images_request_model.dart';
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

  Future<Map<String, dynamic>> uploadImages(
      UploadImagesRequestModel imagesRequestModel) async {
    final formData = await imagesRequestModel.toFormData();
    formData.fields.add(MapEntry('type', imagesRequestModel.type));
    final response = await DioHelper.postFormData(
        url: GeneralEndPoints.uploadImages, token: null, formData: formData);
    return response.data;
  }
}
