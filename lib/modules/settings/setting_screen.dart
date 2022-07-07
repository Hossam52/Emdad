import 'package:emdad/modules/auth_module/screens/update_profile/change_email/change_email.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/change_password/change_password.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/change_phone/change_phone_screen.dart';
import 'package:emdad/modules/settings/profile_info_build_item.dart';
import 'package:emdad/modules/settings/setting_tile_build_item.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
              const ChangePhoneAndEmailAndPasswordWidget(),
              const Divider(height: 0),
              SettingTileBuildItem(
                title: context.tr.notifications,
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
                title: context.tr.change_lang,
                leading: const Icon(MyIcons.translation,
                    color: AppColors.primaryColor, size: 18),
                trailing: DropdownButton<Object>(
                  onChanged: (val) {},
                  items: const [DropdownMenuItem(child: Text('العربية'))],
                ),
              ),
              const Divider(height: 0),
              const _PrivacyAndHelp(),
              const Divider(height: 0),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              onPressed: () {
                SharedMethods.signOutVendor(context);
              },
              text: context.tr.logout,
            ),
          ),
        ],
      ),
    );
  }
}

class ChangePhoneAndEmailAndPasswordWidget extends StatelessWidget {
  const ChangePhoneAndEmailAndPasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingTileBuildItem(
          title: context.tr.change_phone_number,
          leading: SvgPicture.asset(
            '${Constants.defaultIconUrl}/phone.svg',
            width: 13,
          ),
          onTap: () {
            navigateTo(context, ChangePhoneScreen());
          },
        ),
        const Divider(height: 0),
        SettingTileBuildItem(
          title: context.tr.change_password,
          leading:
              const Icon(MyIcons.lock, color: AppColors.primaryColor, size: 17),
          onTap: () {
            navigateTo(context, ChangePasswordScreen());
          },
        ),
        SettingTileBuildItem(
          title: context.tr.change_mail,
          leading:
              const Icon(Icons.email, color: AppColors.primaryColor, size: 17),
          onTap: () {
            navigateTo(context, ChangeEmailScreen());
          },
        ),
      ],
    );
  }
}

class _PrivacyAndHelp extends StatelessWidget {
  const _PrivacyAndHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingTileBuildItem(
          title: context.tr.privacy,
          leading: const Icon(MyIcons.policy,
              color: AppColors.primaryColor, size: 18),
          onTap: () {},
        ),
        const Divider(height: 0),
        SettingTileBuildItem(
          title: context.tr.help,
          leading: const Icon(MyIcons.question_fill,
              color: AppColors.primaryColor, size: 18),
          onTap: () {},
        ),
      ],
    );
  }
}

class GuestSettings extends StatelessWidget {
  const GuestSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ProfileInfoBuildItem(),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                SettingTileBuildItem(
                  title: context.tr.change_lang,
                  leading: const Icon(MyIcons.translation,
                      color: AppColors.primaryColor, size: 18),
                  trailing: DropdownButton<Object>(
                    onChanged: (val) {},
                    items: const [DropdownMenuItem(child: Text('العربية'))],
                  ),
                ),
                const Divider(height: 0),
                const _PrivacyAndHelp(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                onPressed: () {
                  SharedMethods.signOutVendor(context);
                },
                text: context.tr.login,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
