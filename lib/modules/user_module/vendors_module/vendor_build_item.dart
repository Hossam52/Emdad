import 'package:emdad/models/users/user/user_response_model.dart';
import 'package:emdad/modules/user_module/home_module/user_home_cubit/user_home_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/widgets/default_circle_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emdad/shared/styles/font_styles.dart';

import 'vendor_view/vendor_view_componants/location_build_item.dart';

class VendorBuildItem extends StatelessWidget {
  const VendorBuildItem({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(bottom: 20),
      shadowColor: Colors.black.withOpacity(0.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          navigateTo(
              context,
              BlocProvider.value(
                value: UserHomeCubit.instance(context),
                child: VendorViewScreen(
                  title: user.name!,
                  vendorId: user.id!, //Need to edit
                ),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              DefaultCircleImage(
                width: 53.w,
                height: 53.w,
                imageUrl: user.logoUrl!,
              ),
              SizedBox(width: 13.5.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.organizationName!,
                      // 'الرحمه للمواد الغذائية',
                      style: thirdTextStyle().copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    LocationBuildItem(location: user.city!),
                    Text(
                      user.allVendorTypeString,
                      style: subTextStyle(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
