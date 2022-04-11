import 'package:emdad/layout/user_layout/layout_components/drawer_list_build_item.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
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
                      height: 85.w,
                      imageUrl:
                          'https://userstock.io/data/wp-content/uploads/2020/06/jack-finnigan-rriAI0nhcbc.jpg',
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Aurélien Salomon',
                    style: headersTextStyle()
                        .copyWith(fontSize: 24.sp, color: Colors.white),
                  ),
                  Text(
                    '@aureliensalomon',
                    style: thirdTextStyle().copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 28.h),
          DrawerListBuildItem(
            title: 'الرئيسية',
            icon: MyIcons.home,
            onTap: () {},
          ),
          DrawerListBuildItem(
            title: 'طلب جديد',
            icon: MyIcons.note,
            onTap: () {},
          ),
          DrawerListBuildItem(
            title: 'عروض',
            icon: MyIcons.money,
            size: 15,
            onTap: () {},
          ),
          DrawerListBuildItem(
            title: 'الاشعارات',
            icon: MyIcons.bell2,
            onTap: () {},
          ),
          DrawerListBuildItem(
            title: 'طلب مساعدة',
            icon: MyIcons.question,
            onTap: () {},
          ),
          DrawerListBuildItem(
            title: 'الدعم والخصوصية',
            icon: MyIcons.support,
            onTap: () {},
          ),
          DrawerListBuildItem(
            title: 'عنا',
            icon: Icons.info_outlined,
            size: 24,
            onTap: () {},
          ),
          DrawerListBuildItem(
            title: 'الضبط',
            icon: MyIcons.settings,
            onTap: () {},
          ),
          DrawerListBuildItem(
            title: 'تسجيل خروج',
            icon: Icons.logout,
            onTap: () {
              SharedMethods.signOutVendor(context);
            },
          ),
        ],
      ),
    );
  }
}
