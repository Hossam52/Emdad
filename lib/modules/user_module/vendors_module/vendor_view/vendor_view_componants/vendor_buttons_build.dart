import 'dart:developer';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/users/user/user_response_model.dart';
import 'package:emdad/modules/map_module/screens/map_screen.dart';
import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_cubit.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_buton_with_icon.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_icon_button.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:emdad/shared/widgets/ui_componants/default_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorButtonsBuild extends StatelessWidget {
  const VendorButtonsBuild({
    Key? key,
    required this.vendor,
  }) : super(key: key);
  final User vendor;
  @override
  Widget build(BuildContext context) {
    log(vendor.isFavourite.toString());
    return Row(
      children: [
        CustomIconButton(
          onPressed: () {
            navigateTo(
                context,
                MapScreen(
                  lat: vendor.locationObject!.lat,
                  lng: vendor.locationObject!.lng,
                  screenTitle: '${vendor.name} Location',
                  locationName:
                      'this is location of vendor ${vendor.name} with organization ${vendor.organizationName}',
                ));
          },
          width: 32.w,
          height: 32.h,
          icon: const Icon(MyIcons.map_pin_fill,
              size: 18, color: AppColors.primaryColor),
        ),
        SizedBox(width: 20.w),
        CustomIconButton(
          onPressed: () {
            VendorProfileCubit.instance(context).toggleFavorite(context);
            vendor.isFavourite = !vendor.isFavourite!;
          },
          width: 32.w,
          height: 32.h,
          icon: Icon(vendor.isFavourite! ? Icons.star : Icons.star_border,
              size: 21, color: AppColors.thirdColor),
        ),
        SizedBox(width: 20.w),
        CustomIconButton(
          width: 32.w,
          height: 32.h,
          onPressed: () {
            showDialog(
                context: context, builder: (context) => const VenderReport());
          },
          icon: const Icon(Icons.do_disturb_on,
              size: 21, color: AppColors.errorColor),
        ),
      ],
    );
  }
}

class VenderReport extends StatelessWidget {
  const VenderReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text('الابلاغ عن مورد'),
            // const SizedBox(height: 10),
            DefaultDropDown(
                elevation: 4,
                label: 'تصنيف المشكلة',
                backgroundColor: Colors.white,
                selectedValue: 'تأخير',
                onChanged: (val) {},
                validator: (val) {},
                items: const [
                  'تأخير',
                  'منتجات رديئة',
                  'أسلوب غير لائق',
                ]),
            SizedBox(
              height: SharedMethods.getHeightFraction(context, 0.03),
            ),
            CustomTextFormField(
              type: TextInputType.text,
              hasBorder: true,
              borderRadius: 10,
              minLines: 4,
              maxLines: 4,
              hint: 'ما هي المشكلة؟',
              contentPadding: const EdgeInsets.all(4),
              validation: (str) {
                return null;
              },
              titleText: ' وصف المشكلة',
            ),

            SizedBox(
              height: SharedMethods.getHeightFraction(context, 0.03),
            ),
            CustomButton(
              text: 'ابلاغ',
              onPressed: () {
                Navigator.pop(context);
                showSnackBar(
                  context: context,
                  text: 'تم الابلاغ عن المورد',
                  snackBarStates: SnackBarStates.success,
                );
              },
            ),
            SizedBox(
              height: SharedMethods.getHeightFraction(context, 0.03),
            ),

            CustomButtonWithIcon(
              text: 'إتصل بنا',
              iconData: Icons.call,
              color: AppColors.successColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
