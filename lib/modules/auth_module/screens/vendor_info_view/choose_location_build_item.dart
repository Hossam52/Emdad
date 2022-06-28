import 'dart:developer';

import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/location_picker/location_picker_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:open_location_picker/open_location_picker.dart';

class ChooseLocationBuildItem extends StatelessWidget {
  ChooseLocationBuildItem({Key? key, required this.cubit}) : super(key: key);

  final AuthCubit cubit;
  final Location location = Location();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return OpenMapPicker(
        initialValue: cubit.selectedLocationTest,
        validator: (location) {
          if (location == null) return 'يجب اختيار الموقع الخاص بك';
          return null;
        },
        decoration: const InputDecoration(
          hintText: "اختر الموقع علي الخريطة",
          prefixIcon: Icon(
            Icons.place,
            color: AppColors.textButtonColor,
          ),
        ),
        expands: false,
        onChanged: (newValue) {
          log((newValue?.toLatLng()).toString());
          cubit.selectedLocationTest = newValue;
        },
      );
    });
    return InkWell(
      onTap: () {
        navigateTo(context, LocationPickerScreen(authCubit: cubit));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/map.jpg',
              width: double.infinity,
              height: 125.h,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'اختر الموقع علي الخريطة',
                      style: thirdTextStyle().copyWith(
                        color: AppColors.textButtonColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    const Icon(
                      Icons.place,
                      color: AppColors.textButtonColor,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TestSettings extends StatelessWidget {
  const _TestSettings({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return OpenMapSettings(
        searchFilters: SearchFilters(countryCodes: ['eg']),
        defaultOptions: OpenMapOptions(
          center: LatLng(0, 0),
          zoom: 0,
        ),
        searchHint: (_) => 'HELO',
        // getLocationStream: () => location.onLocationChanged.map((event) {
        //       log('sts');
        //       return LatLng(event.latitude!, event.longitude!);
        //     }),
        child: child);
  }
}
