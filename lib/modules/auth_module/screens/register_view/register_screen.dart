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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

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
                          text: 'تسجيل حساب جديد',
                          textStyle: headersTextStyle(),
                        ),
                        SizedBox(height: 40.h),
                        CustomTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          hint: 'ex.0123456789',
                          titleText: 'رقم الهاتف',
                          hasBorder: false,
                          backgroundColor: AppColors.textWhiteGrey,
                          inputFormatters: [
                            SharedMethods.numbersOnlyFormatter()
                          ],
                          isRequired: true,
                          prefix: CountryCodePickerBuildItem(
                            onChange: (value) {
                              cubit.primaryPhoneNumberCode = value.dialCode;
                            },
                            onInit: (value) {
                              cubit.primaryPhoneNumberCode = value!.dialCode;
                            },
                          ),
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'من فضلك ادخل رقم الهاتف';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15.h),
                        CustomTextFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          titleText: 'الرقم السري',
                          hint: 'الرقم السري',
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
                          titleText: 'تأكيد الرقم السري',
                          hint: 'الرقم السري',
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
                          titleText: 'الاسم',
                          hint: 'عمرو',
                          hasBorder: false,
                          backgroundColor: AppColors.textWhiteGrey,
                          isRequired: true,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'من فضلك ادخل الاسم';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15.h),
                        CustomTextFormField(
                          controller: emailController,
                          type: TextInputType.text,
                          titleText: 'الايميل',
                          hint: 'Eng.amr@gmail.com',
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
                          titleText: 'ايميل احتياطي',
                          hint: 'Eng.amr2@gmail.com',
                          hasBorder: false,
                          backgroundColor: AppColors.textWhiteGrey,
                          isOptional: true,
                          validation: (value) {},
                        ),
                        SizedBox(height: 15.h),
                        CustomTextFormField(
                          controller: alternativePhoneController,
                          type: TextInputType.phone,
                          titleText: 'رقم هاتف إحتياطي',
                          hint: 'ex.٠١٢٣٨٧٥٥٦٧٨',
                          hasBorder: false,
                          backgroundColor: AppColors.textWhiteGrey,
                          inputFormatters: [
                            SharedMethods.numbersOnlyFormatter()
                          ],
                          prefix: CountryCodePickerBuildItem(
                            onInit: (value) => cubit.secondaryPhoneNumberCode =
                                value!.dialCode,
                            onChange: (value) =>
                                cubit.secondaryPhoneNumberCode = value.dialCode,
                          ),
                          isOptional: true,
                          validation: (value) {},
                        ),
                        SizedBox(height: 10.h),
                        CheckboxFormField(
                          title: 'الشروط والأحكام',
                          validator: (value) =>
                              SharedMethods.defaultCheckboxValidation(value),
                          onSaved: (value) {
                            cubit.changePrivacyPolicyState(value!);
                          },
                        ),
                        SizedBox(height: 20.h),
                        DefaultProgressButton(
                          buttonState: cubit.registerButtonStates,
                          idleText: 'انشاء حساب',
                          failText: 'حدث خطاء',
                          successText: 'تم التسجيل',
                          onPressed: () {
                            formKey.currentState!.save();
                            if (formKey.currentState!.validate()) {
                              cubit.registerUser(
                                UserRegisterDataModel(
                                  name: usernameController.text,
                                  password: passwordController.text,
                                  primaryPhoneNumber: PhoneNumberDataModel(
                                    number: phoneController.text,
                                    countryCode: cubit.primaryPhoneNumberCode!,
                                  ),
                                  secondaryPhoneNumber:
                                      alternativePhoneController.text.isNotEmpty
                                          ? PhoneNumberDataModel(
                                              number: alternativePhoneController
                                                  .text,
                                              countryCode: cubit
                                                  .secondaryPhoneNumberCode!,
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
}
