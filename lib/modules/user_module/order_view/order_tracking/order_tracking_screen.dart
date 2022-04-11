import 'package:emdad/modules/user_module/order_view/order_tracking/tracking_list_tile.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

import 'tracking_line_dotes.dart';
import 'tracking_step_build_item.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حالة الطلب'),
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
                  children: const [
                    TrackingListTile(
                      name: 'الهدي لتوريدات الغذائية',
                      type: TrackingType.source,
                    ),
                    TrackingLineDotes(),
                    TrackingLineDotes(height: 16),
                    TrackingLineDotes(),
                    TrackingListTile(
                      name: 'مطعم كنتاكي ',
                      type: TrackingType.destination,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'حالة التوصيل',
                style: thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
              ),
              TrackingStepBuildItem(
                count: 6,
                currentStep: 2,
                icons: const [
                  MyIcons.contact_request,
                  MyIcons.accept,
                  MyIcons.settings,
                  MyIcons.shipping,
                  MyIcons.shipping,
                  Icons.check_circle_rounded,
                ],
                title: const [
                  'إرسال عرض سعر',
                  'قبول الطلب',
                  'تجهيز الطلب',
                  'وصلت نقطة الالتقاط',
                  'وصلت نقطة التوصيل',
                  'تأكيد انتهاء العملية',
                ],
                subtitle: List.generate(6, (index) => '2021-12-06'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
