import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/modules/user_module/cart_module/cart_screen.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/cart_cubit/cart_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/cart_cubit/cart_states.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:emdad/shared/widgets/ui_componants/default_loader.dart';

class EditOrderItemsWidget extends StatelessWidget {
  const EditOrderItemsWidget({Key? key, required this.order}) : super(key: key);
  final SupplyRequest order;

  @override
  Widget build(BuildContext context) {
    if (!order.vendorProvidePriceOffer) return const SizedBox.shrink();
    return CustomIconButton(
      width: 45.w,
      height: 45.h,
      icon: const Icon(MyIcons.edit, color: Colors.white),
      buttonColor: AppColors.secondaryColor,
      onPressed: () async {
        final successResendOrder = await navigateTo(
          context,
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CartCubit(
                  initialAdditioalItems:
                      order.additionalItems.map((e) => e.description).toList(),
                ),
                lazy: false,
              ),
              BlocProvider(
                create: (context) =>
                    VendorProfileCubit(vendorId: order.vendorId)
                      ..getVendorInfo(),
              ),
            ],
            child: Builder(builder: (context) {
              return CartScreen(
                  confirmCartButton: CartBlocConsumer(
                listener: (context, state) {
                  if (state is ResendOrderRequestErrorState) {
                    SharedMethods.showToast(context, state.error,
                        color: AppColors.errorColor, textColor: Colors.white);
                  }
                  if (state is ResendOrderRequestSuccessState) {
                    SharedMethods.showToast(context, 'تم اعادة الطلب بنجاح',
                        color: AppColors.successColor, textColor: Colors.white);
                    Navigator.pop(context, true);
                  }
                },
                builder: (context, state) {
                  final cartCubit = CartCubit.instance(context);
                  if (state is ResendOrderRequestLoadingState) {
                    return const DefaultLoader();
                  }
                  return CustomButton(
                    onPressed: !cartCubit.canOrderRequest
                        ? null
                        : () async {
                            await cartCubit.resendOrderRequest(
                                supplyRequestId: order.id);
                          },
                    text: 'اعادة ارسال عرض سعر',
                    backgroundColor: AppColors.primaryColor,
                  );
                },
              ));
            }),
          ),
        );
        if (successResendOrder != null && successResendOrder) {
          Navigator.pop(context, true);
        }
      },
    );
  }
}
