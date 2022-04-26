import 'dart:developer';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/supply_request/order_transportation_request.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_cubit.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_card_build_item.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:flutter/material.dart';

class ShippingWidget extends StatelessWidget {
  const ShippingWidget(
      {Key? key,
      required this.transportationRequest,
      required this.transportationHandler})
      : super(key: key);
  final OrderTransportationRequestModel? transportationRequest;
  final FacilityType transportationHandler;
  @override
  Widget build(BuildContext context) {
    if (transportationRequest == null) return Container();
    final transportOffer = transportationRequest!.transportationOffer;

    return Column(
      children: [
        DefaultHomeTitleBuildItem(
          title: 'النقل',
          onPressed: () {},
          hasButton: false,
        ),
        ShippingCardBuildItem(
          name: transportationRequest!.transportationMethod, // 'عربه نصف نقل',
          info: transportOffer != null ? transportOffer.notes : '',

          icon: const Icon(MyIcons.truck_thin, color: AppColors.primaryColor),
          trailing: trailingWidget(transportOffer),
        )
      ],
    );
  }

  Widget trailingWidget(TransportationOffer? transportationOffer) {
    log(transportationHandler.toString());
    if (transportationHandler == FacilityType.user) {
      return const SizedBox.shrink();
    } else if (transportationHandler == FacilityType.vendor) {
      if (transportationOffer == null) return const SizedBox.shrink();
      return Text(
        transportationOffer.price.toString(),
        style: secondaryTextStyle().copyWith(fontWeight: FontWeight.w700),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
