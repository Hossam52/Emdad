import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_total_row_item.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorTotalPrice extends StatelessWidget {
  const VendorTotalPrice({Key? key, required this.order}) : super(key: key);
  final SupplyRequest order;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultHomeTitleBuildItem(
          title: 'إجمالي',
          onPressed: () {},
          hasButton: false,
        ),
        Card(
            elevation: 3,
            color: Colors.grey[100],
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        OrderTotalRowItem(
                            title: 'السعر الصافي',
                            value: !order.vendorProvidePriceOffer
                                ? 'السعر لم يحدد بعد'
                                : order.orderItemsPrice.toInt().toString()),
                        const SizedBox(height: 10),
                        if (order.transportationHandlerEnum ==
                            FacilityType.vendor)
                          OrderTotalRowItem(
                              title: 'الشحن',
                              value: SharedMethods.getPrice(
                                  order.transportationPrice)),
                        const SizedBox(height: 10),
                        const OrderTotalRowItem(title: 'الضريبة', value: '١٢٪'),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 103.w,
                    height: 63.h,
                    color: AppColors.textButtonColor,
                    child: FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('إجمالي',
                              style: subTextStyle().copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          SizedBox(height: 10.h),
                          Text(SharedMethods.getPrice(order.totalOrderPrice),
                              style:
                                  subTextStyle().copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
