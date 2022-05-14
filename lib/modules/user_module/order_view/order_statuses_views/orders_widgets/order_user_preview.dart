import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/supply_request/user_preview.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_componants/vendor_info_build_item.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';

class OrderUserPreview extends StatelessWidget {
  const OrderUserPreview({
    Key? key,
    this.trailing,
    required this.order,
    required this.displayedUser,
  }) : super(key: key);
  final Widget? trailing;
  final SupplyRequest order;
  final UserPreviewModel displayedUser;
  @override
  Widget build(BuildContext context) {
    return VendorInfoBuildItem(
      city: displayedUser.city,
      name: displayedUser.name,
      logoUrl: displayedUser.logoUrl,
      // vendorType: vendor.,
      isCart: true,
      tailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          orderWithAdditionalItem(),
          const SizedBox(width: 13),
          orderWithTransport(),
          if (trailing != null) const Spacer(),
          if (trailing != null)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: trailing,
            ),
        ],
      ),
    );
  }

  Widget orderWithAdditionalItem() {
    if (order.additionalItems.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(MyIcons.add_drive, color: Colors.white),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget orderWithTransport() {
    if (order.hasTransportation) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(MyIcons.truck_thin, color: Colors.white, size: 20),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
