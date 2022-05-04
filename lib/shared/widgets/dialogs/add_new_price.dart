import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewPriceDialog extends StatefulWidget {
  const AddNewPriceDialog({Key? key, required this.onSave}) : super(key: key);
  final void Function(
      {required String productUnit,
      required int minimumAmount,
      required double pricePerUnit}) onSave;

  @override
  State<AddNewPriceDialog> createState() => _AddNewPriceDialogState();
}

class _AddNewPriceDialogState extends State<AddNewPriceDialog> {
  final unitController = TextEditingController();

  final minimumController = TextEditingController();

  final priceController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SizedBox(
        height: 450.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h)
              .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildItem(title: 'وحدة القياس', controller: unitController),
              SizedBox(height: 20.h),
              _buildItem(
                  title: 'الحد الادني',
                  controller: minimumController,
                  numbersOnly: true),
              SizedBox(height: 30.h),
              _buildItem(
                  title: 'سعر الوحدة',
                  controller: priceController,
                  numbersOnly: true),
              SizedBox(height: 20.h),
              // ListTile(
              //   leading: CustomText(
              //     text: 'الضريبة',
              //     textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
              //   ),
              //   trailing: SizedBox(
              //     width: 200.w,
              //     child: buildTextFormField(
              //       controller: null,
              //       onChanged: (String? value) {},
              //       onSubmitted: (String? value) {},
              //     ),
              //   ),
              //   title: SizedBox(width: 20.w),
              // ),
              SizedBox(height: 30.h),
              Align(
                child: CustomButton(
                  width: 176.w,
                  height: 60.h,
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.onSave(
                          productUnit: unitController.text,
                          minimumAmount:
                              int.tryParse(minimumController.text) ?? 0,
                          pricePerUnit:
                              double.tryParse(priceController.text) ?? 0);
                      Navigator.pop(context);
                    }
                  },
                  text: 'حفظ',
                  radius: 4.r,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
      {required String title,
      required TextEditingController controller,
      bool numbersOnly = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomText(
          text: title,
          textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: 200.w,
          child: CustomTextFormField(
            validation: (val) {
              if (val!.isEmpty) return 'This field couldnt be empty';
              return null;
            },
            controller: controller,
            contentPadding: const EdgeInsets.all(0),
            borderRadius: 0,
            inputFormatters: numbersOnly
                ? [
                    SharedMethods.numbersOnlyFormatter(),
                  ]
                : null,
          ),
        )
      ],

      // buildTextFormField(
      //   controller: controller,
      //   onChanged: (String? value) {},
      //   onSubmitted: (String? value) {},
      // ),

      // title: SizedBox(width: 20.w),
    );
  }
}
