import 'package:country_code_picker/country_code_picker.dart';
import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/register_view/country_code_picker.dart';
import 'package:emdad/modules/auth_module/screens/register_view/register_screen.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/background_stack.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/custom_update_profile_app_bar.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/update_profile_text_field.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/ui_componants/default_loader.dart';
import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePhoneScreen extends StatefulWidget {
  const ChangePhoneScreen({Key? key}) : super(key: key);

  @override
  State<ChangePhoneScreen> createState() => _ChangePhoneScreenState();
}

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {
  final formKey = GlobalKey<FormState>();

  final phoneNumberController = TextEditingController();
  final countryCodeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final user = AppCubit.get(context).getUser;

    phoneNumberController.text = user!.primaryPhoneNumber!.number;
    countryCodeController.text = user.primaryPhoneNumber!.countryCode;
  }

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
              if (state is UpdateProfileErrorState) {
                SharedMethods.showToast(context, state.error,
                    textColor: Colors.white, color: AppColors.errorColor);
              }
              if (state is UpdateProfileSuccessState) {
                SharedMethods.showToast(context, context.tr.done_change_phone,
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
                          title: context.tr.change_phone_number,
                        ),
                        sizedBox,
                        Theme(
                          data: Theme.of(context).copyWith(
                              inputDecorationTheme: const InputDecorationTheme(
                                  filled: true, fillColor: Colors.white)),
                          child: CountryCodePickerBuildItem(
                              controller: PhoneNumberInputController(context),
                              hintText: context.tr.your_phone),
                        ),
                        sizedBox,
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
                                AuthCubit.get(context).changePhoneNumber(
                                    phoneNumber: phoneNumberController.text);
                              }
                            },
                            backgroundColor: AppColors.primaryColor,
                            text: context.tr.change_phone,
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
                            child: Text(
                              context.tr.forgot_password + ' ? ',
                            ),
                          ),
                        ),
                        SizedBox(
                            height:
                                SharedMethods.getHeightFraction(context, 0.05)),
                        Center(
                          child: RichText(
                              text: TextSpan(
                                  text: context.tr.dont_have_account,
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
