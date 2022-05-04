import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/models/users/user/product_details_model.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';
import 'package:emdad/shared/network/services/vendor/vendor_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './product_states.dart';

//Bloc builder and bloc consumer methods
typedef ProductBlocBuilder = BlocBuilder<ProductCubit, ProductStates>;
typedef ProductBlocConsumer = BlocConsumer<ProductCubit, ProductStates>;

//
class ProductCubit extends Cubit<ProductStates> {
  ProductCubit({required this.isVendor, required this.productId})
      : super(IntitalProductState());
  static ProductCubit instance(BuildContext context) =>
      BlocProvider.of<ProductCubit>(context);
  final String productId;
  final bool isVendor;
  //User services
  final UserServices _userServices = UserServices.instance;
  //Vendor services
  final VendorServices _vendorServices = VendorServices.instance;

  ProductDetailsModel? _productModel;
  bool get loadedProduct => _productModel != null;
  ProductModel get product => _productModel!.product;
  Future<void> getProduct() async {
    try {
      emit(GetProductLoadingState());
      if (isVendor) {
        await _vendorGetProduct();
      } else {
        await _userGetProduct();
      }

      emit(GetProductSuccessState());
    } catch (e) {
      emit(GetProductErrorState(error: e.toString()));
    }
  }

  Future<void> _userGetProduct() async {
    final map = await _userServices.productServices.getProduct(productId);
    _productModel = ProductDetailsModel.fromMap(map);
  }

  Future<void> _vendorGetProduct() async {
    final map = await _vendorServices.productServices.productDetails(productId);
    _productModel = ProductDetailsModel.fromMap(map);
  }

  Future<void> toggleProductFavorite() async {
    try {
      emit(ToggleProductFavoriteLoadingState());
      emit(ToggleProductFavoriteSuccessState());
    } catch (e) {
      emit(ToggleProductFavoriteErrorState(error: e.toString()));
    }
  }
}
