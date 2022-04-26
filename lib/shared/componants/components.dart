import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/modules/user_module/checkout/checkout_screen.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_offers_screen.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/dialogs/confirm_order_dialog.dart';
import 'package:emdad/shared/widgets/custom_buton_with_icon.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/dialogs/request_transform_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'icons/my_icons_icons.dart';

Future<T> navigateTo<T>(BuildContext context, Widget widget) async =>
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

Future<void> showAppFilter({
  required BuildContext context,
  required Widget filterItem,
  required Function() onSearch,
  required Function() onDelete,
}) =>
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      )),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('تصفية حسب'),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: filterItem,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CustomButton(
                  onPressed: onDelete,
                  text: 'مسح الكل',
                  width: 75,
                  // height: 35,
                  backgroundColor: AppColors.errorColor,
                ),
                const Spacer(),
                CustomButton(
                  onPressed: onSearch,
                  text: 'بحث',
                  width: 75,
                  // height: 35,
                ),
              ],
            ),
          ],
        ),
      ),
    );

Future<bool?> showOrderConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => const ConfirmOrderDialog(),
  );
}

Widget buildModalSheetTransporterItem({
  required BuildContext context,
  required String title,
}) {
  return SizedBox(
    height: 400.h,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20.h),
          ListTile(
            leading: CustomText(
              text: 'سعر النقل',
              textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
            ),
            title: SizedBox(
              width: 100.w,
              child: buildTextFormField(
                controller: null,
                onChanged: (String? value) {},
                onSubmitted: (String? value) {},
              ),
            ),
            trailing: SizedBox(
              width: 100.w,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CustomText(
                          text: 'الضريبة',
                          textStyle: subTextStyle()
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        CustomText(
                          text: '١٥٪',
                          textStyle: subTextStyle()
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CustomText(
                          text: 'إجمالي',
                          textStyle: subTextStyle()
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        CustomText(
                          text: '١٨٤٠',
                          textStyle: subTextStyle()
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.h),
          SizedBox(height: 30.h),
          Align(
            child: CustomButton(
              height: 60.h,
              backgroundColor: AppColors.textButtonColor,
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'تأكيد',
              radius: 4.r,
            ),
          ),
          SizedBox(height: 20.h),
          Align(
            child: CustomButtonWithIcon(
              height: 60.h,
              color: AppColors.primaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'طلب شركة نقل',
              radius: 4.r,
              iconData: MyIcons.truck_thin,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildModalSheetItem({
  required BuildContext context,
  required String title,
  required bool isOutList,
}) {
  return SizedBox(
    height: 400.h,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20.h),
          if (!isOutList)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'كمية',
                      style: subTextStyle().copyWith(
                        fontWeight: FontWeight.w700,
                        // color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      '١١٥٠',
                      style: subTextStyle().copyWith(
                          // color: Colors.white,
                          ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'وحدة',
                      style: subTextStyle().copyWith(
                        fontWeight: FontWeight.w700,
                        // color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'طن',
                      style: subTextStyle().copyWith(
                          // color: Colors.white,
                          ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'صنف',
                      style: subTextStyle().copyWith(
                        fontWeight: FontWeight.w700,
                        // color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'طماطم',
                      style: subTextStyle().copyWith(
                          // color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          SizedBox(height: 20.h),
          ListTile(
            leading: CustomText(
              text: 'السعر',
              textStyle: subTextStyle().copyWith(fontWeight: FontWeight.w700),
            ),
            title: SizedBox(
              width: 100.w,
              child: buildTextFormField(
                controller: null,
                onChanged: (String? value) {},
                onSubmitted: (String? value) {},
              ),
            ),
            trailing: SizedBox(
              width: 100.w,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CustomText(
                          text: 'الضريبة',
                          textStyle: subTextStyle()
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        CustomText(
                          text: '١٥٪',
                          textStyle: subTextStyle()
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CustomText(
                          text: 'إجمالي',
                          textStyle: subTextStyle()
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        CustomText(
                          text: '١٨٤٠',
                          textStyle: subTextStyle()
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.h),
          SizedBox(height: 30.h),
          Align(
            child: CustomButton(
              height: 60.h,
              backgroundColor: AppColors.textButtonColor,
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'تأكيد',
              radius: 4.r,
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    ),
  );
}

Widget buildTextFormField({
  required TextEditingController? controller,
  required Function(String)? onChanged,
  required Function(String)? onSubmitted,
}) {
  return SizedBox(
    height: 50.h,
    child: TextFormField(
      cursorColor: Colors.grey,
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: const BorderSide(
            color: AppColors.textButtonColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: const BorderSide(
            color: AppColors.textButtonColor,
          ),
        ),
      ),
      style: thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
    ),
  );
}

showModalSheet(
    {required BuildContext context,
    required String title,
    required bool isTransporter,
    required bool isOutList}) {
  showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.r),
        topRight: Radius.circular(30.r),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return isTransporter
          ? buildModalSheetTransporterItem(context: context, title: title)
          : buildModalSheetItem(
              context: context, title: title, isOutList: isOutList);
    },
  );
}

void showSnackBar({
  required BuildContext context,
  required String text,
  SnackBarStates snackBarStates = SnackBarStates.idle,
}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: ListTile(
        title: Text(text, style: subTextStyle().copyWith(color: Colors.white)),
        leading: generateSnackBarIcons(snackBarStates),
        horizontalTitleGap: 0,
      ),
      backgroundColor: generateSnackBarColors(snackBarStates),
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.zero,
    ),
  );
}

Color generateSnackBarColors(SnackBarStates states) {
  Color color;
  switch (states) {
    case SnackBarStates.idle:
      color = AppColors.secondaryColor;
      break;
    case SnackBarStates.success:
      color = AppColors.successColor;
      break;
    case SnackBarStates.error:
      color = AppColors.errorColor;
      break;
    case SnackBarStates.warning:
      color = AppColors.warningColor;
      break;
  }
  return color;
}

Icon? generateSnackBarIcons(SnackBarStates states) {
  Icon? icon;
  switch (states) {
    case SnackBarStates.idle:
      icon = null;
      break;
    case SnackBarStates.success:
      icon = const Icon(Icons.check_circle_rounded, color: Colors.white);
      break;
    case SnackBarStates.error:
      icon = const Icon(Icons.cancel, color: Colors.white);
      break;
    case SnackBarStates.warning:
      icon = const Icon(Icons.warning, color: Colors.white);
      break;
  }
  return icon;
}
