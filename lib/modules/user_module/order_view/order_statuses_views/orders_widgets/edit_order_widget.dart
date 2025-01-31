import 'dart:developer';

import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/supply_request/supply_request_cart.dart';
import 'package:emdad/modules/user_module/cart_module/cart_screen.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/cart_cubit/cart_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/cart_cubit/cart_states.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/translation_service.dart';
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
                create: (_) => CartCubit(
                  intialCartItems: order.requestItems.map((e) {
                    log(e.productUnit);
                    log(e.units.first.productUnit);

                    return ProductModelInCart(
                        product: ProductModel.emptyModel().copyWith(
                            id: e.id,
                            units: e.units,
                            name: e.name,
                            images: ['']),
                        selectedProductUnit: SupplyRequestCartModel(
                            units: e.units,
                            name: e.name,
                            productUnit: e.productUnit,
                            quantity: e.quantity,
                            unitPrice: e.units
                                .firstWhere(
                                  (element) =>
                                      element.productUnit == e.productUnit,
                                  //     orElse: () {
                                  //   return e.units.first;
                                  //   ProductUnit(
                                  //       productUnit: '',
                                  //       pricePerUnit: 0,
                                  //       minimumAmountPerOrder: 0,
                                  //       id: '');
                                  // }
                                )
                                .pricePerUnit,
                            id: e.id!));
                  }).toList(),
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
                  displayTransportationCheckBox: false,
                  confirmCartButton: CartBlocConsumer(
                    listener: (context, state) {
                      if (state is ResendOrderRequestErrorState) {
                        SharedMethods.showToast(context, state.error,
                            color: AppColors.errorColor,
                            textColor: Colors.white);
                      }
                      if (state is ResendOrderRequestSuccessState) {
                        SharedMethods.showToast(
                            context, context.tr.done_resend_order,
                            color: AppColors.successColor,
                            textColor: Colors.white);
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
                        text: context.tr.resend_price_offer,
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
