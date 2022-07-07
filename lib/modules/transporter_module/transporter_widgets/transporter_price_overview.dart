import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_total_row_item.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/dialogs/edit_price_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransporterPriceOverview extends StatelessWidget {
  const TransporterPriceOverview(
      {Key? key, this.onPriceTap, required this.price})
      : super(key: key);
  final VoidCallback? onPriceTap;
  final double? price;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPriceTap,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        OrderTotalRowItem(
                            title: context.tr.order_cost,
                            value: SharedMethods.getPrice(price)),
                        OrderTotalRowItem(title: context.tr.tax, value: '12%'),
                      ],
                    ),
                  )),
              Expanded(
                child: Container(
                  width: 78.w,
                  color: AppColors.textButtonColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: context.tr.total,
                        textAlign: TextAlign.start,
                        textStyle: subTextStyle().copyWith(color: Colors.white),
                      ),
                      CustomText(
                        text: SharedMethods.getPrice(price == null
                                ? null
                                : (price! + price! * 12 / 100))
                            .toString(),
                        textAlign: TextAlign.start,
                        textStyle: subTextStyle().copyWith(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
