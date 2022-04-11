import 'package:emdad/modules/user_module/cart_module/cart_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class CartBarBuildItem extends StatelessWidget {
  const CartBarBuildItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          navigateTo(context, CartScreen(title: 'الهدي للتوريدات الغذائيه',));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.secondaryColor, width: 2)
                ),
                child: const Text('2', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),
              Text('إنتقال الي قائمة الطلبات', style: thirdTextStyle().copyWith(color: Colors.white),),
              const Spacer(),
              Text('إجمالي:', style: subTextStyle().copyWith(color: Colors.white)),
              const SizedBox(width: 5),
              Text('520 ر.س', style: secondaryTextStyle().copyWith(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
