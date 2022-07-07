import 'package:emdad/layout/user_layout/layout_components/drawer_list_build_item.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.drawerItems}) : super(key: key);
  final List<DrawerListBuildItem> drawerItems;
  @override
  Widget build(BuildContext context) {
    final user = AppCubit.get(context).getUser;
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const _UserWidget(),
            SizedBox(height: 28.h),
            for (var item in drawerItems) item,
            DrawerListBuildItem(
              title: user == null || user.isGuest
                  ? context.tr.login
                  : context.tr.logout,
              icon: Icons.logout,
              onTap: () {
                SharedMethods.signOutVendor(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _UserWidget extends StatelessWidget {
  const _UserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AppCubit.get(context).getUser!;

    return Container(
      color: AppColors.primaryColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: DefaultCachedNetworkImage(
                width: 85.w,
                fit: BoxFit.cover,
                height: 85.w,
                imageUrl: user.logoUrl!,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              user.name!,
              style: headersTextStyle()
                  .copyWith(fontSize: 24.sp, color: Colors.white),
            ),
            Text(
              user.organizationName!,
              style: thirdTextStyle().copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
