import 'package:emdad/modules/auth_module/screens/login_view/login_screen.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components.dart';

class SharedMethods {
  static String? defaultValidation(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'هذا حقل مطلوب';
    } else {
      return null;
    }
  }

  static String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "برجاء إدخال عنوان البريد الإلكتروني الخاص بك";
    } else {
      return RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)
          ? null
          : 'برجاء تحقق من بريدك الالكتروني';
    }
  }

  static String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك ادخل كلمة المرور';
    } else {
      return value.length < 6
          ? 'كلمة المرور الخاصة بك ضعيفة ، أدخل أكثر من ستة أحرف'
          : null;
    }
  }

  static String? confirmPasswordValidation(
    String? value, {
    required TextEditingController confirmPassword,
    required TextEditingController password,
  }) {
    if (value == null || value.isEmpty) {
      return 'تأكيد كلمة المرور مطلوبة';
    } else {
      return confirmPassword.text != password.text
          ? 'تأكيد كلمة المرور لا يساوي كلمة المرور'
          : null;
    }
  }

  static TextInputFormatter numbersOnlyFormatter() =>
      FilteringTextInputFormatter.digitsOnly;

  static String? getUserToken() {
    String? token = Constants.userToken ??
        Constants.vendorToken ??
        Constants.transporterToken;
    return token;
  }

  static String? defaultCheckboxValidation(bool? value, {String? message}) {
    if (value == false) {
      return message ?? 'هذا حقل مطلوب';
    } else {
      return null;
    }
  }

  static void signOutVendor(BuildContext context) {
    try {
      CacheHelper.removeData(key: 'vendorToken');
      CacheHelper.removeData(key: 'userToken');
      CacheHelper.removeData(key: 'transporterToken');
      Constants.vendorToken = null;
      Constants.userToken = null;
      Constants.transporterToken = null;
      navigateToAndFinish(context, LoginScreen());
    } catch (e) {
      rethrow;
    }
  }

  static void unFocusTextField(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static void showToast(BuildContext context, String text,
      {Color color = Colors.green, Color textColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
    ));
  }

  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double getWidthFraction(BuildContext context, double ratio) =>
      getWidth(context) * ratio;
  static double getHeightFraction(BuildContext context, double ratio) =>
      getHeight(context) * ratio;
}
