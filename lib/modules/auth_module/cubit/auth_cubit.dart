import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:emdad/layout/transporter_layout/transporter_layout.dart';
import 'package:emdad/layout/guest_layout/guest_user_layout.dart';
import 'package:emdad/layout/user_layout/user_layout.dart';
import 'package:emdad/layout/vendor_layout/vendor_layout_screen.dart';
import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/general_models/settings_model.dart';
import 'package:emdad/models/general_models/upload_image_model.dart';
import 'package:emdad/models/request_models/change_email_request_model.dart';
import 'package:emdad/models/request_models/change_password_request_model.dart';
import 'package:emdad/models/request_models/update_profile_request_model.dart';
import 'package:emdad/models/request_models/upload_images_request_model.dart';
import 'package:emdad/models/users/auth/user_register_data_model.dart';
import 'package:emdad/models/users/user/user_response_model.dart';
import 'package:emdad/models/users/user/user_response_model.dart' as userModel;
import 'package:emdad/modules/auth_module/screens/facility_type_view/facility_type_screen.dart';
import 'package:emdad/modules/auth_module/screens/login_view/login_screen.dart';
import 'package:emdad/modules/auth_module/screens/phone_confirm_view/phone_confirm_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/network/local/cache_helper.dart';
import 'package:emdad/shared/network/services/auth_services.dart';
import 'package:emdad/shared/network/services/general/general_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:open_location_picker/open_location_picker.dart';
import 'package:progress_state_button/progress_button.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool isSecure = true;
  IconData suffix = Icons.visibility;

  // Change password visibility methode
  void changePasswordVisibility() {
    isSecure = !isSecure;
    suffix = isSecure ? Icons.visibility : Icons.visibility_off;

    emit(ChangePasswordState());
  }

  ButtonState loginButtonState = ButtonState.idle;

  void loginUser({
    required String email,
    required String password,
    required String firebaseToken,
    required BuildContext context,
    String? type,
  }) async {
    try {
      loginButtonState = ButtonState.loading;
      emit(LoginLoadingState());
      Response response = await AuthServices.login(
        {
          "user": email,
          "password": password,
          "firebaseToken": firebaseToken,
        },
      );
      print(response.data);
      // validateLogin(response, context, type);
      // emit(LoginSuccessState());
      // return;
      if (response.data['status']) {
        validateLogin(response, context);
        loginButtonState = ButtonState.success;
        emit(LoginSuccessState());
      } else {
        showSnackBar(
          context: context,
          text: response.data['message'],
          snackBarStates: SnackBarStates.error,
        );
        loginButtonState = ButtonState.fail;
        emit(LoginErrorState());
      }
    } catch (e) {
      loginButtonState = ButtonState.fail;
      emit(LoginErrorState());
      rethrow;
    }
  }

  Future<void> loginGuestUser(BuildContext context) async {
    try {
      emit(LoginGuestUserLoadingState());
      final map = await AuthServices.loginGuest();
      final guestModel = UserResponseModel.guestFromJson(map);
      print(map);
      // validateLogin(response, context, type);
      // emit(LoginSuccessState());
      // return;
      if (map['status']) {
        // validateLogin(response, context);
        navigateToLayout(context, guestModel);
        emit(LoginGuestUserSuccessState());
      } else {
        emit(LoginGuestUserErrorState(error: 'Error'));
      }

      emit(LoginGuestUserSuccessState());
    } catch (e) {
      showSnackBar(
        context: context,
        text: e.toString(),
        snackBarStates: SnackBarStates.error,
      );
      emit(LoginGuestUserErrorState(error: e.toString()));
    }
  }

  ///
  UserResponseModel? userResponseModel;

  void validateLogin(Response response, BuildContext context, [String? type]) {
    // final UserResponseModel responseUser = UserResponseModel(
    //     status: true,
    //     message: '',
    //     data: userModel.Data(
    //         accessToken: 'test', user: userModel.User(userType: type)));
    // navigateToLayout(context, responseUser);
    // return;
    if (response.data['data']['step'] == 'verification') {
      showSnackBar(
        context: context,
        text: response.data['message'],
        snackBarStates: SnackBarStates.warning,
      );
      navigateToAndFinish(
        context,
        ConfirmationScreen(
          verifyOtpStep: VerifyOtpStep.phone,
          phoneNumber: '',
          emailAddress: '',
          token: response.data['data']['accessToken'],
        ),
      );
    } else if (response.data['data']['step'] == 'profile') {
      showSnackBar(
        context: context,
        text: response.data['message'],
        snackBarStates: SnackBarStates.warning,
      );
      navigateToAndFinish(
        context,
        FacilityTypeScreen(
          token: response.data['data']['accessToken'],
        ),
      );
    } else {
      userResponseModel = UserResponseModel.fromJson(response.data);
      navigateToLayout(context, userResponseModel!);
    }
  }

  void navigateToLayout(BuildContext context, UserResponseModel? model,
      [String? type]) {
    final userType = model?.data?.user?.userType ?? type;
    switch (userType) {
      case 'vendor':
        Constants.vendorToken = model!.data!.accessToken;
        CacheHelper.saveData(key: 'vendorToken', value: Constants.vendorToken);
        navigateTo(context, const VendorLayout());
        break;
      case 'user':
        Constants.userToken = model!.data!.accessToken;
        CacheHelper.saveData(key: 'userToken', value: Constants.userToken);
        navigateTo(context, const UserLayout());
        break;
      case 'transporter':
        Constants.transporterToken = model!.data!.accessToken;
        CacheHelper.saveData(
            key: 'transporterToken', value: Constants.transporterToken);
        navigateTo(context, const TransporterLayout());
        break;
      case 'guest':
        Constants.userToken = model!.data!.accessToken;
        CacheHelper.saveData(key: 'guestToken', value: Constants.userToken);
        AppCubit.get(context).setUser = model;
        navigateTo(context, const GuestUserLayout());
        break;
    }
    CacheHelper.saveData(key: 'userType', value: userType);
  }

  ButtonState registerButtonStates = ButtonState.idle;
  String? primaryPhoneNumberCode;
  String? secondaryPhoneNumberCode;
  bool isPrivacyAccepted = false;
  UserResponseModel? registerModel;

  void registerUser(UserRegisterDataModel model, BuildContext context) async {
    try {
      registerButtonStates = ButtonState.loading;
      emit(UserRegisterLoadingState());
      Response response = await AuthServices.registerUser(model.toJson());
      print(response.data);
      if (response.data['status']) {
        registerModel = UserResponseModel.fromJson(response.data);
        registerButtonStates = ButtonState.success;
        emit(UserRegisterSuccessState());
        Future.delayed(
            const Duration(milliseconds: 500),
            () => navigateToAndFinish(
                context,
                ConfirmationScreen(
                  verifyOtpStep: VerifyOtpStep.phone,
                  phoneNumber: model.primaryPhoneNumber.number,
                  emailAddress: model.primaryEmail,
                  token: registerModel!.data!.accessToken!,
                )));
      } else {
        registerButtonStates = ButtonState.fail;
        showSnackBar(
          context: context,
          text: response.data['message'],
          snackBarStates: SnackBarStates.error,
        );
        emit(UserRegisterErrorState());
      }
    } catch (e) {
      registerButtonStates = ButtonState.fail;
      showSnackBar(
        context: context,
        text: e.toString(),
        snackBarStates: SnackBarStates.error,
      );
      emit(UserRegisterErrorState());
      rethrow;
    }
  }

  void changePrivacyPolicyState(bool value) {
    isPrivacyAccepted = value;
    emit(AuthChangeState());
  }

  ButtonState verifyOtpButtonState = ButtonState.idle;

  void verifyOtp(
    String code, {
    required VerifyOtpStep step,
    required BuildContext context,
    required String token,
  }) async {
    try {
      verifyOtpButtonState = ButtonState.loading;
      emit(UserVerifyOtpLoadingState());
      Response response = await AuthServices.verifyOtp(
          generateVerifyOtpData(code, step), token);
      if (response.data['status']) {
        verifyOtpButtonState = ButtonState.success;
        showSnackBar(
          context: context,
          text: response.data['message'],
          snackBarStates: SnackBarStates.success,
        );
        verifyOtpButtonState = ButtonState.idle;
        emit(UserVerifyOtpIdleState());
        await Future.delayed(Duration(seconds: 1)).then((_) {});
        emit(UserVerifyOtpSuccessState());
      } else {
        verifyOtpButtonState = ButtonState.fail;
        throw response.data['message'];
      }
    } catch (e) {
      verifyOtpButtonState = ButtonState.fail;
      showSnackBar(
        context: context,
        text: e.toString(),
        snackBarStates: SnackBarStates.error,
      );
      emit(UserVerifyOtpErrorState());
      rethrow;
    }
  }

  Map<String, dynamic> generateVerifyOtpData(String code, VerifyOtpStep step,
      {bool isResend = false}) {
    Map<String, dynamic> map;
    switch (step) {
      case VerifyOtpStep.phone:
        map = {
          if (isResend == false) 'otp': code,
          'type': 'phone',
        };
        break;
      case VerifyOtpStep.email:
        map = {
          if (isResend == false) 'otp': code,
          'type': 'email',
        };
        break;
    }
    return map;
  }

  void resendOtp(String token, VerifyOtpStep step, BuildContext context) async {
    try {
      emit(UserResendOtpLoadingState());
      Response response =
          await AuthServices.resendOtp(generateVerifyOtpData('', step), token);
      if (response.data['status']) {
        showSnackBar(
          context: context,
          text: response.data['message'],
          snackBarStates: SnackBarStates.success,
        );
        emit(UserResendOtpSuccessState());
      } else {
        throw response.data['message'];
      }
    } catch (e) {
      showSnackBar(
        context: context,
        text: e.toString(),
        snackBarStates: SnackBarStates.error,
      );
      emit(UserResendOtpErrorState());
      rethrow;
    }
  }

  FacilityType? facilityType;

  void changeFacilityType(FacilityType? type) {
    facilityType = type;
    emit(AuthChangeState());
  }

  final List<String> vendorType = [];
  final List<String> transporterType = [];

  void changeVendorTypes(String value, bool isSelected) {
    if (isSelected) {
      vendorType.add(value);
    } else {
      vendorType.removeWhere((element) => element == value);
    }
    emit(AuthChangeState());
  }

  void changeTransporterTypes(String value, bool isSelected) {
    if (isSelected) {
      transporterType.add(value);
    } else {
      transporterType.removeWhere((element) => element == value);
    }
    emit(AuthChangeState());
  }

  SelectedLocation? selectedLocation;
  FormattedLocation? selectedLocationTest;

  void addLocation(SelectedLocation location) {
    selectedLocation = location;
    emit(AuthChangeState());
  }

  ///
  ButtonState completeProfileStates = ButtonState.idle;
  UserResponseModel? completeProfileModel;

  void completeProfile(
    dynamic model, {
    required FacilityType facilityType,
    required String token,
    required BuildContext context,
  }) async {
    try {
      completeProfileStates = ButtonState.loading;
      emit(UserCompleteProfileLoadingState());
      Response response =
          await AuthServices.completeProfile(model.toJson(), token);
      print(response.data);
      if (response.data['status']) {
        completeProfileModel = UserResponseModel.fromJson(response.data);
        // navigateToLayout(context, userResponseModel);
        completeProfileStates = ButtonState.success;
        emit(UserVerifyOtpIdleState());
        await Future.delayed(Duration(seconds: 1));
        showSnackBar(
          context: context,
          text: response.data['message'],
          snackBarStates: SnackBarStates.success,
        );
        emit(UserCompleteProfileSuccessState());
        navigateToAndFinish(context, LoginScreen());
      } else {
        showSnackBar(
          context: context,
          text: response.data['message'],
          snackBarStates: SnackBarStates.error,
        );
        completeProfileStates = ButtonState.fail;
        emit(UserCompleteProfileErrorState());
      }
    } catch (e) {
      completeProfileStates = ButtonState.fail;
      emit(UserCompleteProfileErrorState());
      rethrow;
    }
  }

  SettingModel? userSettingsModel;
  List<String> countries = [];
  List<String> cities = [];

  void getUserSettings() async {
    try {
      countries.clear();
      cities.clear();
      selectedCountry = null;
      selectedCity = null;
      emit(UserGetSettingsLoadingState());
      Response response = await AuthServices.getUserSettings();
      if (response.data['status']) {
        userSettingsModel = SettingModel.fromMap(response.data);
        for (var element in userSettingsModel!.data!.countries!) {
          countries.add(element.countryCode!);
        }
        emit(UserGetSettingsSuccessState());
      } else {
        emit(UserGetSettingsErrorState());
      }
    } catch (e) {
      emit(UserGetSettingsErrorState());
      rethrow;
    }
  }

  String? selectedCountry;
  String? selectedCity;

  void onCountryChange(value) {
    cities.clear();
    selectedCity = null;
    selectedCountry = value.toString();
    int index = userSettingsModel!.data!.countries!
        .indexWhere((element) => element.countryCode == value);
    cities.addAll(userSettingsModel!.data!.countries![index].cities!);
    emit(AuthChangeState());
  }

  void onCityChange(value) {
    selectedCity = value.toString();
    emit(AuthChangeState());
  }

  // String getToken() {
  //   final userType = CacheHelper.getData(key: 'userType');
  //   if (userType == null) throw 'User type is null';
  //   String token = '';
  //   switch (userType) {
  //     case 'user':
  //       token = Constants.userToken!;
  //       break;
  //     case 'vendor':
  //       token = Constants.vendorToken!;
  //       break;
  //     case 'transporterToken':
  //       token = Constants.transporterToken!;
  //       break;
  //     default:
  //       throw 'Unknown token';
  //   }
  //   return token;
  // }

  Future<void> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String newPasswordConfirm}) async {
    try {
      emit(ChangePasswordLoadingState());

      final map = await AuthServices.changePassword(
        changePasswordRequestModel: ChangePasswordRequestModel(
            newPassword: newPassword,
            oldPassword: oldPassword,
            newPasswordConfirm: newPasswordConfirm),
        token: SharedMethods.getUserToken()!,
      );
      log(map.toString());
      emit(ChangePasswordSuccessState());
    } catch (e) {
      emit(ChangePasswordErrorState(error: e.toString()));
    }
  }

  Future<void> changeEmail({
    required String password,
    required String oldEmail,
    required String newEmail,
  }) async {
    try {
      emit(ChangeEmailLoadingState());

      final map = await AuthServices.changeEmail(
        changeEmailRequestModel: ChangeEmailRequestModel(
            password: password, oldEmail: oldEmail, newEmail: newEmail),
      );
      log(map.toString());
      emit(ChangeEmailSuccessState());
    } catch (e) {
      emit(ChangeEmailErrorState(error: e.toString()));
    }
  }

  Future<void> changePhoneNumber({required String phoneNumber}) async {
    try {
      emit(UpdateProfileLoadingState());

      //TODO: integrate with api change phone number

      emit(UpdateProfileSuccessState());
    } catch (e) {
      emit(UpdateProfileErrorState(error: e.toString()));
    }
  }

  //For picked personal file image
  File? selectedImageFile;
  Future<void> changePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImageFile = File(pickedFile.path);
      emit(PickPersonalImageSuccessState());
    } else {
      print('No image selected. ');
      emit(PickPersonalImageErrorState(error: 'No image selected'));
    }
  }

  bool get hasPickedPersonalImage => selectedImageFile != null;
  Future<void> updateProfile(
      {required BuildContext context,
      required String organization,
      required String commericalRegister,
      required String country,
      required String city}) async {
    try {
      Map<String, dynamic> map = {};
      emit(UpdateProfileLoadingState());
      if (hasPickedPersonalImage) {
        final uploadedFiles = await _uploadSelectedImagesToServer();
        if (uploadedFiles.status == false) {
          throw 'Error happened when upload image';
        }
        map = await AuthServices.updateProfile(UpdateProfileRequestModel(
            logo: uploadedFiles.logo,
            oraganizationName: organization,
            commercialRegister: commericalRegister,
            city: city,
            country: country));
      } else {
        map = await AuthServices.updateProfile(UpdateProfileRequestModel(
            oraganizationName: organization,
            commercialRegister: commericalRegister,
            city: city,
            country: country));
      }
      final user = UserResponseModel.fromJson(map);
      AppCubit.get(context).setUser = user;
      emit(UpdateProfileSuccessState());
    } catch (e) {
      emit(UpdateProfileErrorState(error: e.toString()));
    }
  }

  Future<UploadPersonalImageModel> _uploadSelectedImagesToServer() async {
    log('First');
    if (selectedImageFile == null) {
      log('second');
      //That means user not upload main image or any other images
      return UploadPersonalImageModel.empty();
    }
    log('third');
    final map = await GeneralServices.instance
        .uploadImages(UploadUserImageRequestModel(selectedImageFile!));
    log('forth');
    final allImages = UploadPersonalImageModel.fromMap(map);
    return allImages;
  }
}
