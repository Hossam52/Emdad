import 'dart:developer';

import 'package:emdad/modules/user_module/cart_module/cart_screen.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/cart_cubit/cart_cubit.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBarBuildItem extends StatelessWidget {
  const CartBarBuildItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CartBlocBuilder(
      builder: (context, state) {
        final cartCubit = CartCubit.instance(context);

        return Visibility(
          visible: cartCubit.cart.isNotEmpty,
          child: Card(
            color: AppColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
              onTap: () async {
                final confirmedOrder = await navigateTo<bool?>(
                  context,
                  MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: CartCubit.instance(context),
                      ),
                      BlocProvider.value(
                        value: VendorProfileCubit.instance(context),
                      ),
                    ],
                    child: CartScreen(
                      confirmCartButton: CustomButton(
                        onPressed: !cartCubit.canOrderRequest
                            ? null
                            : () async {
                                await cartCubit.createRequest();
                              },
                        text: 'تأكيد طلب عرض سعر',
                        backgroundColor: AppColors.primaryColor,
                      ),
                    ),
                  ),
                );
                if (confirmedOrder != null && confirmedOrder) {
                  Navigator.pop(context);
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.secondaryColor, width: 2)),
                      child: Text(cartCubit.cart.length.toString(),
                          style: const TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'إنتقال الي قائمة الطلبات',
                      style: thirdTextStyle().copyWith(color: Colors.white),
                    ),
                    const Spacer(),
                    Text('إجمالي:',
                        style: subTextStyle().copyWith(color: Colors.white)),
                    const SizedBox(width: 5),
                    Text(cartCubit.totalCartPrice.toString(),
                        style:
                            secondaryTextStyle().copyWith(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
