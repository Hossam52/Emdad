import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_componants/vendor_info_build_item.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';

class OrderVendorInfo extends StatelessWidget {
  const OrderVendorInfo({Key? key, this.trailing}) : super(key: key);
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return VendorInfoBuildItem(
      isCart: true,
      tailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(MyIcons.add_drive, color: Colors.white),
          ),
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

          // const SizedBox(width: 13),
          // Container(
          //   padding: const EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //     color: AppColors.secondaryColor,
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child:
          //       const Icon(MyIcons.truck_thin, color: Colors.white, size: 20),
          // ),
        ],
      ),
    );
  }
}
