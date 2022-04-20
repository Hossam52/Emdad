import 'package:emdad/models/products_and_categories/category_model.dart';
import 'package:emdad/models/rating/rate_model.dart';
import 'package:emdad/models/users/user/user_response_model.dart';
import 'package:emdad/models/users/user/vendor_info.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_states.dart';
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
  VendorProfileCubit() : super(IntitalVendorProfileState());
  static VendorProfileCubit instance(BuildContext context) =>
      BlocProvider.of<VendorProfileCubit>(context);
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
  //All rating count
  double get ratingCount => _vendor!.overAllRating;
  Future<void> getVendorInfo({required String vendorId}) async {
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
}
