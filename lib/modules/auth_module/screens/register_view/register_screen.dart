import 'dart:developer';

import 'package:emdad/shared/translation_service.dart';
import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:emdad/models/users/auth/user_register_data_model.dart';
import 'package:emdad/modules/auth_module/auth_widgets/skip_auth.dart';
import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/register_view/country_code_picker.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:emdad/shared/widgets/default_gesture_widget.dart';
import 'package:emdad/shared/widgets/default_progress_button.dart';
import 'package:emdad/shared/widgets/ui_componants/custom_checkbox_form_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController alternativePhoneController =
      TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController alternativeEmailController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final PhoneNumberInputController primaryPhoneController;
  late final PhoneNumberInputController secondaryPhoneController;
  @override
  void initState() {
    super.initState();
    primaryPhoneController = PhoneNumberInputController(context);
    secondaryPhoneController = PhoneNumberInputController(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            actions: const [
              SkipAuthButton(),
            ],
          ),
          body: DefaultGestureWidget(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text: context.tr.register_account,
                          textStyle: headersTextStyle(),
                        ),
                        SizedBox(height: 40.h),
                        CountryCodePickerBuildItem(
                          controller: primaryPhoneController,
                          hintText: context.tr.main_phone,
                        ),
                        SizedBox(height: 15.h),
                        CustomTextFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          titleText: context.tr.password,
                          hint: context.tr.password,
                          hasBorder: false,
                          backgroundColor: AppColors.textWhiteGrey,
                          isSecure: true,
                          isRequired: true,
                          validation: (value) =>
                              SharedMethods.passwordValidation(value),
                        ),
                        SizedBox(height: 15.h),
                        CustomTextFormField(
                          controller: confirmPasswordController,
                          type: TextInputType.visiblePassword,
                          titleText: context.tr.confirm_password,
                          hint: context.tr.confirm_password,
                          hasBorder: false,
                          backgroundColor: AppColors.textWhiteGrey,
                          isSecure: true,
                          isRequired: true,
                          validation: (value) =>
                              SharedMethods.confirmPasswordValidation(
                            value,
                            confirmPassword: confirmPasswordController,
                            password: passwordController,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        SizedBox(
                            width: 170.w,
                            child: const Divider(
                                color: Colors.black, thickness: 1)),
                        CustomTextFormField(
                          controller: usernameController,
                          type: TextInputType.text,
                          titleText: context.tr.name,
                          hint: context.tr.name,
                          hasBorder: false,
                          backgroundColor: AppColors.textWhiteGrey,
                          isRequired: true,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return context.tr.please_enter_name;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15.h),
                        CustomTextFormField(
                          controller: emailController,
                          type: TextInputType.text,
                          titleText: context.tr.email,
                          hint: 'example@domain.com',
                          hasBorder: false,
                          backgroundColor: AppColors.textWhiteGrey,
                          isRequired: true,
                          validation: (value) =>
                              SharedMethods.emailValidation(value),
                        ),
                        SizedBox(height: 15.h),
                        CustomTextFormField(
                          controller: alternativeEmailController,
                          type: TextInputType.text,
                          titleText: context.tr.secondary_mail,
                          hint: 'example@domain.com',
                          hasBorder: false,
                          backgroundColor: AppColors.textWhiteGrey,
                          isOptional: true,
                          validation: (value) {
                            SharedMethods.emailValidation(value);
                          },
                        ),
                        SizedBox(height: 15.h),
                        CountryCodePickerBuildItem(
                          controller: secondaryPhoneController,
                          hintText: context.tr.secondary_phone,
                        ),
                        SizedBox(height: 10.h),
                        CheckboxFormField(
                          title: context.tr.conditions_and_terms,
                          validator: (value) =>
                              SharedMethods.defaultCheckboxValidation(value),
                          onSaved: (value) {
                            cubit.changePrivacyPolicyState(value!);
                          },
                        ),
                        SizedBox(height: 20.h),
                        DefaultProgressButton(
                          buttonState: cubit.registerButtonStates,
                          idleText: context.tr.register_account,
                          failText: context.tr.error_happened,
                          successText: context.tr.done_register,
                          onPressed: () async {
                            formKey.currentState!.save();
                            if (formKey.currentState!.validate()) {
                              cubit.registerUser(
                                UserRegisterDataModel(
                                  name: usernameController.text,
                                  password: passwordController.text,
                                  primaryPhoneNumber: PhoneNumberDataModel(
                                    number: primaryPhoneController.phoneNumber,
                                    countryCode: primaryPhoneController
                                        .selectedCountry.dialCode,
                                  ),
                                  secondaryPhoneNumber:
                                      alternativePhoneController.text.isNotEmpty
                                          ? PhoneNumberDataModel(
                                              number: secondaryPhoneController
                                                  .phoneNumber,
                                              countryCode:
                                                  secondaryPhoneController
                                                      .selectedCountry.dialCode,
                                            )
                                          : null,
                                  primaryEmail: emailController.text,
                                  secondaryEmail:
                                      alternativeEmailController.text.isNotEmpty
                                          ? alternativeEmailController.text
                                          : null,
                                  firebaseToken: '',
                                ),
                                context,
                              );
                            }
                          },
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _validatePhoneWithCountryCode() async {}
}

class _TestPhoneNumber extends StatefulWidget {
  const _TestPhoneNumber({Key? key}) : super(key: key);

  @override
  State<_TestPhoneNumber> createState() => _TestPhoneNumberState();
}

class _TestPhoneNumberState extends State<_TestPhoneNumber> {
  late final PhoneNumberInputController controller;
  @override
  void initState() {
    super.initState();
    controller = PhoneNumberInputController(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PhoneNumberInput(
          initialCountry: 'SA',
          locale: 'ar',
          controller: controller,
        ),
        TextButton(
            onPressed: () {
              log(controller.fullPhoneNumber.toString());
            },
            child: Text('test '))
      ],
    );
  }
}
