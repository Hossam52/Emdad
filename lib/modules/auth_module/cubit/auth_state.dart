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
class UserRegisterLoadingState extends AuthState {}

class UserRegisterSuccessState extends AuthState {}

class UserRegisterErrorState extends AuthState {}

///
class UserVerifyOtpLoadingState extends AuthState {}

class UserVerifyOtpSuccessState extends AuthState {}

class UserVerifyOtpErrorState extends AuthState {}

///
class UserResendOtpLoadingState extends AuthState {}

class UserResendOtpSuccessState extends AuthState {}

class UserResendOtpErrorState extends AuthState {}

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