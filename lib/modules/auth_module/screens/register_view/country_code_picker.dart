import 'package:country_code_picker/country_code_picker.dart';
import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryCodePickerBuildItem extends StatelessWidget {
  const CountryCodePickerBuildItem({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  final PhoneNumberInputController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PhoneNumberInput(
        initialCountry: 'EG',
        locale: 'en',
        searchHint: 'ابحث عن ...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        hint: hintText,
        allowPickFromContacts: false,
        controller: controller,
      ),
    );

    // return CountryCodePicker(
    //   backgroundColor: Colors.white,
    //   enabled: true,
    //   initialSelection: 'Eg',
    //   padding: EdgeInsets.zero,
    //   flagWidth: 25.w,
    //   showDropDownButton: true,
    //   boxDecoration: const BoxDecoration(
    //     color: Colors.white,
    //   ),
    //   flagDecoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(5.r),
    //   ),
    //   showFlagMain: true,
    //   onChanged: onChange,
    //   onInit: onInit,
    //   favorite: const ['+20', 'Eg', '+966'],
    // );
  }
}
