import 'package:emdad/modules/auth_module/screens/on_boarding_view/on_boarding_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/responsive/responsive_widget.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'build_choose_language.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: const Color(0xffF7F8FB),
              ),
              backgroundColor: const Color(0xffF7F8FB),
              body: responsiveWidget(responsive: (_, deviceInfo) {
                return Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/choose_lang.svg',
                              height: 250.h,
                            ),
                            const SizedBox(height: 50),
                            Text(
                              context.tr.choose_lang,
                              locale: const Locale('ar'),
                              style: headersTextStyle().copyWith(
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              context.tr.choose_lang,
                              locale: const Locale('en'),
                              style: TextStyle(
                                fontSize: 22.sp,
                                color: AppColors.secondaryColor,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildChooseLanguage(
                                  deviceInfo,
                                  choose: () {
                                    AppCubit.get(context).changeLocaleApp('ar');
                                    navigateTo(
                                        context, const OnBoardingScreen());
                                  },
                                  label: 'ع',
                                  text: 'عربي',
                                  colorContainer: Colors.white,
                                  colorText:
                                      cubit.localeApp.languageCode == 'ar'
                                          ? AppColors.secondaryColor
                                          : Colors.black12,
                                ),
                                const SizedBox(width: 20),
                                buildChooseLanguage(
                                  deviceInfo,
                                  choose: () {
                                    AppCubit.get(context).changeLocaleApp('en');
                                    navigateTo(
                                        context, const OnBoardingScreen());
                                  },
                                  label: 'en',
                                  text: 'English',
                                  colorContainer: Colors.white,
                                  colorText:
                                      cubit.localeApp.languageCode == 'en'
                                          ? AppColors.secondaryColor
                                          : Colors.black12,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }));
        },
      ),
    );
  }
}
