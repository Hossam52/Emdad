import 'package:emdad/modules/user_module/checkout/checkout_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/shared_componants/custom_country_city_dropdown.dart';
import 'package:emdad/shared/widgets/ui_componants/default_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestTransformDialog extends StatefulWidget {
  const RequestTransformDialog({Key? key}) : super(key: key);

  @override
  State<RequestTransformDialog> createState() => _RequestTransformDialogState();
}

class _RequestTransformDialogState extends State<RequestTransformDialog> {
  final List<String> transportType = ['أي نوع', 'تويوتا', 'نقل'];
  final List<String> transportCity = ['كل المحافظات', 'القاهرة', 'مصر'];
  String? selectedTransport;
  String? selectedCity;
  @override
  void initState() {
    super.initState();
    if (transportType.isNotEmpty) {
      selectedTransport = transportType.first;
    }
    if (transportCity.isNotEmpty) {
      selectedCity = transportCity.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'هل تريد طلب شركة نقل؟',
              style: thirdTextStyle().copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 66.h),
            dropDownItem(
                onChanged: (val) {
                  selectedTransport = val;
                },
                items: transportType,
                hint: 'ما نوع السيارة التي تقترحها؟',
                label: 'ما نوع السيارة التي تقترحها؟',
                selected: selectedTransport),
            SizedBox(height: 50.h),
            dropDownItem(
                onChanged: (val) {
                  selectedCity = val;
                },
                items: transportCity,
                hint: 'مدينة شركة الشحن',
                label: 'مدينة شركة الشحن',
                selected: selectedCity),
            SizedBox(height: 50.h),
            CustomButton(
              onPressed: selectedCity == null ||
                      selectedTransport == null ||
                      transportType.isEmpty ||
                      transportCity.isEmpty
                  ? null
                  : () {
                      Navigator.pop(context, true);
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
