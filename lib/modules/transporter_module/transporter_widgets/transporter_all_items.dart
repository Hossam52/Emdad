import 'package:emdad/models/supply_request/additional_item.dart';
import 'package:emdad/models/supply_request/request_item.dart';
import 'package:emdad/modules/user_module/order_view/order_item_build.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransporterAllItemsWidget extends StatelessWidget {
  const TransporterAllItemsWidget(
      {Key? key, required this.items, required this.additionalItems})
      : super(key: key);
  final List<RequestItem> items;
  final List<AdditionalItem> additionalItems;
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty && additionalItems.isEmpty) {
      return Column(
        children: [
          CustomText(
            text: 'قائمة الطلبات',
            textStyle: subTextStyle()
                .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          Center(
            child: CustomText(
              text: 'لا يوجد طلبات',
              textStyle: subTextStyle().copyWith(fontSize: 16.sp),
            ),
          ),
        ],
      );
    }
    return Column(
      children: [
        _RequestItems(items: items),
        SizedBox(height: 20.h),
        _AdditionalItems(
          items: additionalItems,
        )
      ],
    );
  }
}

class _RequestItems extends StatelessWidget {
  const _RequestItems({Key? key, required this.items}) : super(key: key);
  final List<RequestItem> items;
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        Align(
          child: CustomText(
            text: 'قائمة الطلبات',
            textStyle: thirdTextStyle(),
          ),
        ),
        SizedBox(height: 20.h),

        /// put list view here //

        ListView.separated(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) => OrderItemBuild(
            items: [
              TableItemData(
                headerName: 'صنف',
                valueName: items[index].name,
              ),
              TableItemData(
                headerName: 'كمية',
                valueName: items[index].quantity.toString(),
              ),
              TableItemData(
                headerName: 'وحدة',
                valueName: items[index].productUnit,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _AdditionalItems extends StatelessWidget {
  const _AdditionalItems({Key? key, required this.items}) : super(key: key);
  final List<AdditionalItem> items;
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        Align(
          child: CustomText(
            text: 'قائمة الطلبات الاضافية',
            textStyle: thirdTextStyle(),
          ),
        ),
        SizedBox(height: 20.h),

        /// put list view here //

        ListView.separated(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) => OrderItemBuild(
            items: [
              TableItemData(
                headerName: 'صنف',
                valueName: items[index].description,
              ),
              const TableItemData(
                headerName: 'كمية',
                valueName: '---',
              ),
              const TableItemData(
                headerName: 'وحدة',
                valueName: '---',
              )
            ],
          ),
        ),
      ],
    );
  }
}
