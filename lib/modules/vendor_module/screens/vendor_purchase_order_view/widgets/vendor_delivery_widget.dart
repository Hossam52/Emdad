import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/vendor_order_cubit/vendor_order_cubit.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/vendor_order_cubit/vendor_order_states.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_shipping_offers/vendor_shipping_offers.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_checkbox.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:emdad/shared/widgets/dialogs/request_transform_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VendorDeliveryWidget extends StatelessWidget {
  const VendorDeliveryWidget({Key? key, this.onEditPrice, required this.order})
      : super(key: key);
  final SupplyRequest order;
  final VoidCallback? onEditPrice;
  @override
  Widget build(BuildContext context) {
    if (order.isUser) {
      return const SizedBox.shrink();
    }
    if (order.transportationRequest == null) {
      return _AddTransportationRequest(
        order: order,
        onEditPrice: onEditPrice,
      );
    } else if (order.transportationRequest!.transportationOffer == null) {
      return _TransportationRequest(order: order);
    } else {
      return _TransportationOffer(
        order: order,
        onEditPrice: onEditPrice,
      );
    }
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget(
      {Key? key, required this.child, this.onEditPrice, this.prefixWidget})
      : super(key: key);
  final Widget child;
  final Widget? prefixWidget;
  final VoidCallback? onEditPrice;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DefaultHomeTitleBuildItem(
        title: 'التوصيل',
        onPressed: () {},
        hasButton: false,
      ),
      if (prefixWidget != null) prefixWidget!,
      InkWell(
        onTap: onEditPrice,
        child: Card(
          elevation: 3,
          color: Colors.grey[100],
          margin: const EdgeInsets.all(16),
          child: Padding(padding: const EdgeInsets.all(16.0), child: child),
        ),
      )
    ]);
  }
}

class _AddTransportationRequest extends StatelessWidget {
  const _AddTransportationRequest(
      {Key? key, required this.order, required this.onEditPrice})
      : super(key: key);
  final SupplyRequest order;
  final VoidCallback? onEditPrice;
  @override
  Widget build(BuildContext context) {
    return VendorOrderBlocBuilder(
      buildWhen: (previous, current) =>
          current is ChangeVendorManageTransportationState,
      builder: (context, state) {
        final vendorOrderCubit = VendorOrderCubit.instance(context);
        return _CardWidget(
          onEditPrice:
              vendorOrderCubit.vendorManageTransport ? onEditPrice : null,
          prefixWidget: order.hasTransportation // order.vendorProvidePriceOffer
              ? null
              : ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  onTap: () {
                    vendorOrderCubit.changeVendorManageTransport();
                  },
                  title: Text('هل لديك توصيل خاص؟', style: thirdTextStyle()),
                  trailing: CustomCheckbox(
                    isChecked: vendorOrderCubit.vendorManageTransport,
                    onChange: vendorOrderCubit.changeVendorManageTransport,
                  ),
                ),
          child: Builder(builder: (context) {
            if (vendorOrderCubit.vendorManageTransport) {
              return _VendorHandleTransport(
                  onEditPrice: onEditPrice, order: order);
            }
            return Column(
              children: [
                Row(
                  children: [
                    const Text('لم يتم طلب شركة نقل حتي الان'),
                    const Spacer(),
                    TextButton(
                        onPressed: () async {
                          await showDialog<bool>(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: VendorOrderCubit.instance(context),
                              child: VendorOrderBlocConsumer(
                                listener: (context, state) {
                                  if (state
                                      is CreateVendorTransportationRequestErrorState) {
                                    SharedMethods.showToast(
                                        context, state.error,
                                        color: AppColors.errorColor,
                                        textColor: Colors.white);
                                  }
                                  if (state
                                      is CreateVendorTransportationRequestSuccessState) {
                                    Navigator.pop(context, true);
                                  }
                                },
                                builder: (context, orderState) {
                                  return RequestTransformDialog(
                                    isLoading: orderState
                                        is CreateVendorTransportationRequestLoadingState,
                                    onCreateTransportRequest: (
                                        {required String city,
                                        required String transportationMethod}) {
                                      VendorOrderCubit.instance(context)
                                          .createVendorTransportationRequest(
                                              city: city,
                                              transportationMethod:
                                                  transportationMethod);
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        child: const Text('طلب شركة نقل')),
                  ],
                ),
              ],
            );
          }),
        );
      },
    );
  }
}

class _TransportationRequest extends StatelessWidget {
  const _TransportationRequest(
      {Key? key, required this.order, this.onEditPrice})
      : super(key: key);
  final SupplyRequest order;
  final VoidCallback? onEditPrice;
  @override
  Widget build(BuildContext context) {
    final transportationRequest = order.transportationRequest!;
    return _CardWidget(
      onEditPrice: onEditPrice,
      child: Column(
        children: [
          _rowItem('وسيلة النقل المطلوبة',
              transportationRequest.transportationMethod),
          _CostForRequester(order: order),
          TextButton(
              onPressed: () {
                navigateTo(
                    context,
                    VendorShippingOffersScreen(
                      orderCubit: VendorOrderCubit.instance(context),
                      transportationRequestId: transportationRequest.id,
                    ));
              },
              child: const Text('عروض النقل')),
        ],
      ),
    );
  }
}

class _TransportationOffer extends StatelessWidget {
  const _TransportationOffer({Key? key, required this.order, this.onEditPrice})
      : super(key: key);
  final SupplyRequest order;
  final VoidCallback? onEditPrice;
  @override
  Widget build(BuildContext context) {
    return _CardWidget(
      onEditPrice: onEditPrice,
      child: Column(
        children: [
          _rowItem(
              'وسيلة النقل', order.transportationRequest!.transportationMethod),
          _rowItem(
            'عرض سعر شركة النقل',
            order.transportationRequest!.transportationOffer!.price.toString(),
          ),
          const Divider(),
          _CostForRequester(order: order),
        ],
      ),
    );
  }
}

class _CostForRequester extends StatelessWidget {
  const _CostForRequester({Key? key, required this.order}) : super(key: key);
  final SupplyRequest order;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _rowItem('تكلفة الطلب للمستخدم',
            SharedMethods.getPrice(order.transportationPrice)),
        _rowItem('الضريبة', '12%'),
      ],
    );
  }
}

class _VendorHandleTransport extends StatelessWidget {
  const _VendorHandleTransport(
      {Key? key, required this.onEditPrice, required this.order})
      : super(key: key);
  final VoidCallback? onEditPrice;
  final SupplyRequest order;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _rowItem('تكلفة الطلب للمستخدم',
            SharedMethods.getPrice(order.transportationPrice)),
        _rowItem('الضريبة', '12%'),
      ],
    );
  }
}

Widget _rowItem(String title, String value) {
  return Row(
    children: [
      Text(title,
          style: subTextStyle().copyWith(color: AppColors.primaryColor)),
      const Spacer(),
      Text(value,
          style: thirdTextStyle().copyWith(fontWeight: FontWeight.w700)),
    ],
  );
}
