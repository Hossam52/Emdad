import 'dart:async';
import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/facility_type_view/facility_type_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/default_gesture_widget.dart';
import 'package:emdad/shared/widgets/default_progress_button.dart';
import 'package:emdad/shared/widgets/ui_componants/default_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationScreen extends StatelessWidget {
  ConfirmationScreen({
    Key? key,
    required this.verifyOtpStep,
    required this.phoneNumber,
    required this.emailAddress,
    required this.token,
  }) : super(key: key);

  final VerifyOtpStep verifyOtpStep;
  final String phoneNumber;
  final String emailAddress;
  final String token;

  final TextEditingController codeController = TextEditingController();

  final StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  final int pinCodeLength = 4;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserVerifyOtpSuccessState) {
          if (verifyOtpStep == VerifyOtpStep.phone) {
            navigateTo(
              context,
              ConfirmationScreen(
                verifyOtpStep: VerifyOtpStep.email,
                phoneNumber: phoneNumber,
                emailAddress: emailAddress,
                token: token,
              ),
            );
          } else {
            navigateToAndFinish(context, FacilityTypeScreen(token: token));
          }
        }
        if (state is UserVerifyOtpErrorState) {
          errorController.add(ErrorAnimationType.shake);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = AuthCubit.get(context);
        return DefaultGestureWidget(
          child: Scaffold(
            appBar: AppBar(
              title: CustomText(
                text: verifyOtpStep == VerifyOtpStep.phone
                    ? 'تاكيد رقم الهاتف' : 'تاكيد البريد الالكترونى',
                textStyle: secondaryTextStyle(),
              ),
              leading: Container(),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'برجاء ادخال رقم التاكيد',
                        textStyle: thirdTextStyle(),
                      ),
                      SizedBox(height: 10.h),
                      PinCodeTextField(
                        autoDismissKeyboard: true,
                        autoDisposeControllers: true,
                        autoFocus: true,
                        enablePinAutofill: true,
                        hintCharacter: '*',
                        appContext: context,
                        pastedTextStyle: const TextStyle(
                          color: AppColors.myGreyColor,
                          fontWeight: FontWeight.bold,
                        ),
                        length: pinCodeLength,
                        animationType: AnimationType.fade,
                        validator: (value) => SharedMethods.defaultValidation(
                          value,
                          message: 'من فضلك ادخل رمز التاكيد',
                        ),
                        enableActiveFill: true,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(12.r),
                          fieldHeight: 56.h,
                          fieldWidth: 56.w,
                          activeFillColor: AppColors.myGreyColor,
                          activeColor: AppColors.myGreyColor,
                          inactiveColor: AppColors.myGreyColor,
                          errorBorderColor: Colors.red,
                          selectedColor: Colors.grey,
                          selectedFillColor: AppColors.myGreyColor,
                          inactiveFillColor: AppColors.myGreyColor,
                        ),
                        cursorColor: Colors.grey,
                        animationDuration: const Duration(milliseconds: 300),
                        errorAnimationController: errorController,
                        controller: codeController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                        onCompleted: (value) {
                          SharedMethods.unFocusTextField(context);
                          formKey.currentState!.save();
                          if (formKey.currentState!.validate()) {
                            authCubit.verifyOtp(
                                codeController.text,
                                step: verifyOtpStep,
                                context: context,
                                token: token
                            );
                          }
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          CustomText(
                            text: verifyOtpStep == VerifyOtpStep.phone
                                ? 'رقم هاتفك'
                                : 'البريد هو',
                            textStyle: thirdTextStyle(),
                          ),
                          const Spacer(),
                          CustomText(
                            text: verifyOtpStep == VerifyOtpStep.phone
                                ? phoneNumber
                                : emailAddress,
                            textStyle: thirdTextStyle(),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: DefaultProgressButton(
                              buttonState: authCubit.verifyOtpButtonState,
                              idleText: 'تاكيد',
                              failText: 'حدث خطأ',
                              successText: "تم تاكيد",
                              borderRadius: 4.r,
                              onPressed: () {
                                formKey.currentState!.save();
                                if (formKey.currentState!.validate()) {
                                  SharedMethods.unFocusTextField(context);
                                  authCubit.verifyOtp(
                                    codeController.text,
                                    step: verifyOtpStep,
                                    context: context,
                                    token: token
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: CustomButton(
                              onPressed: () {},
                              text: 'تغيير رقم الهاتف',
                              textColor: AppColors.textButtonColor,
                              backgroundColor: Colors.white,
                              borderColor: AppColors.textButtonColor,
                              radius: 4.r,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'لم يتم الإستلام؟',
                            textStyle: thirdTextStyle().copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          state is UserResendOtpLoadingState
                          ? const DefaultCircularProgressIndicator()
                              : TextButton(
                            onPressed: () {
                              authCubit.resendOtp(token, verifyOtpStep, context);
                            },
                            child: Text(
                              ' اضغط هنا',
                              style: thirdTextStyle()
                                  .copyWith(color: AppColors.primaryColor),
                            ),
                          ),
                        ],
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
  }
}
