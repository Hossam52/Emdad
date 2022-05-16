import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/transportations/transportation_supply_requests/transporter_supply_request.dart';
import 'package:emdad/modules/user_module/my_orders/orders_build_item.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransporterOrderItemPreview extends StatelessWidget {
  const TransporterOrderItemPreview({
    Key? key,
    required this.onTap,
    required this.order,
  }) : super(key: key);

  final Function() onTap;
  final TransporterSupplyRequest order;
  @override
  Widget build(BuildContext context) {
    final user = order.supplyRequest.user;
    final vendor = order.supplyRequest.vendor;
    final from =
        order.supplyRequest.isUser ? user.detailAddress : vendor.detailAddress;
    final to =
        order.supplyRequest.isUser ? vendor.detailAddress : user.detailAddress;
    return OrderBuildItem(
      hasBadge: false,
      onTap: onTap,
      title: order.requester.oraganizationName,
      image: order.requester.logo,
      date: order.createdAt,
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'من : $from',
            style: thirdTextStyle(),
          ),
          Text(
            'الي : $to',
            style: thirdTextStyle(),
          ),
        ],
      ),
    );
    // return Card(
    //   elevation: 6,
    //   clipBehavior: Clip.antiAliasWithSaveLayer,
    //   margin: const EdgeInsets.only(bottom: 20),
    //   shadowColor: Colors.black.withOpacity(0.6),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //   child: InkWell(
    //     onTap: onTap,
    //     child: Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: Row(
    //         children: [
    //           Container(
    //             width: 53.w,
    //             height: 53.w,
    //             clipBehavior: Clip.antiAliasWithSaveLayer,
    //             decoration: const BoxDecoration(
    //               shape: BoxShape.circle,
    //             ),
    //             child: DefaultCachedNetworkImage(
    //               imageUrl: image,
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //           SizedBox(width: 13.5.w),
    //           Expanded(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   title,
    //                   style: thirdTextStyle().copyWith(
    //                     fontWeight: FontWeight.w700,
    //                     color: AppColors.primaryColor,
    //                   ),
    //                 ),
    //                 Text(
    //                   '12-2-2020',
    //                   style: subTextStyle(),
    //                 ),
    //                 Text(
    //                   'من : الرياض',
    //                   style: thirdTextStyle(),
    //                 ),
    //                 Text(
    //                   'الي : العنوان بالتفصيل',
    //                   style: thirdTextStyle(),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           RawMaterialButton(
    //             onPressed: () {},
    //             child: const Icon(Icons.arrow_forward_ios, size: 12),
    //             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //             constraints: const BoxConstraints(minWidth: 0),
    //             padding: const EdgeInsets.all(6),
    //             fillColor: Colors.white54,
    //             shape: const CircleBorder(),
    //             elevation: 0.1,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
