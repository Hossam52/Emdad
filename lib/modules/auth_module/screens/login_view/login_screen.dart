import 'package:emdad/modules/auth_module/auth_widgets/skip_auth.dart';
import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/forgot_password_view/forgot_password_screen.dart';
import 'package:emdad/modules/auth_module/screens/register_view/register_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/responsive/device_information.dart';
import 'package:emdad/shared/responsive/responsive_widget.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:emdad/shared/widgets/default_gesture_widget.dart';
import 'package:emdad/shared/widgets/default_progress_button.dart';
import 'package:emdad/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return responsiveWidget(
            responsive: (context, DeviceInformation deviceInformation) {
              return Scaffold(
                appBar: AppBar(
                  actions: const [
                    SkipAuthButton(),
                  ],
                ),
                body: DefaultGestureWidget(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'تسجيل الدخول لحسابك',
                                  style: headersTextStyle().copyWith(),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Image.asset(
                                  'assets/images/accent.png',
                                  width: 99,
                                  height: 4,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 48,
                            ),
                            const _TestAccounts(),
                            Column(
                              children: [
                                CustomTextFormField(
                                  controller: phoneController,
                                  type: TextInputType.text,
                                  hint: 'رقم الهاتف',
                                  validation: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'من فضلك ادخل رقم الهاتف';
                                    } else {
                                      return null;
                                    }
                                  },
                                  hasBorder: false,
                                  backgroundColor: AppColors.textWhiteGrey,
                                  borderRadius: 10,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 20),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                CustomTextFormField(
                                  type: TextInputType.visiblePassword,
                                  hint: 'الرقم السري',
                                  hasBorder: false,
                                  backgroundColor: AppColors.textWhiteGrey,
                                  borderRadius: 10,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 20),
                                  controller: passwordController,
                                  suffixIcon: cubit.suffix,
                                  isSecure: cubit.isSecure,
                                  suffixPressed: () {
                                    cubit.changePasswordVisibility();
                                  },
                                  validation: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'من فضلك ادخل الرقم السري';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            ),
                            TextButton(
                              child: const Text(
                                'هل نسيت كلمة المرور ؟',
                              ),
                              onPressed: () {
                                navigateTo(
                                    context, const ForgotPasswordScreen());
                              },
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: DefaultProgressButton(
                                buttonState: cubit.loginButtonState,
                                idleText: 'تسجيل دخول',
                                failText: 'حدث خطأ',
                                successText: 'تم التسجيل',
                                borderRadius: 10,
                                onPressed: () {
                                  formKey.currentState!.save();
                                  if (formKey.currentState!.validate()) {
                                    SharedMethods.unFocusTextField(context);
                                    cubit.loginUser(
                                      email: phoneController.text,
                                      password: passwordController.text,
                                      firebaseToken: '',
                                      context: context,
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: Text(
                                "ليس لديك حساب ؟ ",
                                style: secondaryTextStyle()
                                    .copyWith(color: textGrey),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            CustomPrimaryButton(
                              buttonColor: AppColors.myGreyColor,
                              textValue: 'إنشاء حساب',
                              textColor: textBlack,
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _TestAccounts extends StatelessWidget {
  const _TestAccounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              login(context, 'testuser@gmail.com', type: 'user');
            },
            child: const Text(
              'User',
            )),
        TextButton(
            onPressed: () {
              login(context, 'testvendor@gmail.com', type: 'vendor');
            },
            child: const Text('Vendor')),
        TextButton(
            onPressed: () {
              login(context, 'testtransporter@gmail.com', type: 'transporter');
            },
            child: const Text('Transporter')),
      ],
    );
  }

  void login(BuildContext context, String email,
      {String password = '123456', String? type}) {
    AuthCubit.get(context).loginUser(
        email: email,
        password: password,
        firebaseToken: '',
        context: context,
        type: type);
  }
}
