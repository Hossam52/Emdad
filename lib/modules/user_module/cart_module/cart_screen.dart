import 'package:emdad/models/products_and_categories/category_model.dart';
import 'package:emdad/modules/transporter_module/screens/transporter_offers_view/transporter_offer_details_screen.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_cubit.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_states.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/cart_cubit/cart_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/cart_cubit/cart_states.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/category_screen.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_componants/vendor_info_build_item.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_chip.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/default_text_form_field.dart';
import 'package:emdad/shared/widgets/empty_data.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_build_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({
    Key? key,
    required this.confirmCartButton,
    this.displayTransportationCheckBox = true,
  }) : super(key: key);
  final Widget confirmCartButton;
  final bool displayTransportationCheckBox;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('قائمة الطلبات', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: VendorProfileBlocBuilder(
        builder: (context, vendorProfileState) {
          final vendorProfileCubit = VendorProfileCubit.instance(context);
          if (vendorProfileState is GetVendorInfoLoadingState) {
            return const DefaultLoader();
          }
          if (vendorProfileState is GetVendorInfoErrorState) {
            return NoDataWidget(
              onPressed: () {
                vendorProfileCubit.getVendorInfo();
              },
              text: vendorProfileState.error,
            );
          }
          if (!vendorProfileCubit.isProfileLoaded) {
            return NoDataWidget(
              onPressed: () {
                vendorProfileCubit.getVendorInfo();
              },
              text: 'Error when load vendor info try again',
            );
          }
          final vendor = VendorProfileCubit.instance(context).getVendorData;
          return CartBlocConsumer(
            listener: (context, state) async {
              if (state is CreateRequestErrorState) {
                SharedMethods.showToast(
                  context,
                  state.error,
                  color: AppColors.errorColor,
                  textColor: Colors.white,
                );
              }
              if (state is CreateRequestSuccessState) {
                await showDialog(
                    context: context,
                    builder: (_) => SuccessSendingOffer(onPressed: () {}));
                Navigator.pop(context, true);
              }
            },
            builder: (context, state) {
              final cartCubit = CartCubit.instance(context);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    VendorInfoBuildItem(
                      name: vendor.name!,
                      isCart: true,
                      city: vendor.city,
                      logoUrl: vendor.logoUrl,
                      vendorType: vendor.allVendorTypeString,
                      tailing: CustomButton(
                        onPressed: () {
                          navigateTo(
                            context,
                            MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: VendorProfileCubit.instance(context),
                                ),
                                BlocProvider.value(
                                  value: CartCubit.instance(context),
                                ),
                              ],
                              child: const CategoryScreen(
                                title: 'All products',
                              ),
                            ),
                          );
                        },
                        text: 'إضافه منتج',
                      ),
                    ),
                    const SizedBox(height: 16),
                    _AddAdditionalItems(controller: controller),
                    if (displayTransportationCheckBox)
                      const _TransportationHandler(),
                    _cartItems(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: confirmCartButton,
                          ),
                          const SizedBox(width: 19),
                          Expanded(
                              child: CustomButton(
                            onPressed: () => Navigator.pop(context),
                            text: 'إلغاء',
                            backgroundColor: AppColors.errorColor,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _cartItems() {
    return Builder(builder: (context) {
      final cartItems = CartCubit.instance(context).cart;
      return Column(
        children: [
          const ListTile(
            title: Text('السله'),
            leading: Icon(Icons.shopping_cart, color: Colors.black),
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
          ),
          if (cartItems.isEmpty)
            const EmptyData(
              emptyText: 'No items in cart',
            )
          else
            ListView.separated(
              itemCount: cartItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(thickness: 1),
              itemBuilder: (context, index) =>
                  CartBuildItem(productInCart: cartItems[index]),
            )
        ],
      );
    });
  }
}

class _AddAdditionalItems extends StatelessWidget {
  _AddAdditionalItems({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CartBlocConsumer(
      listener: (context, state) {
        if (state is ErrorAddAdditionalItem) {
          SharedMethods.showToast(
            context,
            state.error,
            color: AppColors.errorColor,
            textColor: Colors.white,
          );
        }
      },
      builder: (_, state) => Form(
        key: formKey,
        child: Column(
          children: [
            DefaultHomeTitleBuildItem(
              title: 'طلب خدمة إضافية',
              onPressed: () {},
              hasButton: false,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: DefaultFormField(
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'هذا الحقل مطلوب';
                        }
                        return null;
                      },
                      controller: controller,
                      hintText:
                          'يمكنك طلب خدمه إضافية غير موجوده داخل منتجات المورد',
                      haveBackground: true,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        CartCubit.instance(context)
                            .addAdditionalItem(controller.text);
                        controller.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 5,
                  children: CartCubit.instance(context)
                      .additionalItems
                      .map((item) => CustomChip(
                          item: item,
                          onDeleted: () {
                            CartCubit.instance(context)
                                .removeAdditionalItem(item);
                          }))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TransportationHandler extends StatelessWidget {
  const _TransportationHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CartBlocBuilder(
      buildWhen: (previous, current) => current is ToggleHasTransportationState,
      builder: (context, state) {
        final cartCubit = CartCubit.instance(context);
        return CheckboxListTile(
          value: cartCubit.hasTransportation,
          onChanged: (value) {
            cartCubit.toggleHasTransportation();
          },
          title: const Text('هل تريد خدمه النقل ؟'),
          secondary: const Icon(Icons.directions_car, color: Colors.black),
          activeColor: AppColors.successColor,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        );
      },
    );
  }
}
