part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthChangeState extends AuthState {}

class ChangePasswordState extends AuthState {}

///
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {}

///
//LoginGuestUser online fetch data
class LoginGuestUserLoadingState extends AuthState {}

class LoginGuestUserSuccessState extends AuthState {}

class LoginGuestUserErrorState extends AuthState {
  final String error;
  LoginGuestUserErrorState({required this.error});
}

///
class UserRegisterLoadingState extends AuthState {}

class UserRegisterSuccessState extends AuthState {}

class UserRegisterErrorState extends AuthState {}

///
class UserVerifyOtpLoadingState extends AuthState {}

class UserVerifyOtpSuccessState extends AuthState {}

class UserVerifyOtpIdleState extends AuthState {}

class UserVerifyOtpErrorState extends AuthState {}

///
class UserResendOtpLoadingState extends AuthState {}

class UserResendOtpSuccessState extends AuthState {}

class UserResendOtpErrorState extends AuthState {}

class UpdateCounterOtpValue extends AuthState {}

///
class UserCompleteProfileLoadingState extends AuthState {}

class UserCompleteProfileSuccessState extends AuthState {}

class UserCompleteProfileErrorState extends AuthState {}

///
class UserGetSettingsLoadingState extends AuthState {}

class UserGetSettingsSuccessState extends AuthState {}

class UserGetSettingsErrorState extends AuthState {}

class CountryChangeState extends AuthState {}

class CityChangeState extends AuthState {}

//ChangePassword online fetch data
class ChangePasswordLoadingState extends AuthState {}

class ChangePasswordSuccessState extends AuthState {}

class ChangePasswordErrorState extends AuthState {
  final String error;
  ChangePasswordErrorState({required this.error});
}

//ChangeEmail online fetch data
class ChangeEmailLoadingState extends AuthState {}

class ChangeEmailSuccessState extends AuthState {}

class ChangeEmailErrorState extends AuthState {
  final String error;
  ChangeEmailErrorState({required this.error});
}

//UpdateProfile online fetch data
class UpdateProfileLoadingState extends AuthState {}

class UpdateProfileSuccessState extends AuthState {}

class UpdateProfileErrorState extends AuthState {
  final String error;
  UpdateProfileErrorState({required this.error});
}

class PickPersonalImageSuccessState extends AuthState {}

class PickPersonalImageErrorState extends AuthState {
  final String error;
  PickPersonalImageErrorState({
    required this.error,
  });
}
