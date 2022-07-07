import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/modules/auth_module/screens/phone_confirm_view/phone_confirm_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:emdad/shared/widgets/default_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_state_button/progress_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: context.tr.forgot_password,
            textStyle: secondaryTextStyle(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: emailController,
                      type: TextInputType.text,
                      titleText: context.tr.email,
                      hint: 'Eng.hossam@gmail.com',
                      hasBorder: false,
                      backgroundColor: AppColors.textWhiteGrey,
                      isRequired: true,
                      validation: (value) =>
                          SharedMethods.emailValidation(value),
                    ),
                    SizedBox(height: 20.h),
                    DefaultProgressButton(
                      buttonState: ButtonState.idle,
                      loadingText: context.tr.sending,
                      idleText: context.tr.send_code_to_mail,
                      failText: context.tr.error_happened,
                      successText: context.tr.done_sending,
                      borderRadius: 4.r,
                      onPressed: () {
                        formKey.currentState!.save();
                        if (formKey.currentState!.validate()) {
                          SharedMethods.unFocusTextField(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => _ConfirmEmail(
                                email: emailController.text,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class _ConfirmEmail extends StatelessWidget {
  const _ConfirmEmail({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  Widget build(BuildContext context) {
    return ConfirmScreenContent(
        verifyOtpStep: VerifyOtpStep.email,
        token: 'token',
        phoneNumber: '',
        emailAddress: email);
  }
}
