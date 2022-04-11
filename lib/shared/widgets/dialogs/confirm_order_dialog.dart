import 'package:emdad/modules/user_module/checkout/checkout_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmOrderDialog extends StatefulWidget {
  const ConfirmOrderDialog({Key? key}) : super(key: key);

  @override
  State<ConfirmOrderDialog> createState() => _ConfirmOrderDialogState();
}

class _ConfirmOrderDialogState extends State<ConfirmOrderDialog> {
  bool hasTransportMethod = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'تأكيد أمر الشراء',
              style: thirdTextStyle().copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 66.h),
            CheckboxListTile(
              value: hasTransportMethod,
              checkColor: Colors.white,
              activeColor: AppColors.successColor,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  hasTransportMethod = !hasTransportMethod;
                });
              },
              title: Text(
                'هل لديك توصيل خاص ؟',
                style: thirdTextStyle().copyWith(color: AppColors.primaryColor),
              ),
            ),
            SizedBox(height: 50.h),
            CustomButton(
              onPressed: () {
                Navigator.pop(context, hasTransportMethod);
              },
              text: 'إرسال أمر الشراء',
              radius: 10,
            ),
            SizedBox(height: 20.h),
            // CustomButton(
            //   onPressed: () {
            //     navigateTo(context, const ShippingOffersScreen());
            //   },
            //   text: 'إرسال طلب عرض سعر لشركة نقل',
            //   backgroundColor: AppColors.thirdColor,
            //   radius: 10,
            // ),
          ],
        ),
      ),
    );
  }
}
