import 'package:cached_network_image/cached_network_image.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_data/update_profile_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_icon_button.dart';
import 'package:emdad/shared/widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileInfoBuildItem extends StatelessWidget {
  const ProfileInfoBuildItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => current is ChangeUserData,
      builder: (context, state) {
        final user = AppCubit.get(context).getUser!;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 55),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                AppColors.secondaryColor.withOpacity(0.18),
                AppColors.secondaryColor.withOpacity(0.09),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyProfilePicture(url: user.logoUrl!),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name!,
                          style: headersTextStyle()
                              .copyWith(color: AppColors.primaryColor),
                        ),
                        Text(
                          user.country! + ' (هتتغير) ',
                          style: subTextStyle()
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  CustomIconButton(
                    width: 45.w,
                    height: 45.h,
                    onPressed: () {
                      navigateTo(context, UpdateProfileScreen());
                    },
                    icon: const Icon(MyIcons.edit, color: Colors.white),
                    buttonColor: AppColors.secondaryColor,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
