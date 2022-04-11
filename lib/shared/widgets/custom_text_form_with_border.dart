import 'package:country_code_picker/country_code_picker.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFiledWithBorder extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final String? hint;
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final String? Function(String?)? validate;
  final String? labelText;
  final String? titleText;
  final Function()? onTap;
  final IconData? suffixIcon;
  final bool isPassword;
  final bool enabled;
  final Function? suffixPressed;
  final Function(String?)? onSaved;
  final FocusNode? focusNode;

  const TextFormFiledWithBorder({
    Key? key,
    this.controller,
    required this.type,
    required this.hint,
    this.onSubmit,
    this.onChange,
    required this.validate,
    this.labelText,
    this.titleText,
    this.onTap,
    this.suffixIcon,
    this.isPassword = false,
    this.enabled = true,
    this.suffixPressed,
    this.onSaved,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText!,
          style: thirdTextStyle(),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 15.h),
        Container(
          alignment: Alignment.center,
          height: 55.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextFormField(
            enabled: enabled,
            focusNode: focusNode,
            textAlignVertical: TextAlignVertical.center,
            // textAlign: TextAlign.left,
            controller: controller,
            keyboardType: type,
            onFieldSubmitted: onSubmit,
            onChanged: onChange,
            onTap: onTap,
            onSaved: onSaved,
            validator: validate,
            obscureText: isPassword,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: hint,
              alignLabelWithHint: true,
              hintStyle: thirdTextStyle(),
              filled: true,
              fillColor: AppColors.textWhiteGrey,
              enabled: true,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.w,
                ),
              ),
              prefixIcon: type == TextInputType.phone
                  ? CountryCodePicker(
                      backgroundColor: Colors.white,
                      enabled: true,
                      initialSelection: 'Eg',
                      padding: EdgeInsets.zero,
                      flagWidth: 20.w,
                      showDropDownButton: true,
                      boxDecoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      flagDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      showFlagMain: true,
                      onChanged: print,
                      favorite: const ['+20', 'Eg', '+966'],
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
