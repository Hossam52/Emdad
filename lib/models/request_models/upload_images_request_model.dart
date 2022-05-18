import 'dart:io';

import 'package:dio/dio.dart';
import 'package:emdad/models/enums/enums.dart';

abstract class UploadImagesRequestModel {
  String type;
  UploadImagesRequestModel({
    required this.type,
  });
  Future<FormData> toFormData();
}

class UploadProductImagesRequestModel extends UploadImagesRequestModel {
  UploadProductImagesRequestModel(this.images)
      : super(type: ImageType.products.name);
  final List<File> images;
  @override
  Future<FormData> toFormData() async {
    final formData = FormData();
    for (var image in images) {
      String fileName = image.path.split('/').last;
      final multiplePart =
          await MultipartFile.fromFile(image.path, filename: fileName);
      formData.files.addAll([MapEntry('images', multiplePart)]);
    }
    return formData;
  }
}

class UploadUserImageRequestModel extends UploadImagesRequestModel {
  UploadUserImageRequestModel(this.logo) : super(type: ImageType.users.name);
  final File logo;
  @override
  Future<FormData> toFormData() async {
    final formData = FormData();

    String fileName = logo.path.split('/').last;
    final multiplePart =
        await MultipartFile.fromFile(logo.path, filename: fileName);
    formData.files.addAll([MapEntry('logo', multiplePart)]);

    return formData;
  }
}
