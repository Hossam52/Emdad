import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/modules/user_module/order_view/order_tracking/order_tracking_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackingWidget extends StatelessWidget {
  const TrackingWidget({Key? key, required this.child, required this.order})
      : super(key: key);
  final Widget child;
  final SupplyRequest order;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        child,
        Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: FloatingActionButton.extended(
            onPressed: () {
              navigateTo(
                  context,
                  OrderTrackingScreen(
                    order: order,
                  ));
            },
            label: Text(context.tr.track_the_process),
            icon: const Icon(MyIcons.track_order),
            backgroundColor: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
