import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/background_stack.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/custom_update_profile_app_bar.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/update_profile_text_field.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ChangeEmailScreen extends StatelessWidget {
  const ChangeEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
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
                  height: SharedMethods.getHeightFraction(context, 0.08),
                ),
                UpdateProfileTextField(
                  hint: 'Enter old email',
                  textEditingController: TextEditingController(),
                  label: 'Old email',
                ),
                UpdateProfileTextField(
                  hint: 'Enter the new email',
                  textEditingController: TextEditingController(),
                  label: 'New email',
                ),
                SizedBox(
                  height: SharedMethods.getHeightFraction(context, 0.03),
                ),
                CustomButton(
                  onPressed: () {},
                  backgroundColor: AppColors.primaryColor,
                  text: 'Send confirmation',
                  height: SharedMethods.getHeightFraction(context, 0.1),
                  textStyle: primaryTextStyle().copyWith(color: Colors.white),
                ),
                SizedBox(
                  height: SharedMethods.getHeightFraction(context, 0.03),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: const Text('Forget password?'),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
