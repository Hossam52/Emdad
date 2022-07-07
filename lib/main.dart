import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:emdad/layout/guest_layout/guest_user_layout.dart';
import 'package:emdad/layout/transporter_layout/cubit/transporter_cubit.dart';
import 'package:emdad/layout/transporter_layout/transporter_layout.dart';
import 'package:emdad/layout/user_layout/user_layout.dart';
import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/layout/vendor_layout/vendor_layout_screen.dart';
import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/choose_language/choose_language_screen.dart';
import 'package:emdad/shared/bloc_observer.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/network/local/cache_helper.dart';
import 'package:emdad/shared/network/remote/dio_helper.dart';
import 'package:emdad/shared/styles/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'l10n/l10n.dart';
import 'modules/auth_module/screens/login_view/login_screen.dart';
import 'modules/auth_module/screens/on_boarding_view/on_boarding_screen.dart';
import 'shared/componants/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init(); // Dio Initialize
  // await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  Widget startWidget;
  bool? onBoarding = await CacheHelper.getData(key: 'onBoarding');
  Constants.lang = await CacheHelper.getData(key: 'lang');
  Constants.userToken = await CacheHelper.getData(key: 'userToken');
  Constants.guestToken = await CacheHelper.getData(key: 'guestToken');
  Constants.vendorToken = await CacheHelper.getData(key: 'vendorToken');
  Constants.transporterToken =
      await CacheHelper.getData(key: 'transporterToken');

  if (Constants.lang != null) {
    if (onBoarding != null) {
      if (Constants.vendorToken != null) {
        startWidget = const VendorLayout();
      } else if (Constants.userToken != null) {
        startWidget = const UserLayout();
      } else if (Constants.guestToken != null) {
        startWidget = const GuestUserLayout();
      } else if (Constants.transporterToken != null) {
        startWidget = const TransporterLayout();
      } else {
        startWidget = LoginScreen();
      }
    } else {
      startWidget = const OnBoardingScreen();
    }
  } else {
    startWidget = const ChooseLanguageScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(
        DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => MyApp(
            startWidget: startWidget,
          ), // Wrap your app
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({
    required this.startWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(
          create: (_) => AppCubit()..getSettings(),
          lazy: false,
        ),
        BlocProvider(create: (_) => VendorCubit(context)),
      ],
      child: OrientationBuilder(
        builder: (context, orientation) => ScreenUtilInit(
          designSize: orientation == Orientation.portrait
              ? const Size(375, 812)
              : const Size(812, 375),
          builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Emdad',
            theme: AppTheme.lightTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
            supportedLocales: L10n.all,
            locale: Locale('en'),
            // locale: Constants.lang != null
            //     ? Locale(Constants.lang!)
            //     : AppCubit.get(context).localeApp,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
          ),
        ),
      ),
    );
  }
}
