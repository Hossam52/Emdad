import 'dart:developer';
import 'dart:io';

import 'package:emdad/models/general_models/upload_image_model.dart';
import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/models/request_models/upload_images_request_model.dart';
import 'package:emdad/shared/network/services/general/general_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './vendor_product_crud_states.dart';

//Bloc builder and bloc consumer methods
typedef VendorProductCrudCubitBlocBuilder
    = BlocBuilder<VendorProductCrudCubit, VendorProductCrudStates>;
typedef VendorProductCrudCubitBlocConsumer
    = BlocConsumer<VendorProductCrudCubit, VendorProductCrudStates>;

//
class VendorProductCrudCubit extends Cubit<VendorProductCrudStates> {
  VendorProductCrudCubit(this._product)
      : super(IntitalVendorProductCrudCubitState()) {
    _units = List.from(_product.units);

    _originalProductImages = List<String>.from(_product.images).sublist(1);
    _originalMainImage = _product.images.first;

    productNameController.text = _product.name;
    productDescriptionController.text = _product.description;
  }
  static VendorProductCrudCubit instance(BuildContext context) =>
      BlocProvider.of<VendorProductCrudCubit>(context);
  final _generalServices = GeneralServices.instance;

  //For product controllers
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();

  //For image selection
  ImagePicker get picker => _picker;
  final ImagePicker _picker = ImagePicker();

  //Product details
  final ProductModel _product;
  ProductModel get product => _product;

  List<ProductUnit> _units = [];
  List<ProductUnit> get units => _units;

  List<String> _originalProductImages =
      []; //For the images that come from backend that displaed throw network image
  String _originalMainImage = '';
  String get originalMainImage =>
      _originalMainImage; //Take first image to be the preview for the product
  List<String> get originalProductImages =>
      _originalProductImages; //The rest of images except the first (previview)

  File?
      _mainProductImageFile; //null if the vendor not select main image from phone
  File get mainProductImageFile => _mainProductImageFile!;
  bool get hasPickedMainFile => _mainProductImageFile != null;

  final List<File> _productImagesFromFiles =
      []; //For all images picked from phone except the main image
  List<File> get productImagesFromFiles => _productImagesFromFiles;
  bool get isEmptyImages =>
      originalProductImages.isEmpty && productImagesFromFiles.isEmpty;

  //Pick images for the product
  Future<void> pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      final files = pickedFiles.map((e) => File(e.path));
      _productImagesFromFiles.addAll(files);
      emit(PickImagesSuccess());
    } else {
      emit(PickImagesError(error: 'No images Selected'));
    }
  }

  //Pick main image for the preview (first image)
  Future<void> pickMainImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _mainProductImageFile = File(pickedFile.path);
      emit(PickImagesSuccess());
    } else {
      print('No image selected. ');
      emit(PickImagesError(error: 'No image selected'));
    }
  }

  void changePriceVisibility(bool val) {
    _product.isPriceShown = val;
    emit(ChangePriceVisibility());
  }

  //For modify prices
  void addPriceUnit(
      {required String productUnit,
      required int minimumAmount,
      required double pricePerUnit}) {
    _units.add(ProductUnit(
        productUnit: productUnit,
        pricePerUnit: pricePerUnit,
        minimumAmountPerOrder: minimumAmount));
    emit(AddPriceUnit());
  }

  void removePriceUnit(int unitIndex) {
    _units.removeAt(unitIndex);
    emit(RemovePriceUnit());
  }

  //For remove images that is original from backend
  void removeOriginalImage(int index) {
    _originalProductImages.removeAt(index);
    emit(RemoveImage());
  }

  //For remove images that picked from phone
  void removeFileImage(int index) {
    _productImagesFromFiles.removeAt(index);
    emit(RemoveImage());
  }

  //For update product api

  Future<void> editProduct() async {
    try {
      emit(EditProductLoadingState());
      log(originalProductImages.length.toString());
      log(_productImagesFromFiles.length.toString());
      // throw '';
      final imagesModel = await _uploadSelectedImagesToServer();
      if (imagesModel.status) {
        final allImages = _getAllImagesList(imagesModel.images);
        final String productName = productNameController.text;
        final String description = productDescriptionController.text;
        final bool isPriceShown = product.isPriceShown;
      } else {
        throw 'Error happened';
      }
      emit(EditProductSuccessState());
    } catch (e) {
      emit(EditProductErrorState(error: e.toString()));
    }
  }

  Future<UploadImageModel> _uploadSelectedImagesToServer() async {
    final uploadedFiles = List<File>.from(_productImagesFromFiles);
    if (uploadedFiles.isEmpty) return UploadImageModel.empty();
    if (_mainProductImageFile != null) {
      uploadedFiles.insert(0,
          _mainProductImageFile!); //insert the preview image at the first to know it when come from api
    }
    final map = await _generalServices
        .uploadImages(UploadProductImagesRequestModel(uploadedFiles));
    final allImages = UploadImageModel.fromMap(map);
    return allImages;
  }

  List<String> _getAllImagesList(List<String> incomingImagesList) {
    final List<String> allImages = incomingImagesList;
    if (_mainProductImageFile == null) {
      //Means that the vendor not upload preview image
      allImages.insert(0, _originalMainImage); //Insert the first original one
    }
    if (originalProductImages.isNotEmpty) {
      //Keep the original images as they in list
      allImages.insertAll(1, originalProductImages);
    }
    return allImages;
  }
}
