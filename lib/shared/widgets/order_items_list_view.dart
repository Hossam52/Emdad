import 'package:emdad/models/supply_request/additional_item.dart';
import 'package:emdad/models/supply_request/request_item.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/modules/user_module/order_view/order_item_build.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:flutter/material.dart';

class OrderItemsListView extends StatelessWidget {
  const OrderItemsListView(
      {Key? key,
      required this.items,
      required this.displayTotalAfterTaxes,
      this.onItemPress,
      this.trailing})
      : super(key: key);
  final List<RequestItem> items;
  final void Function(RequestItem item)? onItemPress;
  final bool displayTotalAfterTaxes;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            title: const Text('قائمة الطلبات',
                style: TextStyle(color: Colors.black)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
            trailing: trailing),
        ListView.separated(
          itemCount: items.length,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
              onTap: onItemPress == null ? null : () => onItemPress!(item),
              child: OrderItemBuild(
                hasOverlayColor:
                    item.totalPrice == null || item.totalPrice == 0,
                totalPriceAfterTaxes: displayTotalAfterTaxes
                    ? SharedMethods.getPrice(item.totalPriceAfterTaxes)
                    : null,
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
                    valueName: SharedMethods.getPrice(item.totalPrice),
                  ),
                  TableItemData(
                    headerName: 'ضريبة',
                    valueName: (item.taxesRatio * 100).toString() + ' %',
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class OrderAdditionalItemsListView extends StatelessWidget {
  const OrderAdditionalItemsListView(
      {Key? key, required this.order, this.onItemTap})
      : super(key: key);
  final SupplyRequest order;
  final void Function(AdditionalItem item)? onItemTap;
  @override
  Widget build(BuildContext context) {
    final additionalItems = order.additionalItems;
    if (additionalItems.isEmpty) return const SizedBox.shrink();
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
          itemBuilder: (context, index) => GestureDetector(
            onTap: onItemTap == null
                ? null
                : () => onItemTap!(additionalItems[index]),
            child: OrderItemBuild(
              hasOverlayColor: additionalItems[index].price == 0,
              items: [
                TableItemData(
                  headerName: 'الوصف',
                  valueName: additionalItems[index].description,
                ),
                TableItemData(
                  headerName: 'سعر',
                  valueName:
                      SharedMethods.getPrice(additionalItems[index].price),
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
        ),
      ],
    );
  }
}
