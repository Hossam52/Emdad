import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/background_stack.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/custom_update_profile_app_bar.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/update_profile_text_field.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeEmailScreen extends StatelessWidget {
  ChangeEmailScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final oldEmailController = TextEditingController();
  final newEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ChangeEmailErrorState) {
                SharedMethods.showToast(context, state.error,
                    textColor: Colors.white, color: AppColors.errorColor);
              }
              if (state is ChangeEmailSuccessState) {
                SharedMethods.showToast(context, 'تم تعديل الايميل بنجاح',
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
                        const CustomUpdateProfileAppBar(
                          title: 'تغيير الايميل',
                        ),
                        SizedBox(
                          height:
                              SharedMethods.getHeightFraction(context, 0.08),
                        ),
                        UpdateProfileTextField(
                          hint: 'Enter your password',
                          textEditingController: passwordController,
                          validator: (val) {
                            return SharedMethods.passwordValidation(val);
                          },
                          label: 'Current password',
                        ),
                        UpdateProfileTextField(
                          hint: 'Enter old email',
                          textEditingController: oldEmailController,
                          validator: (val) {
                            return SharedMethods.emailValidation(val);
                          },
                          label: 'Old email',
                        ),
                        UpdateProfileTextField(
                          hint: 'Enter the new email',
                          textEditingController: newEmailController,
                          label: 'New email',
                          validator: (val) {
                            return SharedMethods.emailValidation(val);
                          },
                        ),
                        SizedBox(
                          height:
                              SharedMethods.getHeightFraction(context, 0.03),
                        ),
                        if (state is ChangeEmailLoadingState)
                          const DefaultLoader()
                        else
                          CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                AuthCubit.get(context).changeEmail(
                                    password: passwordController.text,
                                    oldEmail: oldEmailController.text,
                                    newEmail: newEmailController.text);
                              }
                            },
                            backgroundColor: AppColors.primaryColor,
                            text: 'Send confirmation',
                            height:
                                SharedMethods.getHeightFraction(context, 0.1),
                            textStyle: primaryTextStyle()
                                .copyWith(color: Colors.white),
                          ),
                        SizedBox(
                          height:
                              SharedMethods.getHeightFraction(context, 0.03),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                            ),
                            child: const Text('Forget password?'),
                          ),
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
