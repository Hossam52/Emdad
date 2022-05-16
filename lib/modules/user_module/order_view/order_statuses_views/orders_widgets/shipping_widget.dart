import 'dart:developer';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/supply_request/order_transportation_request.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_cubit.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_states.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_card_build_item.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_offers_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:emdad/shared/widgets/dialogs/request_transform_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShippingWidget extends StatelessWidget {
  const ShippingWidget({Key? key, required this.order}) : super(key: key);
  final SupplyRequest order;
  @override
  Widget build(BuildContext context) {
    // final transportationRequest = order.transportationRequest;
    // final transportationHandler = order.transportationHandlerEnum;
    // if (transportationRequest == null) return Container();
    // final transportOffer = transportationRequest.transportationOffer;

    return Column(
      children: [
        DefaultHomeTitleBuildItem(
          title: 'النقل',
          onPressed: () {},
          hasButton: false,
        ),
        _Transportation(order: order),
        // ShippingCardBuildItem(
        //   name: transportationRequest.transportationMethod, // 'عربه نصف نقل',
        //   info: transportOffer != null ? transportOffer.notes : '',

        //   icon: const Icon(MyIcons.truck_thin, color: AppColors.primaryColor),
        //   trailing: trailingWidget(transportationHandler, transportOffer),
        // )
      ],
    );
  }
}

class _Transportation extends StatelessWidget {
  const _Transportation({Key? key, required this.order}) : super(key: key);
  final SupplyRequest order;
  @override
  Widget build(BuildContext context) {
    if (order.isVendor) {
      return _VendorHandleTransport(order: order);
    }
    return _CardWidget(
      child: Builder(builder: (context) {
        log(order.transportationHandler);

        if (order.transportationRequest == null) {
          return _AddTransportationRequest(order: order);
        }
        if (order.transportationRequest!.transportationOffer == null) {
          return _TransportationRequest(
              transportationRequest: order.transportationRequest!);
        }

        return _TransportationOffer(order: order);
      }),
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        color: Colors.grey.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }
}

class _AddTransportationRequest extends StatelessWidget {
  const _AddTransportationRequest({Key? key, required this.order})
      : super(key: key);
  final SupplyRequest order;
  @override
  Widget build(BuildContext context) {
    if (!order.isPayed) {
      return const Text('لا يمكنك طلب وسيلة نقل الان حتي يتم الدفع');
    }
    return OrderBlocConsumer(
      listener: (context, state) {
        if (state is CreateTransportRequestErrorState) {
          Navigator.pop(context);

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                const Text('لم يتم طلب شركة نقل حتي الان'),
                const Spacer(),
                TextButton(
                    onPressed: () async {
                      if (!order.isPayed) {
                        SharedMethods.showToast(
                            context, 'يجب الدفع قبل طلب شركة نقل',
                            textColor: Colors.white,
                            color: AppColors.errorColor);
                        return;
                      }
                      await showDialog<bool>(
                          context: context,
                          builder: (_) {
                            return RequestTransformDialog(
                              onCreateTransportRequest: (
                                  {required String city,
                                  required String transportationMethod}) {
                                OrderCubit.instance(context)
                                    .createTransportRequest(
                                        transportationMethod:
                                            transportationMethod,
                                        city: city);
                              },
                              isLoading: false,
                            );
                          });
                    },
                    child: const Text('طلب شركة نقل')),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _TransportationRequest extends StatelessWidget {
  const _TransportationRequest({Key? key, required this.transportationRequest})
      : super(key: key);
  final OrderTransportationRequestModel transportationRequest;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _rowItem('وسيلة النقل', transportationRequest.transportationMethod),
        TextButton(
            onPressed: () {
              navigateTo(
                  context,
                  ShippingOffersScreen(
                    orderCubit: OrderCubit.instance(context),
                    transportationRequestId: transportationRequest.id,
                  )
                  // VendorShippingOffersScreen(
                  //   orderCubit: VendorOrderCubit.instance(context),
                  //   transportationRequestId: transportationRequest.id,
                  // )
                  );
            },
            child: const Text('عروض النقل')),
      ],
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
    return Column(
      children: [
        _rowItem(
            'وسيلة النقل', order.transportationRequest!.transportationMethod),
        _rowItem(
          'عرض سعر شركة النقل',
          order.transportationRequest!.transportationOffer!.price.toString(),
        ),
      ],
    );
  }
}

class _UserHandleTransport extends StatelessWidget {
  const _UserHandleTransport({Key? key, required this.order}) : super(key: key);
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
  const _VendorHandleTransport({Key? key, required this.order})
      : super(key: key);
  final SupplyRequest order;
  @override
  Widget build(BuildContext context) {
    if (!order.hasTransportation) {
      if (order.vendorProvidePriceOffer) {
        return ShippingCardBuildItem(
          name: 'سوف يقوم المورد بعملية النقل', // 'عربه نصف نقل',
          info: 'سعر النقل ${order.transportationPrice}',

          icon: const Icon(MyIcons.truck_thin, color: AppColors.primaryColor),
          trailing: const SizedBox.shrink(),
        );
      }
      return const ShippingCardBuildItem(
        name: 'لم يتم طلب وسيلة نقل من المورد الي الان', // 'عربه نصف نقل',
        info: '',

        icon: Icon(MyIcons.truck_thin, color: AppColors.errorColor),
        trailing: SizedBox.shrink(),
        borderColor: AppColors.errorColor,
      );
    }

    final transportationRequest = order.transportationRequest!;
    final transportOffer = transportationRequest.transportationOffer;

    if (transportOffer != null) {
      return ShippingCardBuildItem(
        name: transportationRequest.transportationMethod, // 'عربه نصف نقل',
        info: transportOffer.notes,

        icon: const Icon(MyIcons.truck_thin, color: AppColors.primaryColor),
        trailing: trailingWidget(transportOffer),
      );
    }
    return ShippingCardBuildItem(
      name: transportationRequest.transportationMethod, // 'عربه نصف نقل',
      // info: 'لم يتم قبول عرض وسيلة النقل من المورد',
      info: 'تم طلب وسيلة نقل من قبل المورد',

      icon: const Icon(MyIcons.truck_thin),
      trailing: Text(order.transportationPrice.toString()),
    );
  }

  Widget trailingWidget(TransportationOffer? transportationOffer) {
    // if (transportationOffer != null) {
    //   return const Text('لم يتم قبول عرض وسيلة النقل من المورد');
    // }
    return Text(
      transportationOffer!.price.toString(),
      style: secondaryTextStyle().copyWith(fontWeight: FontWeight.w700),
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
