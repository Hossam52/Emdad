import 'package:emdad/modules/settings/profile_info_build_item.dart';
import 'package:emdad/modules/settings/setting_tile_build_item.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransporterSettingScreen extends StatelessWidget {
  const TransporterSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ProfileInfoBuildItem(),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              SettingTileBuildItem(
                title: 'تغير رقم الهاتف',
                leading: SvgPicture.asset(
                  '${Constants.defaultIconUrl}/phone.svg',
                  width: 13,
                ),
                onTap: () {},
              ),
              const Divider(height: 0),
              SettingTileBuildItem(
                title: 'تغيير الرقم السري',
                leading: const Icon(MyIcons.lock,
                    color: AppColors.primaryColor, size: 17),
                onTap: () {},
              ),
              const Divider(height: 0),
              SettingTileBuildItem(
                title: 'الاشعارات',
                leading: SvgPicture.asset(
                  '${Constants.defaultIconUrl}/notification.svg',
                  width: 15,
                ),
                trailing: CupertinoSwitch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: AppColors.primaryColor,
                ),
                onTap: () {},
              ),
              const Divider(height: 0),
              SettingTileBuildItem(
                title: 'تغيير اللغة',
                leading: const Icon(MyIcons.translation,
                    color: AppColors.primaryColor, size: 18),
                trailing: DropdownButton<Object>(
                  onChanged: (val) {},
                  items: const [DropdownMenuItem(child: Text('العربية'))],
                ),
              ),
              const Divider(height: 0),
              SettingTileBuildItem(
                title: 'الخصوصية',
                leading: const Icon(MyIcons.policy,
                    color: AppColors.primaryColor, size: 18),
                onTap: () {},
              ),
              const Divider(height: 0),
              SettingTileBuildItem(
                title: 'المساعدة',
                leading: const Icon(MyIcons.question_fill,
                    color: AppColors.primaryColor, size: 18),
                onTap: () {},
              ),
              const Divider(height: 0),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              onPressed: () {},
              text: 'تسجيل خروج',
            ),
          ),
        ],
      ),
    );
  }
}
