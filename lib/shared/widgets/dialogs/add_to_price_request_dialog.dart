import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/models/supply_request/request_item.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/cart_cubit/cart_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/custom_buton_with_icon.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddToPriceRequestDialog extends StatefulWidget {
  const AddToPriceRequestDialog({Key? key, required this.product})
      : super(key: key);

  final ProductModel product;

  @override
  State<AddToPriceRequestDialog> createState() =>
      _AddToPriceRequestDialogState();
}

class _AddToPriceRequestDialogState extends State<AddToPriceRequestDialog> {
  final TextEditingController quantityController =
      TextEditingController(text: '1');

  int quantity = 1;
  late ProductUnit selectedUnit;

  @override
  void initState() {
    selectedUnit = widget.product.units.first;
    quantityController.text = selectedUnit.minimumAmountPerOrder.toString();
    super.initState();
  }

  void increaseQuantity() {
    setState(() {
      quantity++;
      quantityController.text = quantity.toString();
    });
  }

  decreaseQunatity() {
    if (quantity <= selectedUnit.minimumAmountPerOrder) {
      quantity = selectedUnit.minimumAmountPerOrder;
    } else {
      quantity--;
    }
    setState(() {
      quantityController.text = quantity.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.primaryColor, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('الكمية'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.thirdColor,
                          foregroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              decreaseQunatity();
                            },
                            icon: const Icon(Icons.remove),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Container(
                          width: 72.w,
                          // height: 40.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: CustomTextFormField(
                            enabled: false,
                            maxLines: 1,
                            controller: quantityController,
                            type: TextInputType.number,
                            hint: '',
                            validation: (value) {},
                            // hasBorder: false,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        CircleAvatar(
                          backgroundColor: AppColors.thirdColor,
                          foregroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              increaseQuantity();
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('الوحدة'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140.w,
                          height: 60.h,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton<ProductUnit>(
                            value: selectedUnit,
                            onChanged: (val) {
                              setState(() {
                                selectedUnit = val!;
                                quantity = selectedUnit.minimumAmountPerOrder;
                                quantityController.text = selectedUnit
                                    .minimumAmountPerOrder
                                    .toString();
                              });
                            },
                            items: widget.product.units
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.productUnit),
                                  ),
                                )
                                .toList(),
                            underline: Container(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text('ملاحظاتك'),
              Container(
                width: double.infinity,
                height: 100.h,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.primaryColor, width: 2),
                ),
                child: const TextField(
                  maxLines: 6,
                  minLines: 3,
                  decoration: InputDecoration(
                    hintText: 'اكتب ملاحظاتك',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              CustomButtonWithIcon(
                onPressed: () {
                  CartCubit.instance(context).addOrRemoveToCart(
                    RequestItem(
                        name: widget.product.name,
                        productUnit: selectedUnit.productUnit,
                        quantity: quantity,
                        id: widget.product.id),
                  );
                },
                iconData: Icons.add_shopping_cart,
                text: 'اضافة الي السلة',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
