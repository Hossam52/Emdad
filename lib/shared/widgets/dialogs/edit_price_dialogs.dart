import 'dart:developer';

import 'package:emdad/models/supply_request/additional_item.dart';
import 'package:emdad/models/supply_request/request_item.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_buton_with_icon.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _EditPriceContainer extends StatefulWidget {
  const _EditPriceContainer(
      {Key? key,
      required this.title,
      this.beforePriceWidget,
      this.afterPriceWidget,
      this.minPrice = 0})
      : super(key: key);
  final double minPrice;
  final String title;
  final Widget? beforePriceWidget;
  final Widget? afterPriceWidget;

  @override
  State<_EditPriceContainer> createState() => _EditPriceContainerState();
}

class _EditPriceContainerState extends State<_EditPriceContainer> {
  final priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        // height: 800.h,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: widget.title,
                  textStyle:
                      subTextStyle().copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20.h),
                if (widget.beforePriceWidget != null) widget.beforePriceWidget!,
                SizedBox(height: 20.h),
                _PriceWidget(
                  controller: priceController,
                  minPrice: widget.minPrice,
                ),
                SizedBox(height: 30.h),
                if (widget.afterPriceWidget != null) widget.afterPriceWidget!,
                SizedBox(height: 30.h),
                Align(
                  child: CustomButton(
                    height: 60.h,
                    backgroundColor: AppColors.textButtonColor,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pop(
                            context, double.tryParse(priceController.text));
                      }
                    },
                    text: 'تأكيد',
                    radius: 4.r,
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditItemPriceDialog extends StatelessWidget {
  const EditItemPriceDialog({Key? key, required this.item}) : super(key: key);
  final RequestItem item;
  @override
  Widget build(BuildContext context) {
    return _EditPriceContainer(
      title: 'تحديد سعر المنتج',
      beforePriceWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildColumItem('كمية', item.quantity.toString()),
          buildColumItem('وحدة', item.productUnit),
          buildColumItem('صنف', item.name),
        ],
      ),
    );
  }

  Widget buildColumItem(String key, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          key,
          style: subTextStyle().copyWith(
            fontWeight: FontWeight.w700,
            // color: Colors.white,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          val,
          style: subTextStyle().copyWith(
              // color: Colors.white,
              ),
        ),
      ],
    );
  }
}

class _PriceWidget extends StatefulWidget {
  const _PriceWidget({Key? key, required this.controller, this.minPrice = 0})
      : super(key: key);
  final TextEditingController controller;
  final double minPrice;

  @override
  State<_PriceWidget> createState() => _PriceWidgetState();
}

class _PriceWidgetState extends State<_PriceWidget> {
  final tax = 12;
  double total = 0;

  @override
  void initState() {
    super.initState();
    changeTotalPrice();
  }

  void changeTotalPrice() {
    setState(() {
      total = double.tryParse(widget.controller.text) ?? 0;
      total = total + total * tax / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomText(
        text: 'السعر',
        textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
      ),
      title: SizedBox(
        width: 100.w,
        child: Column(
          children: [
            CustomTextFormField(
              controller: widget.controller,
              validation: (val) {
                if (val == null || val.isEmpty) return 'السعر مطلوب';
                final price = double.tryParse(val) ?? 0;

                if (price < widget.minPrice) {
                  return 'اقل قيمة هي  ${widget.minPrice}';
                }
                return null;
              },
              onChange: (val) {
                changeTotalPrice();
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.singleLineFormatter,
                LengthLimitingTextInputFormatter(10)
              ],
              borderRadius: 0,
              contentPadding: const EdgeInsets.all(0),
            ),
          ],
        ),
      ),
      trailing: SizedBox(
        width: 100.w,
        child: Row(
          children: [
            Expanded(child: buildColumnItem(key: 'الضريبة', val: '$tax%')),
            Expanded(child: buildColumnItem(key: 'إجمالي', val: '$total')),
          ],
        ),
      ),
    );
  }

  Widget buildColumnItem({required String key, required String val}) {
    return Column(
      children: [
        CustomText(
          text: key,
          textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
        ),
        FittedBox(
          child: CustomText(
            text: val,
            textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class EditAdditionalItemPriceDialog extends StatelessWidget {
  const EditAdditionalItemPriceDialog({Key? key, required this.item})
      : super(key: key);
  final AdditionalItem item;
  @override
  Widget build(BuildContext context) {
    return _EditPriceContainer(
      title: 'تحديد سعر الطلب',
      beforePriceWidget: Row(children: [
        Text('الصنف',
            style: subTextStyle().copyWith(fontWeight: FontWeight.bold)),
        SizedBox(width: 15.w),
        Text(item.description, style: subTextStyle()),
      ]),
    );
  }
}

class EditShippingPriceDialog extends StatelessWidget {
  const EditShippingPriceDialog({Key? key, this.minPrice = 0})
      : super(key: key);
  final double minPrice;
  @override
  Widget build(BuildContext context) {
    return _EditPriceContainer(
        minPrice: minPrice,
        title: 'تحديد سعر النقل',
        beforePriceWidget: Row(
          children: [
            const Center(child: Text('أقل قيمة لتسعير النقل هي ')),
            Text(
              minPrice.toString(),
              style: secondaryTextStyle().copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
        // afterPriceWidget: Align(
        //   child: CustomButtonWithIcon(
        //     height: 60.h,
        //     color: AppColors.primaryColor,
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     text: 'طلب شركة نقل',
        //     radius: 4.r,
        //     iconData: MyIcons.truck_thin,
        //   ),
        // ),
        );
  }
}
