import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdateProfileTextField extends StatelessWidget {
  const UpdateProfileTextField(
      {Key? key,
      required this.textEditingController,
      required this.label,
      required this.hint,
      required this.validator,
      this.isDigitsOnly = false,
      this.enabled = true})
      : super(key: key);
  final TextEditingController textEditingController;
  final String label;
  final String hint;
  final String? Function(String?) validator;
  final bool isDigitsOnly;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: thirdTextStyle().copyWith(
              color: AppColors.primaryColor, fontWeight: FontWeight.w700),
        ),
        CustomTextFormField(
          borderRadius: 15,
          hasBorder: false,
          controller: textEditingController,
          enabled: enabled,
          inputFormatters: [
            if (isDigitsOnly) FilteringTextInputFormatter.digitsOnly
          ],
          type: TextInputType.visiblePassword,
          validation: validator,
          hint: hint,
          backgroundColor: Colors.white,
        ),
        SizedBox(
          height: SharedMethods.getHeightFraction(context, 0.03),
        )
      ],
    );
  }
}
