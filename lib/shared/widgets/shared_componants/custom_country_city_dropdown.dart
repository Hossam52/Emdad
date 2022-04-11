import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/widgets/ui_componants/default_drop_down.dart';
import 'package:flutter/material.dart';

class CustomCountryCityDropdown extends StatelessWidget {
  const CustomCountryCityDropdown({
    Key? key,
    required this.cubit,
    required this.countries,
    required this.cities,
  }) : super(key: key);

  final AuthCubit cubit;
  final List<String> countries;
  final List<String> cities;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DefaultDropDown(
            hint: 'الدولة',
            selectedValue: cubit.selectedCountry,
            onChanged: (value) {
              cubit.onCountryChange(value);
            },
            validator: (value) =>
                SharedMethods.defaultValidation(value),
            items: countries,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: DefaultDropDown(
            hint: 'المدينة',
            selectedValue: cubit.selectedCity,
            onChanged: (value) {
              cubit.onCityChange(value);
            },
            validator: (value) =>
                SharedMethods.defaultValidation(value),
            items: cities,
          ),
        ),
      ],
    );
  }
}
