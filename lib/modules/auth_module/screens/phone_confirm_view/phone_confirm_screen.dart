import 'dart:async';
import 'dart:developer';
import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/facility_type_view/facility_type_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/default_gesture_widget.dart';
import 'package:emdad/shared/widgets/default_progress_button.dart';
import 'package:emdad/shared/widgets/ui_componants/default_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationScreen extends StatefulWidget {
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

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserVerifyOtpSuccessState) {
          if (widget.verifyOtpStep == VerifyOtpStep.phone) {
            navigateTo(
              context,
              ConfirmationScreen(
                verifyOtpStep: VerifyOtpStep.email,
                phoneNumber: widget.phoneNumber,
                emailAddress: widget.emailAddress,
                token: widget.token,
              ),
            );
          } else {
            navigateToAndFinish(
                context, FacilityTypeScreen(token: widget.token));
          }
        }
      },
      builder: (context, state) {
        return ConfirmScreenContent(
            verifyOtpStep: widget.verifyOtpStep,
            token: widget.token,
            phoneNumber: widget.phoneNumber,
            emailAddress: widget.emailAddress);
      },
    );
  }
}

class ConfirmScreenContent extends StatefulWidget {
  ConfirmScreenContent({
    Key? key,
    required this.verifyOtpStep,
    required this.token,
    required this.phoneNumber,
    required this.emailAddress,
  }) : super(key: key);

  final VerifyOtpStep verifyOtpStep;
  final String token;
  final String phoneNumber;
  final String emailAddress;

  @override
  State<ConfirmScreenContent> createState() => _ConfirmScreenContentState();
}

class _ConfirmScreenContentState extends State<ConfirmScreenContent> {
  final int pinCodeLength = 4;

  final formKey = GlobalKey<FormState>();

  final TextEditingController codeController = TextEditingController();

  final StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = AuthCubit.get(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserVerifyOtpErrorState) {
          errorController.add(ErrorAnimationType.shake);
        }
      },
      child: DefaultGestureWidget(
        child: Scaffold(
          appBar: AppBar(
            title: CustomText(
              text: widget.verifyOtpStep == VerifyOtpStep.phone
                  ? context.tr.confirm_phone
                  : context.tr.confirm_email,
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
                      text: context.tr.enter_confirmation_code,
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
                        message: context.tr.enter_confirmation_code,
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
                          authCubit.verifyOtp(codeController.text,
                              step: widget.verifyOtpStep,
                              context: context,
                              token: widget.token);
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
                          text: widget.verifyOtpStep == VerifyOtpStep.phone
                              ? context.tr.your_phone
                              : context.tr.email,
                          textStyle: thirdTextStyle(),
                        ),
                        const Spacer(),
                        CustomText(
                          text: widget.verifyOtpStep == VerifyOtpStep.phone
                              ? widget.phoneNumber
                              : widget.emailAddress,
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
                            idleText: context.tr.confirm,
                            failText: context.tr.error_happened,
                            successText: "تم تاكيد",
                            borderRadius: 4.r,
                            onPressed: () {
                              formKey.currentState!.save();
                              if (formKey.currentState!.validate()) {
                                SharedMethods.unFocusTextField(context);
                                authCubit.verifyOtp(codeController.text,
                                    step: widget.verifyOtpStep,
                                    context: context,
                                    token: widget.token);
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 20.w),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    _ResendCode(
                      token: widget.token,
                      verifyOtpStep: widget.verifyOtpStep,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResendCode extends StatefulWidget {
  const _ResendCode(
      {Key? key, required this.token, required this.verifyOtpStep})
      : super(key: key);
  final String token;
  final VerifyOtpStep verifyOtpStep;

  @override
  State<_ResendCode> createState() => _ResendCodeState();
}

class _ResendCodeState extends State<_ResendCode> {
  bool displayCounter = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        log('Will pop');
        AuthCubit.get(context).displayCounterOtp = false;
        return true;
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final authCubit = AuthCubit.get(context);
          if (authCubit.displayCounterOtp) {
            return countDown(authCubit);
          } else {
            return notRecieved(state, authCubit);
          }
        },
      ),
    );
  }

  Widget countDown(AuthCubit authCubit) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomText(
            text: context.tr.time_to_resend,
            textStyle: thirdTextStyle()
                .copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 20.w),
          TimerCountdown(
              onEnd: () {
                authCubit.changeDisplayCounter();
              },
              format: CountDownTimerFormat.minutesSeconds,
              secondsDescription: '',
              minutesDescription: '',
              timeTextStyle: secondaryTextStyle(),
              spacerWidth: 0,
              endTime: DateTime.now().add(const Duration(seconds: 31))),
        ],
      ),
    );
  }

  Widget notRecieved(AuthState state, AuthCubit authCubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: 'لم يتم الإستلام؟',
          textStyle: thirdTextStyle()
              .copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 20.w,
        ),
        state is UserResendOtpLoadingState
            ? const DefaultCircularProgressIndicator()
            : TextButton(
                onPressed: () async {
                  await authCubit.resendOtp(
                      widget.token, widget.verifyOtpStep, context);
                  final state = authCubit.state;
                  if (state is UserResendOtpSuccessState) {
                    authCubit.changeDisplayCounter();
                  }
                },
                child: Text(
                  context.tr.press_here,
                  style:
                      thirdTextStyle().copyWith(color: AppColors.primaryColor),
                ),
              ),
      ],
    );
  }
}
