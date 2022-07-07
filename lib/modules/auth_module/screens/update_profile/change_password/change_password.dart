import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/register_view/register_screen.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/background_stack.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/custom_update_profile_app_bar.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/update_profile_text_field.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final sizedBox = SizedBox(
      height: SharedMethods.getHeightFraction(context, 0.03),
    );
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ChangePasswordErrorState) {
                SharedMethods.showToast(context, state.error,
                    textColor: Colors.white, color: AppColors.errorColor);
              }
              if (state is ChangePasswordSuccessState) {
                SharedMethods.showToast(
                    context, context.tr.done_change_password,
                    textColor: Colors.white, color: AppColors.successColor);
              }
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  SharedMethods.unFocusTextField(context);
                },
                child: BackgroundStack(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomUpdateProfileAppBar(
                          title: context.tr.change_password,
                        ),
                        sizedBox,
                        UpdateProfileTextField(
                          hint: context.tr.enter_old_password,
                          textEditingController: oldPasswordController,
                          label: context.tr.old_password,
                          validator: (val) {
                            return SharedMethods.passwordValidation(val);
                          },
                        ),
                        UpdateProfileTextField(
                          hint: context.tr.enter_the_new_password,
                          textEditingController: newPasswordController,
                          label: context.tr.new_password,
                          validator: (val) {
                            return SharedMethods.passwordValidation(val);
                          },
                        ),
                        UpdateProfileTextField(
                          hint: context.tr.enter_confirmation_password,
                          textEditingController: confirmPasswordController,
                          label: context.tr.confirm_password,
                          validator: (val) {
                            final passwordValidation =
                                SharedMethods.passwordValidation(val);
                            if (passwordValidation != null) {
                              return passwordValidation;
                            }
                            return SharedMethods.confirmPasswordValidation(val,
                                password: newPasswordController,
                                confirmPassword: confirmPasswordController);
                          },
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 5,
                          endIndent:
                              SharedMethods.getWidthFraction(context, 0.3),
                          indent: SharedMethods.getWidthFraction(context, 0.3),
                        ),
                        sizedBox,
                        if (state is ChangePasswordLoadingState)
                          const DefaultLoader()
                        else
                          CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                AuthCubit.get(context).changePassword(
                                    oldPassword: oldPasswordController.text,
                                    newPassword: newPasswordController.text,
                                    newPasswordConfirm:
                                        confirmPasswordController.text);
                              }
                            },
                            backgroundColor: AppColors.primaryColor,
                            text: context.tr.send_confirmation,
                            height:
                                SharedMethods.getHeightFraction(context, 0.1),
                            textStyle: primaryTextStyle()
                                .copyWith(color: Colors.white),
                          ),
                        sizedBox,
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                            ),
                            child: Text(context.tr.forgot_password + ' ? '),
                          ),
                        ),
                        SizedBox(
                            height:
                                SharedMethods.getHeightFraction(context, 0.05)),
                        Center(
                          child: RichText(
                              text: TextSpan(
                                  text: context.tr.dont_have_account + ' ? ',
                                  style: secondaryTextStyle()
                                      .copyWith(color: Colors.black),
                                  children: [
                                TextSpan(
                                    text: context.tr.register_now,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          navigateTo(context, RegisterScreen()),
                                    style: secondaryTextStyle().copyWith(
                                        color: AppColors.myOrangeColor))
                              ])),
                        )
                      ],
                    ),
                  ),
                )),
              );
            },
          ),
        ),
      ),
    );
  }
}
