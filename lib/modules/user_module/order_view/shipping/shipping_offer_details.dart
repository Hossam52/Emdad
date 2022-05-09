import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/models/transportations/transportation_offer_model.dart';
import 'package:emdad/modules/user_module/checkout/checkout_screen.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/order_in_progress_screen.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_card_build_item.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_componants/review_build_item.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/default_circle_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../order_view_screen.dart';

class ShippingOfferDetails extends StatelessWidget {
  const ShippingOfferDetails(
      {Key? key, this.transportationOffer, required this.onAcceptOffer})
      : super(key: key);
  final TransportationOfferModel? transportationOffer;
  final VoidCallback onAcceptOffer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل عرض توصيل'),
        actions: const [ChangeLangWidget(color: Colors.black)],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              transportationOffer!.transporter.oraganizationName,
              style: thirdTextStyle().copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            subtitle: Text(
              'عبارة عن شركة لنقل جميع المنتجات التجارية جميع الاحجام وخصم خاص للكميات',
              style: subTextStyle(),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
            isThreeLine: true,
            leading: DefaultCircleImage(
                width: 60.w,
                height: 60.h,
                imageUrl: transportationOffer!.transporter.logo
                // 'https://media-exp1.licdn.com/dms/image/C4E0BAQG6W8dqXakgSg/company-logo_200_200/0/1519911646250?e=1643241600&v=beta&t=PnYJyb4ht9NLo9zL3t6KZr8ngN0no6smC7abRaiCFBs',
                ),
          ),
          const SizedBox(height: 15),
          ShippingCardBuildItem(
            name:
                transportationOffer!.transportationRequest.transportationMethod,
            info: 'المدة المتوقعة: 12 ساعة',
            icon: const Icon(MyIcons.truck_thin, color: AppColors.primaryColor),
            trailing: Text(transportationOffer!.price.toString(),
                style:
                    secondaryTextStyle().copyWith(fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              onPressed: onAcceptOffer,
              text: 'قبول عرض السعر',
              width: MediaQuery.of(context).size.width * 0.6,
              radius: 10,
            ),
          ),
        ],
      ),
    );
  }
}
