import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/checkout/checkout_screen.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_card_build_item.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_componants/review_build_item.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/default_circle_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../order_view_screen.dart';

class ShippingOfferDetails extends StatelessWidget {
  const ShippingOfferDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل عرض توصيل'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              'شركه النور للنقل',
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
              imageUrl:
                  'https://media-exp1.licdn.com/dms/image/C4E0BAQG6W8dqXakgSg/company-logo_200_200/0/1519911646250?e=1643241600&v=beta&t=PnYJyb4ht9NLo9zL3t6KZr8ngN0no6smC7abRaiCFBs',
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 133.h,
            width: double.infinity,
            child: ListView.separated(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              separatorBuilder: (context, index) => const SizedBox(width: 14),
              itemBuilder: (context, index) => const ReviewBuildItem(),
            ),
          ),
          const SizedBox(height: 40),
          const ShippingCardBuildItem(
            name: 'عربه نصف نقل',
            info: 'المدة المتوقعة: 12 ساعة',
            icon: Icon(MyIcons.truck_thin, color: AppColors.primaryColor),
            price: 1150,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              onPressed: () {
                navigateTo(
                  context,
                  CheckoutScreen(onConfirmPressed: () {
                    navigateTo(
                        context,
                        const OrderViewScreen(
                          status: OrderStatus.inProgress,
                          title: 'عرض سعر جديد',
                        ));
                  }),
                );
              },
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
