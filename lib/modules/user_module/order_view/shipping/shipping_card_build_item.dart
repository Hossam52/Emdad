import 'package:emdad/modules/user_module/order_view/shipping/shipping_offers_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class ShippingCardBuildItem extends StatelessWidget {
  const ShippingCardBuildItem({
    Key? key,
    required this.name,
    required this.info,
    required this.icon,
    this.borderColor = AppColors.primaryColor,
    this.price,
  }) : super(key: key);

  final String name;
  final String info;
  final Icon icon;
  final Color borderColor;
  final int? price;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderColor),
      ),
      margin: const EdgeInsets.all(16),
      child: ListTile(
          title: Text(name),
          contentPadding: const EdgeInsets.all(16),
          leading: icon,
          subtitle: Text(
            info,
            style: subTextStyle(),
          ),
          trailing: price != null
              ? Text('$price ر.س', style: secondaryTextStyle().copyWith(fontWeight: FontWeight.w700))
              : TextButton(
            onPressed: () {
              navigateTo(context, const ShippingOffersScreen());
            },
            child: const Text('عروض النقل'),
          )),
    );
  }
}
