import 'dart:developer';

import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/models/request_models/pagination_request_model.dart';
import 'package:emdad/models/request_models/vendor/filter_vendor_products_request_model.dart';
import 'package:emdad/models/users/user/all_category_products_model.dart';
import 'package:emdad/shared/network/services/vendor/vendor_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'vendor_product_states.dart';

//Bloc builder and bloc consumer methods
typedef VendorProductsBlocBuilder
    = BlocBuilder<VendorProductsCubit, VendorProductStates>;
typedef VendorProductsBlocConsumer
    = BlocConsumer<VendorProductsCubit, VendorProductStates>;

//
class VendorProductsCubit extends Cubit<VendorProductStates> {
  VendorProductsCubit() : super(IntitalProductState());
  static VendorProductsCubit instance(BuildContext context) =>
      BlocProvider.of<VendorProductsCubit>(context);
  final _services = VendorServices.instance;

  AllCategoryProductsModel? _productsModel;
  bool get isAllProductsNotLoaded => _productsModel == null;
  List<ProductModel> get products => _productsModel?.products ?? [];
  bool get isLastMyProductsPage =>
      state is GetAllVendorProductsLoadingState ||
      (_productsModel?.isLastPage ?? true);

  //For search in my orders
  String _searchQuery = '';
  Future<void> onQueryChange(String val) async {
    _searchQuery = val;
    await getAllVendorProducts();
  }

  Future<void> getAllVendorProducts() async {
    try {
      emit(GetAllVendorProductsLoadingState());
      final map = await _services.productServices.getAllProducts(
          filterProducts:
              FilterVendorProductsRequestModel(searchQuery: _searchQuery));
      _productsModel = AllCategoryProductsModel.fromMap(map);
      emit(GetAllVendorProductsSuccessState());
    } catch (e) {
      emit(GetAllVendorProductsErrorState(error: e.toString()));
    }
  }

  Future<void> getMoreMyProducts() async {
    if (products.isEmpty) return;
    try {
      emit(GetMoreMyProductsLoadingState());
      final map = await _services.productServices.getAllProducts(
          filterProducts:
              FilterVendorProductsRequestModel(searchQuery: _searchQuery),
          pagination:
              PaginationRequestModel(paginationToken: products.last.id));
      final incomingProducts = AllCategoryProductsModel.fromMap(map);
      _productsModel!.appendProducts(incomingModel: incomingProducts);

      emit(GetMoreMyProductsSuccessState());
    } catch (e) {
      emit(GetMoreMyProductsErrorState(error: e.toString()));
    }
  }
}
