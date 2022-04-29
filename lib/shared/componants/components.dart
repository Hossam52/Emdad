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
