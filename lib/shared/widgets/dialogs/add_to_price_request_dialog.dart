import 'dart:developer';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/models/supply_request/request_item.dart';
import 'package:emdad/models/supply_request/supply_request_cart.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/cart_cubit/cart_cubit.dart';
import 'package:emdad/shared/componants/components.dart';
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
  SupplyRequestCartModel?
      cartItem; //if provided that means i edit this product not add new

  int quantity = 1;
  late ProductUnit selectedUnit;

  //To know if i edit product or not
  bool get isEditProductCart => cartItem != null;

  ProductUnit get getProductUnit {
    if (isEditProductCart) {
      return widget.product.units
          .firstWhere((unit) => unit.productUnit == cartItem!.productUnit);
    } else {
      return widget.product.units.first;
    }
  }

  int get getQuantity {
    if (isEditProductCart) {
      return cartItem!.quantity;
    } else {
      return selectedUnit.minimumAmountPerOrder;
    }
  }

  @override
  void initState() {
    cartItem = CartCubit.instance(context)
        .getCartItem(widget.product.id)
        ?.selectedProductUnit;
    selectedUnit = getProductUnit;
    quantity = getQuantity;
    quantityController.text = quantity.toString();
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

  ProductModelInCart get getRequestItem {
    return ProductModelInCart(
      product: widget.product,
      selectedProductUnit: SupplyRequestCartModel(
        name: widget.product.name,
        units: widget.product.units,
        productUnit: selectedUnit.productUnit,
        quantity: quantity,
        unitPrice: selectedUnit.pricePerUnit,
        id: widget.product.id,
      ),
    );
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
              if (isEditProductCart)
                _editCartItemActions(context)
              else
                _addNewToCartActions(context),
            ],
          ),
        ),
      ),
    );
  }

  CustomButtonWithIcon _addNewToCartActions(BuildContext context) {
    return CustomButtonWithIcon(
      onPressed: () {
        CartCubit.instance(context).addOrEditCartItem(getRequestItem);
        showSnackbarAndCloseDialog(
            context: context, text: 'تم الاضافة بنجاح الي السلة');
      },
      iconData: Icons.add_shopping_cart,
      text: 'اضافة الي السلة',
    );
  }

  Row _editCartItemActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButtonWithIcon(
            onPressed: () {
              CartCubit.instance(context).removeFromCart(widget.product.id);
              showSnackbarAndCloseDialog(
                  context: context, text: 'تم الحذف  بنجاح ');
            },
            color: AppColors.errorColor,
            iconData: Icons.close,
            text: 'حذف الطلب من السلة',
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: CustomButtonWithIcon(
            onPressed: () {
              CartCubit.instance(context).addOrEditCartItem(getRequestItem);
              showSnackbarAndCloseDialog(
                  context: context, text: 'تم تعديل الطلب');
            },
            iconData: Icons.edit,
            text: 'تعديل الطلب',
          ),
        ),
      ],
    );
  }

  void showSnackbarAndCloseDialog(
      {required BuildContext context, required String text}) {
    Navigator.pop(context);
    showSnackBar(
        context: context, text: text, snackBarStates: SnackBarStates.success);
  }
}
