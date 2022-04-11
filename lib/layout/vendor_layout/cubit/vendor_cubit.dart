import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:emdad/models/general_models/product_detailes.dart';
import 'package:emdad/modules/settings/setting_screen.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_offers_view/vendor_offers_screen.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_products_screen.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/vendor_purchase_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'vendor_state.dart';

class VendorCubit extends Cubit<VendorState> {
  VendorCubit() : super(VendorInitial());

  static VendorCubit get(context) => BlocProvider.of(context);

  File? productImage;
  List<XFile>? productOtherImages = [];
  ImagePicker get picker => _picker;
  final ImagePicker _picker = ImagePicker();

  Future<void> getProductImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      productImage = File(pickedFile.path);
      emit(ProductImagePickedSuccessState());
    } else {
      print('No image selected. ');
      emit(ProductImagePickedErrorState());
    }
  }

  Future<void> getProductOtherImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles!.isNotEmpty) {
      productOtherImages!.addAll(pickedFiles);
      emit(ProductPickedMultiImagesSuccessState());
    } else {
      print('No images selected. ');
      emit(ProductPickedMultiImagesErrorState());
    }

    print(
        'Image list length selected. ' + productOtherImages!.length.toString());
  }

  void removeProductImage() {
    productImage = null;
    emit(RemoveProductImageStateState());
  }

  void removeProductOtherImages(int index) {
    productOtherImages!.removeAt(index);
    emit(RemoveProductOtherImagesStateState());
  }

  bool? isSelected = false;

  List<ProductDetailsModel> products = [
    ProductDetailsModel(
      productId: 1,
      unit: 'طن',
      minimum: '٤',
      itemPrice: '٤٠٠',
      tax: '١٥٪',
    ),
    ProductDetailsModel(
      productId: 2,
      unit: 'طن',
      minimum: '٤',
      itemPrice: '٤٠٠',
      tax: '١٥٪',
    ),
    ProductDetailsModel(
      productId: 3,
      unit: 'طن',
      minimum: '٤',
      itemPrice: '٤٠٠',
      tax: '١٥٪',
    ),
    ProductDetailsModel(
      productId: 4,
      unit: 'طن',
      minimum: '٤',
      itemPrice: '٤٠٠',
      tax: '١٥٪',
    ),
  ];

  changeCheckBoxState(bool value) {
    isSelected = value;
    emit(ChangeCheckBoxState());
  }

  deletePriceDetails(int index) {
    products.removeAt(index);
    emit(DeletePriceDetailsState());
  }

  int currentPageIndex = 0;

  List<String> titles = [
    'طلب عرض سعر',
    'منتجاتي',
    'طلبات أوامر الشراء',
    'الملف الشخصي',
  ];

  List<Widget> screens = [
    const VendorOffersScreen(),
    VendorProductsScreen(),
    const VendorPurchaseOrdersScreen(),
    const SettingsScreen(),
  ];

  void changeIndex(int index) {
    currentPageIndex = index;
    emit(ChangeBottomNavBarState());
  }
}
