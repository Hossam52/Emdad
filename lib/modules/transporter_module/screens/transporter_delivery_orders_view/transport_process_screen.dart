import 'package:emdad/layout/transporter_layout/transporter_layout.dart';
import 'package:emdad/models/transportations/transportation_supply_requests/transporter_supply_request.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_transporter_order_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransportProcessScreen extends StatefulWidget {
  const TransportProcessScreen({Key? key, required this.order})
      : super(key: key);
  final TransporterSupplyRequest order;
  @override
  State<TransportProcessScreen> createState() => _TransportProcessScreenState();
}

class _TransportProcessScreenState extends State<TransportProcessScreen> {
  int initialProcessValue = 0;
  @override
  void initState() {
    super.initState();
    initialProcessValue = 0;
  }

  @override
  Widget build(BuildContext context) {
    final supplyRequest = widget.order.supplyRequest;
    final user = supplyRequest.user;
    final vendor = supplyRequest.vendor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15.r),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: CustomText(
          text: context.tr.delivery_process,
          textStyle: primaryTextStyle().copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: const [ChangeLangWidget(color: Colors.white)],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            CustomTransporterOrderListTile(client: user),
            SizedBox(height: 40.h),
            _DeliveryButton(
              title: context.tr.arrived_pickup_location,
              onPressed: () {
                setState(() {
                  initialProcessValue++;
                  print(initialProcessValue);
                });
              },
              displayWithSuccess: initialProcessValue <= 0,
            ),
            SizedBox(height: 30.h),
            CustomTransporterOrderListTile(client: vendor),
            SizedBox(height: 30.h),
            _DeliveryButton(
              title: context.tr.arrived_delivery_location,
              displayWithSuccess: initialProcessValue <= 1,
              onPressed: () {
                setState(() {
                  initialProcessValue++;
                  print(initialProcessValue);
                });
              },
            ),
            SizedBox(height: 50.h),
            CustomButton(
              width: 170.w,
              text: context.tr.confirm_end_process,
              backgroundColor: Colors.red,
              textStyle: thirdTextStyle()
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (ctx) => const _Dialog(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DeliveryButton extends StatelessWidget {
  const _DeliveryButton(
      {Key? key,
      required this.title,
      this.onPressed,
      required this.displayWithSuccess})
      : super(key: key);
  final String title;
  final VoidCallback? onPressed;
  final bool displayWithSuccess;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: displayWithSuccess
          ? CustomButton(
              width: 280.w,
              text: title,
              textStyle: thirdTextStyle()
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
              onPressed: onPressed)
          : Stack(
              alignment: Alignment.centerLeft,
              children: [
                CustomButton(
                  width: 280.w,
                  text: title,
                  textStyle: thirdTextStyle().copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                  onPressed: () {},
                  backgroundColor: AppColors.textButtonColor.withOpacity(0.5),
                ),
                Container(
                  width: 40.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: const Color(0xff1CAF17),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: CustomText(
          text: context.tr.done_delivery,
          textStyle: thirdTextStyle().copyWith(fontWeight: FontWeight.w500),
        ),
        content: CircleAvatar(
          radius: 40.r,
          backgroundColor: const Color(0xff39AA2D),
          child: const Icon(Icons.check, color: Colors.white),
        ),
        actions: <Widget>[
          CustomButton(
            width: 215.w,
            text: context.tr.close,
            backgroundColor: Colors.red,
            textStyle: thirdTextStyle()
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            onPressed: () {
              Navigator.of(context).pop(true);
              navigateToAndFinish(context, const TransporterLayout());
            },
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
