import 'package:emdad/modules/vendor_module/price_details_table.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/vendor_product_crud_cubit/vendor_product_crud_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:emdad/shared/widgets/dialogs/add_new_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({Key? key, required this.productCubit})
      : super(key: key);
  final VendorProductCrudCubit productCubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        productTextField('اسم المنتج', productCubit.productNameController),
        productTextField(
            'تفاصيل المنتج', productCubit.productDescriptionController),
        productTextField('نوع المنتج', productCubit.productTypeController),
        productTextField('ملاحظات', productCubit.productNotesController,
            isRequired: false),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'تفاصيل السعر',
              textStyle:
                  secondaryTextStyle().copyWith(fontWeight: FontWeight.w700),
            ),
            InkWell(
              onTap: () {
                showModalSheet(context);
              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 35.r,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        const PriceDetailsTable(),
        SizedBox(height: 40.h),
        ListTile(
          trailing: Checkbox(
            value: productCubit.product.isPriceShown,
            onChanged: (bool? value) {
              productCubit.changePriceVisibility(value!);
            },
            activeColor: Colors.green,
          ),
          leading: CustomText(
            text: 'اظهار السعر',
            textStyle: thirdTextStyle().copyWith(fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }

  Widget productTextField(String title, TextEditingController controller,
      {bool isRequired = true}) {
    return Column(
      children: [
        CustomText(
          text: title,
          textStyle: secondaryTextStyle().copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 5.h),
        buildTextFormField(
          controller: controller,
          onChanged: (String? value) {},
          onSubmitted: (String? value) {},
          isRequired: isRequired,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  showModalSheet(BuildContext context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext _context) {
        return AddNewPriceDialog(
          onSave: (
              {required minimumAmount,
              required pricePerUnit,
              required productUnit}) {
            VendorProductCrudCubit.instance(context).addPriceUnit(
                productUnit: productUnit,
                minimumAmount: minimumAmount,
                pricePerUnit: pricePerUnit);
          },
        );
      },
    );
  }

  Widget buildTextFormField({
    required TextEditingController? controller,
    required Function(String)? onChanged,
    required Function(String)? onSubmitted,
    bool isRequired = true,
  }) {
    return CustomTextFormField(
      validation: (val) {
        if (isRequired && (val == null || val.isEmpty)) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
      controller: controller,
      contentPadding: const EdgeInsets.all(4),
      onChange: onChanged,
      onSubmit: onSubmitted,
    );
  }
}
