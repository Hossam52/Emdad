import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewPriceDialog extends StatelessWidget {
  const AddNewPriceDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ListTile(
              leading: CustomText(
                text: 'وحدة القياس',
                textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
              ),
              trailing: SizedBox(
                width: 200.w,
                child: buildTextFormField(
                  controller: null,
                  onChanged: (String? value) {},
                  onSubmitted: (String? value) {},
                ),
              ),
              title: SizedBox(width: 20.w),
            ),
            SizedBox(height: 20.h),
            ListTile(
              leading: CustomText(
                text: 'الحد الادني',
                textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
              ),
              trailing: SizedBox(
                width: 200.w,
                child: buildTextFormField(
                  controller: null,
                  onChanged: (String? value) {},
                  onSubmitted: (String? value) {},
                ),
              ),
              title: SizedBox(width: 20.w),
            ),
            SizedBox(height: 30.h),
            ListTile(
              leading: CustomText(
                text: 'سعر الوحدة',
                textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
              ),
              trailing: SizedBox(
                width: 200.w,
                child: buildTextFormField(
                  controller: null,
                  onChanged: (String? value) {},
                  onSubmitted: (String? value) {},
                ),
              ),
              title: SizedBox(width: 20.w),
            ),
            SizedBox(height: 20.h),
            ListTile(
              leading: CustomText(
                text: 'الضريبة',
                textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
              ),
              trailing: SizedBox(
                width: 200.w,
                child: buildTextFormField(
                  controller: null,
                  onChanged: (String? value) {},
                  onSubmitted: (String? value) {},
                ),
              ),
              title: SizedBox(width: 20.w),
            ),
            SizedBox(height: 30.h),
            Align(
              child: CustomButton(
                width: 176.w,
                height: 60.h,
                backgroundColor: AppColors.primaryColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'حفظ',
                radius: 4.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
