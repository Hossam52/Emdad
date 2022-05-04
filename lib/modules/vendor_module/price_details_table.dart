import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/models/general_models/product_detailes.dart';
import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/vendor_product_crud_cubit/vendor_product_crud_cubit.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/vendor_product_crud_cubit/vendor_product_crud_states.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceDetailsTable extends StatelessWidget {
  const PriceDetailsTable({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return VendorProductCrudCubitBlocBuilder(
      buildWhen: (previous, current) =>
          current is RemovePriceUnit || current is AddPriceUnit,
      builder: (context, state) {
        final priceUnits = VendorProductCrudCubit.instance(context).units;
        return Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 2.5,
                color: AppColors.textButtonColor,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Table(
            children: [
              TableRow(children: [
                buildHeaderItem('وحدة القياس'),
                buildHeaderItem('الحد الادني'),
                buildHeaderItem('سعر الوحدة'),
                buildHeaderItem('الضريبة'),
                buildHeaderItem(''),
              ]),
              for (int unitIndex = 0;
                  unitIndex < priceUnits.length;
                  unitIndex++)
                TableRow(
                  children: [
                    buildColoredItem(priceUnits[unitIndex].productUnit),
                    buildColoredItem(
                        priceUnits[unitIndex].minimumAmountPerOrder.toString()),
                    buildColoredItem(
                        priceUnits[unitIndex].pricePerUnit.toString()),
                    SizedBox(
                      width: 60.w,
                      child: CustomText(
                        text: '١٥٪',
                        textStyle: subTextStyle().copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        final confirmDelete = await onDeleteItem(context);
                        if (confirmDelete != null && confirmDelete) {
                          VendorProductCrudCubit.instance(context)
                              .removePriceUnit(unitIndex);
                        }
                      },
                      icon: const Icon(Icons.close),
                      color: AppColors.errorColor,
                    )
                  ],
                )
            ],
          ),
        );
      },
    );
  }

  Future<bool?> onDeleteItem(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("حذف سعر"),
        content: const Text("هل أنت متأكد"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // vendorCubit.deletePriceDetails(index);
              Navigator.of(ctx).pop(true);
            },
            child: Text(
              "نعم",
              style: thirdTextStyle().copyWith(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
            child: Text(
              "لا",
              style: thirdTextStyle().copyWith(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeaderItem(String text) {
    return Center(
        child: Text(text,
            style: subTextStyle().copyWith(fontWeight: FontWeight.w700)));
  }

  Widget buildColoredItem(String text) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 60.w,
      decoration: const BoxDecoration(
        color: AppColors.textButtonColor,
      ),
      child: CustomText(
        text: text,
        textStyle: subTextStyle().copyWith(
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
