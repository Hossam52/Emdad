import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    Key? key,
    required String title,
    required FormFieldSetter<bool> onSaved,
    required FormFieldValidator<bool> validator,
    bool initialValue = false,
    bool autoValidate = false,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                title: Text(title, style: thirdTextStyle()),
                value: state.value,
                onChanged: state.didChange,
                contentPadding: EdgeInsets.zero,
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) => Text(
                          state.errorText!,
                          style: subTextStyle().copyWith(color: AppColors.errorColor),
                        ),
                      )
                    : null,
              );
            });
}
