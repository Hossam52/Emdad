import 'dart:developer';

import 'package:emdad/modules/user_module/order_view/order_cubit/order_cubit.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_states.dart';
import 'package:emdad/modules/user_module/vendors_module/change_filters_cubit/change_filters_cubit.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/ui_componants/default_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestTransformDialog extends StatelessWidget {
  const RequestTransformDialog(
      {Key? key,
      required this.onCreateTransportRequest,
      required this.isLoading})
      : super(key: key);
  final void Function(
      {required String transportationMethod,
      required String city}) onCreateTransportRequest;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangeFiltersCubit()
        ..initFilters(context)
        ..setIntialValues(
          setSelectedCountryToFirst: true,
          setSelectedTransportationToFirst: true,
        ),
      child: ChangeFiltersBlocBuilder(
        builder: (context, changeFilterState) {
          final filtersCubit = ChangeFiltersCubit.instance(context);

          return Dialog(
            child: Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'هل تريد طلب شركة نقل؟',
                          style: thirdTextStyle()
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 66.h),
                        dropDownItem(
                            onChanged:
                                filtersCubit.changeSelectedTransportation,
                            items: filtersCubit.transportationMethods,
                            hint: 'ما نوع السيارة التي تقترحها؟',
                            label: 'ما نوع السيارة التي تقترحها؟',
                            selected: filtersCubit.selectedTransportation),
                        SizedBox(height: 50.h),
                        dropDownItem(
                            onChanged: (country) => filtersCubit
                                .changeSelectedCountry(context, country),
                            items: filtersCubit.countries,
                            hint: 'دولة شركة الشحن',
                            label: 'دولة شركة الشحن',
                            selected: filtersCubit.selectedCountry),
                        SizedBox(height: 50.h),
                        dropDownItem(
                            onChanged: filtersCubit.changeSelectedCity,
                            items: filtersCubit.cities,
                            hint: 'مدينة شركة الشحن',
                            label: 'مدينة شركة الشحن',
                            selected: filtersCubit.selectedCity),
                        SizedBox(height: 50.h),
                        if (isLoading)
                          const DefaultLoader()
                        else
                          CustomButton(
                            onPressed: filtersCubit.selectedCity == null
                                ? null
                                : () {
                                    onCreateTransportRequest(
                                        city: filtersCubit.selectedCity!,
                                        transportationMethod: filtersCubit
                                            .selectedTransportation!);
                                    // OrderCubit.instance(context)
                                    //     .createTransportationRequest(
                                    //   city: filtersCubit.selectedCity!,
                                    //   transportationMethod:
                                    //       filtersCubit.selectedTransportation!,
                                    // );
                                  },
                            backgroundColor: AppColors.primaryColor,
                            text: 'إرسال طلب عرض سعر لشركة النقل',
                            radius: 10,
                          ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget dropDownItem(
      {required String label,
      required String hint,
      required List<String> items,
      required void Function(String) onChanged,
      required String? selected}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          textStyle: thirdTextStyle().copyWith(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 12.h,
        ),
        DefaultDropDown(
            onChanged: onChanged,
            validator: (val) {},
            items: items,
            // hint: label,
            // ignore: prefer_if_null_operators
            selectedValue: selected != null
                ? selected
                : items.isEmpty
                    ? null
                    : items.first),
      ],
    );
  }
}
