import 'package:dotted_line/dotted_line.dart';
import 'package:emdad/models/transportations/transportation_supply_requests/transporter_supply_request.dart';
import 'package:emdad/modules/transporter_module/screens/transporter_delivery_orders_view/transport_process_screen.dart';
import 'package:emdad/modules/transporter_module/transporter_cubits/transporter_order_details_cubit/transporter_order_details_cubit.dart';
import 'package:emdad/modules/transporter_module/transporter_cubits/transporter_order_details_cubit/transporter_order_details_states.dart';
import 'package:emdad/modules/transporter_module/transporter_widgets/transporter_all_items.dart';
import 'package:emdad/modules/transporter_module/transporter_widgets/transporter_price_overview.dart';
import 'package:emdad/modules/user_module/order_view/order_item_build.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_buton_with_icon.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_transporter_order_list_tile.dart';
import 'package:emdad/shared/widgets/ui_componants/default_loader.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransporterOrderDetailsScreen extends StatelessWidget {
  const TransporterOrderDetailsScreen({Key? key, required this.transportId})
      : super(key: key);
  final String transportId;
  @override
  Widget build(BuildContext context) {
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
          text: 'تفاصيل الطلب',
          textStyle: primaryTextStyle().copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: const [ChangeLangWidget(color: Colors.white)],
      ),
      body: BlocProvider(
        create: (context) =>
            TrnasporterOrderDetailsCubit(transportId: transportId)
              ..getTransport(),
        child: TrnasporterOrderDetailsBlocBuilder(
          builder: (context, state) {
            final orderCubit = TrnasporterOrderDetailsCubit.instance(context);
            if (state is GetTransportLoadingState) return const DefaultLoader();
            if (state is GetTransportErrorState) {
              return NoDataWidget(
                  onPressed: () {
                    orderCubit.getTransport();
                  },
                  text: state.error);
            }
            if (orderCubit.errorInOrder) {
              return NoDataWidget(
                  onPressed: () {
                    orderCubit.getTransport();
                  },
                  text: 'حدث خطأ في الطلب برجاء المحاولة مجددا');
            }
            final order = orderCubit.order;
            final supplyRequest = order.supplyRequest;
            final vendor = supplyRequest.vendor;
            final user = supplyRequest.user;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CustomTransporterOrderListTile(
                          client: user,
                        ),
                        DottedLine(
                          direction: Axis.vertical,
                          lineLength: 60.h,
                          // dashGapLength: 5,
                          dashLength: 10.h,
                          lineThickness: 1,
                        ),
                        CustomTransporterOrderListTile(
                          client: vendor,
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    TransporterAllItemsWidget(
                      additionalItems: supplyRequest.additionalItems,
                      items: supplyRequest.requestItems,
                    ),
                    SizedBox(height: 20.h),
                    rowItem('نوع النقل', order.transportationMethod),
                    if (order.transportationOffer?.notes != null)
                      rowItem('ملاحظات', order.transportationOffer!.notes),
                    rowItem('سعر النقل',
                        order.transportationOffer!.price.toString()),
                    SizedBox(height: 20.h),
                    TransporterPriceOverview(
                      price: order.transportationOffer!.price,
                    ),
                    SizedBox(height: 40.h),
                    Align(
                      child: CustomButtonWithIcon(
                        width: 302.w,
                        height: 57.h,
                        onPressed: () {
                          navigateTo(
                              context,
                              TransportProcessScreen(
                                order: order,
                              ));
                        },
                        text: 'بدأعملية التوصيل',
                        iconData: Icons.place,
                        textStyle: thirdTextStyle().copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget rowItem(String key, String val) {
    return Column(
      children: [
        Row(
          children: [
            CustomText(
              text: key,
              textStyle: thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 10.w),
            CustomText(
              text: val,
              textAlign: TextAlign.start,
              textStyle:
                  thirdTextStyle().copyWith(fontWeight: FontWeight.normal),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
