const String baseUrl = 'https://emdad-ecommerce.herokuapp.com/api/mobile/';

class EndPoints {
  static const String login = 'auth/login';

  static const String loginGuest = 'auth/registerGuest';

  static const String register = 'auth/register';

  static const String verifyOtp = 'auth/otp';

  static const String resendOtp = 'auth/otp/resend';

  static const String completeProfile = 'profile/complete';

  static const String userSettings = 'settings';

  static const String changePassword = 'profile/password';

  static const String changeEmail = 'profile/email';

  static const String getProfile = 'profile';

  static const String updateProfile = 'profile/edit';
}
