import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.notifications),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: AppBarTheme.of(context)
            .titleTextStyle!
            .copyWith(color: Colors.white),
      ),
      body: ListView.separated(
        itemBuilder: (_, index) => const _NotificationItem(),
        itemCount: 12,
        separatorBuilder: (_, index) => SizedBox(
          height: 10.h,
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      contentPadding: const EdgeInsetsDirectional.only(end: 10),
      leading: const _CircularImage(imagePath: 'assets/images/user.png'),
      title: Text('لقد قام المورد بقبول طلبك ويمكنك الان تفقده',
          style: thirdTextStyle()),
      trailing: CircleAvatar(
        backgroundColor: AppColors.primaryColor,
        radius: 3.w,
      ),
    );
  }
}

class _CircularImage extends StatelessWidget {
  const _CircularImage({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 0.15.sw,
        height: 0.15.sw,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Image.asset(imagePath));
  }
}
