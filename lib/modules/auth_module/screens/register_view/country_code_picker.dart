import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryCodePickerBuildItem extends StatelessWidget {
  const CountryCodePickerBuildItem({
    Key? key,
    required this.onChange,
    required this.onInit,
  }) : super(key: key);

  final Function(CountryCode) onChange;
  final Function(CountryCode?) onInit;

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      backgroundColor: Colors.white,
      enabled: true,
      initialSelection: 'Eg',
      padding: EdgeInsets.zero,
      flagWidth: 25.w,
      showDropDownButton: true,
      boxDecoration: const BoxDecoration(
        color: Colors.white,
      ),
      flagDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
      ),
      showFlagMain: true,
      onChanged: onChange,
      onInit: onInit,
      favorite: const ['+20', 'Eg', '+966'],
    );
  }
}
