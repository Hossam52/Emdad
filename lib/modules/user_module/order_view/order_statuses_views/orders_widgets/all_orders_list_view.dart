import 'package:emdad/modules/user_module/cart_module/cart_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_cubit.dart';
import 'package:emdad/modules/user_module/order_view/order_item_build.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllOrdersListView extends StatelessWidget {
  const AllOrdersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrderBlocBuilder(
      builder: (context, state) {
        final items = OrderCubit.instance(context).order.requestItems;
        return Column(
          children: [
            ListTile(
              title: const Text('قائمة الطلبات',
                  style: TextStyle(color: Colors.black)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
              trailing: CustomIconButton(
                width: 45.w,
                height: 45.h,
                icon: const Icon(MyIcons.edit, color: Colors.white),
                buttonColor: AppColors.secondaryColor,
                onPressed: () {
                  navigateTo(
                      context, CartScreen(title: 'الهدي للتوريدات الغذائيه'));
                },
              ),
            ),
            ListView.separated(
              itemCount: items.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                final item = items[index];
                return OrderItemBuild(
                  totalPriceAfterTaxes: item.totalPriceAfterTaxes,
                  items: [
                    TableItemData(
                      headerName: 'صنف',
                      valueName: item.name,
                    ),
                    TableItemData(
                      headerName: 'كمية',
                      valueName: item.quantity.toString(),
                    ),
                    TableItemData(
                      headerName: 'وحدة',
                      valueName: item.productUnit,
                    ),
                    TableItemData(
                      headerName: 'سعر',
                      valueName: item.totalPrice!.toInt().toString(),
                    ),
                    TableItemData(
                      headerName: 'ضريبة',
                      valueName: (item.taxesRatio * 100).toString() + ' %',
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
