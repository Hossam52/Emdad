import 'package:emdad/modules/user_module/order_view/order_cubit/order_cubit.dart';
import 'package:emdad/modules/user_module/order_view/order_item_build.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:flutter/material.dart';

class OrderOutOfProducts extends StatelessWidget {
  const OrderOutOfProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrderBlocBuilder(
      builder: (context, state) {
        final additionalItems =
            OrderCubit.instance(context).order.additionalItems;
        if (additionalItems.isEmpty) return Container();
        return Column(
          children: [
            DefaultHomeTitleBuildItem(
              title: 'طلب خارج قائمة المنتجات',
              onPressed: () {},
              hasButton: false,
            ),
            ListView.separated(
              itemCount: additionalItems.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) => OrderItemBuild(
                items: [
                  TableItemData(
                    headerName: 'الوصف',
                    valueName: additionalItems[index].description,
                  ),
                  TableItemData(
                    headerName: 'سعر',
                    valueName: additionalItems[index].price.toInt().toString(),
                  ),
                  TableItemData(
                    headerName: 'ضريبة',
                    valueName:
                        (additionalItems[index].taxesRatio * 100).toString(),
                  )
                ],
                radius: 3,
              ),
            ),
          ],
        );
      },
    );
  }
}
