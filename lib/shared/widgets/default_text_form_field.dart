import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultFormField extends StatelessWidget {
  DefaultFormField({
    Key? key,
    required this.validation,
    required this.controller,
    this.hintText,
    this.secure = false,
    this.isClickable = true,
    this.enableBorders = false,
    this.type,
    this.onChanged,
    this.size,
    this.labelText,
    this.suffix,
    this.suffixPressed,
    this.actionBtn,
    this.onSubmit,
    this.onTape,
    this.prefix,
    this.haveBackground = false,
    this.inputFormatters,
    this.maxLines,
    this.borderColor = AppColors.primaryColor,
    this.readOnly = false,
  }) : super(key: key);

  final String? Function(String?) validation;
  final TextEditingController controller;
  TextInputType? type;
  Icon? prefix;
  IconData? suffix;
  String? hintText;
  Function(String)? onSubmit;
  void Function()? onTape;
  bool secure;
  Function? suffixPressed;
  bool isClickable;
  Function(String)? onChanged;
  TextInputAction? actionBtn;
  bool enableBorders;
  bool haveBackground;
  double? size;
  String? labelText;
  List<TextInputFormatter>? inputFormatters;
  Color borderColor;
  int? maxLines;
  bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (haveBackground && labelText != null) Text(labelText!),
        const SizedBox(height: 3),
        Container(
          padding: haveBackground ? const EdgeInsets.symmetric(horizontal: 16) : null,
          decoration: haveBackground
              ? BoxDecoration(
              color: Colors.white,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(13))
              : null,
          child: TextFormField(
            validator: validation,
            cursorColor: AppColors.primaryColor,
            controller: controller,
            keyboardType: type,
            textInputAction: actionBtn,
            onTap: onTape,
            enabled: isClickable,
            onFieldSubmitted: onSubmit,
            obscureText: secure,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            maxLines: secure ? 1 : maxLines,
            minLines: secure ? null : 1,
            readOnly: readOnly,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: haveBackground ? null : labelText,
              prefixIcon: prefix,
              disabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black38),
              ),
              suffixIcon: suffix != null ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                  size: size,
                ),
              ) : null,
              border: enableBorders
                  ? OutlineInputBorder(
                borderSide: haveBackground
                    ? BorderSide.none
                    : const BorderSide(width: 5.0),
              )
                  : haveBackground
                  ? const UnderlineInputBorder(
                borderSide: BorderSide.none,
              )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
