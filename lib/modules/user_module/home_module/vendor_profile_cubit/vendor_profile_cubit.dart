import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/general_models/toggle_vendor_favorite.dart';
import 'package:emdad/models/products_and_categories/category_model.dart';
import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/models/rating/rate_model.dart';
import 'package:emdad/models/request_models/user/category_request_model.dart';
import 'package:emdad/models/users/user/all_category_products_model.dart';
import 'package:emdad/models/users/user/user_response_model.dart';
import 'package:emdad/models/users/user/vendor_info.dart';
import 'package:emdad/modules/user_module/home_module/user_home_cubit/user_home_cubit.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_states.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

//Bloc builder and bloc consumer methods
typedef VendorProfileBlocBuilder
    = BlocBuilder<VendorProfileCubit, VendorProfileStates>;
typedef VendorProfileBlocConsumer
    = BlocConsumer<VendorProfileCubit, VendorProfileStates>;

//
class VendorProfileCubit extends Cubit<VendorProfileStates> {
  VendorProfileCubit({required this.vendorId})
      : super(IntitalVendorProfileState());
  static VendorProfileCubit instance(BuildContext context) =>
      BlocProvider.of<VendorProfileCubit>(context);
  final String vendorId;
  final UserServices _services = UserServices.instance;
  //
  VendorInfoModel? _vendor;
  bool get isProfileLoaded => _vendor != null;
  //Main vendor data
  User get getVendorData => _vendor!.vendorInfo;

  //All rates for this vendor
  List<RateModel> get getRatings => _vendor!.ratings;
  //All categories
  List<CategoryModel> get getCategories => _vendor!.categories;
  int _getSpecificCategoryIndex(String category) {
    return getCategories.indexWhere((element) => element.category == category);
  }

  //All rating count
  double get ratingCount => _vendor!.overAllRating;
  Future<void> getVendorInfo() async {
    try {
      emit(GetVendorInfoLoadingState());
      final map =
          await _services.userVendorServices.getVendorInfo(vendorId: vendorId);
      _vendor = VendorInfoModel.fromMap(map);
      emit(GetVendorInfoSuccessState());
    } catch (e) {
      emit(GetVendorInfoErrorState(error: e.toString()));
    }
  }

//To get products in specific category
  AllCategoryProductsModel? _allCategoryProducts;
  List<ProductModel> get allProducts => _allCategoryProducts?.products ?? [];

  //To know if this category reaches to end or not
  bool get isLastProductPage {
    return _allCategoryProducts?.isLastPage ?? false;
  }

  Future<void> getCategoryProducts({required String? category}) async {
    if (isLastProductPage) return; //No load if reach to last page
    try {
      emit(GetCategoryProductsLoadingState());
      final map = await _services.userVendorServices.getProductsInCategory(
        vendorID: vendorId,
        categoryRequestModel: CategoryRequestModel(
          productType: category == null ? null : [category],
        ),
      );
      _allCategoryProducts = AllCategoryProductsModel.fromMap(map);
      emit(GetCategoryProductsSuccessState());
    } catch (e) {
      emit(GetCategoryProductsErrorState(error: e.toString()));
    }
  }

  Future<void> getMoreCategoryProducts({required String? category}) async {
    try {
      emit(GetMoreCategoryProductsLoadingState());
      final map = await _services.userVendorServices.getProductsInCategory(
        vendorID: vendorId,
        categoryRequestModel: CategoryRequestModel(
          productType: category == null ? null : [category],
          paginationToken: allProducts.isEmpty ? null : allProducts.last.id,
        ),
      );
      final incomingProducts = AllCategoryProductsModel.fromMap(map);
      _appendProducts(incomingProducts);
      emit(GetMoreCategoryProductsSuccessState());
    } catch (e) {
      emit(GetMoreCategoryProductsErrorState(error: e.toString()));
    }
  }

  //For pagination use to add products to current list
  void _appendProducts(AllCategoryProductsModel allProducts) {
    if (_allCategoryProducts == null) {
      _allCategoryProducts = allProducts;
      return;
    }

    _allCategoryProducts!.changeLastProducts = allProducts.isLastPage;
    _allCategoryProducts!.appendProducts(otherProducts: allProducts.products);
  }

//For toggeling favorite for this vendor

  Future<void> toggleFavorite(BuildContext context) async {
    try {
      emit(ToggleFavoriteLoadingState());
      final map =
          await _services.userVendorServices.toggleVendorFavorite(vendorId);
      final model = ToggleFavoriteModel.fromMap(map);
      if (model.status) {
        showSnackBar(
            context: context,
            text: model.message,
            snackBarStates: SnackBarStates.success);
        UserHomeCubit.instance(context).toggleFavoriteVendor(getVendorData);
      }
      emit(ToggleFavoriteSuccessState());
    } catch (e) {
      showSnackBar(
          context: context,
          text: e.toString(),
          snackBarStates: SnackBarStates.error);
      emit(ToggleFavoriteErrorState(error: e.toString()));
    }
  }
}
