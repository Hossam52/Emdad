import 'dart:developer';

import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/supply_request/supply_request_change_log_model.dart';
import 'package:emdad/modules/user_module/order_view/order_tracking/tracking_list_tile.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:flutter/material.dart';

import 'tracking_line_dotes.dart';
import 'tracking_step_build_item.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({Key? key, required this.order}) : super(key: key);
  final SupplyRequest order;
  @override
  Widget build(BuildContext context) {
    final statusLog = order.statusChangeLog;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.order_status),
        actions: const [
          ChangeLangWidget(
            color: Colors.black,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TrackingListTile(
                      name: order.user.oraganizationName,
                      type: TrackingType.source,
                    ),
                    const TrackingLineDotes(),
                    const TrackingLineDotes(height: 16),
                    const TrackingLineDotes(),
                    TrackingListTile(
                      name: order.vendor.oraganizationName,
                      type: TrackingType.destination,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                context.tr.delivery_status,
                style: thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
              ),
              TrackingStepBuildItem(
                items: [
                  TrackingStatusItem(
                    title: context.tr.send_price_offer,
                    dateString: statusLog?.awaitingQuotation,
                    icon: MyIcons.contact_request,
                  ),
                  TrackingStatusItem(
                    title: context.tr.accept_order,
                    dateString: statusLog?.awaitingApproval,
                    icon: MyIcons.accept,
                  ),
                  TrackingStatusItem(
                    title: context.tr.prepare_order,
                    dateString: statusLog?.preparing,
                    icon: MyIcons.settings,
                  ),
                  TrackingStatusItem(
                    title: context.tr.arrived_pickup_location,
                    dateString: statusLog?.awaitingTransportation,
                    icon: MyIcons.shipping,
                  ),
                  TrackingStatusItem(
                    title: context.tr.arrived_delivery_location,
                    dateString: statusLog?.onWay,
                    icon: MyIcons.shipping,
                  ),
                  TrackingStatusItem(
                    title: context.tr.confirm_end_process,
                    dateString: statusLog?.delivered,
                    icon: Icons.check_circle_rounded,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
