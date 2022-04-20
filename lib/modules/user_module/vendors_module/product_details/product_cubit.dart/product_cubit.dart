import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/models/users/user/product_details_model.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './product_states.dart';

//Bloc builder and bloc consumer methods
typedef ProductBlocBuilder = BlocBuilder<ProductCubit, ProductStates>;
typedef ProductBlocConsumer = BlocConsumer<ProductCubit, ProductStates>;

//
class ProductCubit extends Cubit<ProductStates> {
  ProductCubit({required this.productId}) : super(IntitalProductState());
  static ProductCubit instance(BuildContext context) =>
      BlocProvider.of<ProductCubit>(context);
  final String productId;
  //User services
  final UserServices _services = UserServices.instance;
  ProductDetailsModel? _productModel;
  bool get loadedProduct => _productModel != null;
  ProductModel get product => _productModel!.product;
  Future<void> getProduct() async {
    try {
      emit(GetProductLoadingState());
      final map = await _services.productServices.getProduct(productId);
      _productModel = ProductDetailsModel.fromMap(map);
      emit(GetProductSuccessState());
    } catch (e) {
      emit(GetProductErrorState(error: e.toString()));
    }
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
