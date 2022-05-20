import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestCheckerWidget extends StatelessWidget {
  const GuestCheckerWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final user = AppCubit.get(context).getUser!;
    return user.isGuest ? const _GuestWidget() : child;
  }
}

class _GuestWidget extends StatelessWidget {
  const _GuestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'أنت تتصفح كزائر يجب تسجيل الدخول اولا كمستخدم لرؤية هذا المحتوي',
          style: secondaryTextStyle(),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20.h,
        ),
        Image.asset(
          'assets/images/error.png',
          height: 250.h,
          width: 250.h,
        ),
        SizedBox(
          height: 20.h,
        ),
        CustomButton(
          width: 0.5.sw,
          text: 'تسجيل الدخول',
          onPressed: () {
            SharedMethods.signOutVendor(context);
          },
        )
      ]),
    );
  }
}
