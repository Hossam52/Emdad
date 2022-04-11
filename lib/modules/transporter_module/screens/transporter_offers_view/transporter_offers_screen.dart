import 'package:emdad/modules/transporter_module/screens/transporter_offers_view/transporter_offer_details_screen.dart';
import 'package:emdad/modules/user_module/offers_module/title_with_filter_build_item.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/responsive/responsive_widget.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransporterOffersScreen extends StatelessWidget {
  const TransporterOffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return responsiveWidget(
      responsive: (context, deviceInfo) => SingleChildScrollView(
        child: Column(
          children: [
            const TitleWithFilterBuildItem(title: 'عروض اسعار'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              itemBuilder: (context, index) => OrderBuildItem1(
                title: 'الرحمة للمأكولات',
                image: 'https://upload.wikimedia.org/wikipedia/sco/thumb/b/bf/KFC_logo.svg/1200px-KFC_logo.svg.png',
                hasBadge: true,
                onTap: () {
                  navigateTo(context, TransporterOfferDetailsScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class OrderBuildItem1 extends StatelessWidget {
  OrderBuildItem1({
    Key? key,
    required this.hasBadge,
    required this.onTap,
    required this.title,
    required this.image,
    this.trailing,
  }) : super(key: key);

  final bool hasBadge;
  final Function() onTap;
  final String title;
  final String image;
  Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(bottom: 20),
      shadowColor: Colors.black.withOpacity(0.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 53.w,
                height: 53.w,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: DefaultCachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 13.5.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: thirdTextStyle().copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      '12-2-2020',
                      style: subTextStyle(),
                    ),
                    Text(
                      'من : الرياض',
                      style: thirdTextStyle(),
                    ),
                    Text(
                      'الي : العنوان بالتفصيل',
                      style: thirdTextStyle(),
                    ),
                  ],
                ),
              ),
              RawMaterialButton(
                onPressed: () {},
                child: const Icon(Icons.arrow_forward_ios, size: 12),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                constraints: const BoxConstraints(minWidth: 0),
                padding: const EdgeInsets.all(6),
                fillColor: Colors.white54,
                shape: const CircleBorder(),
                elevation: 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
