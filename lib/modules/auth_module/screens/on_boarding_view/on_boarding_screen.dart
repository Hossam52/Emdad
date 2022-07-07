import 'package:carousel_slider/carousel_slider.dart';
import 'package:emdad/models/general_models/on_boarding_model.dart';
import 'package:emdad/modules/auth_module/screens/login_view/login_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/network/local/cache_helper.dart';
import 'package:emdad/shared/responsive/device_information.dart';
import 'package:emdad/shared/responsive/responsive_widget.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'on_boarding_build_item.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  CarouselControllerImpl boardingController = CarouselControllerImpl();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return responsiveWidget(
        responsive: (_, DeviceInformation deviceInformation) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 20.h),
                  CarouselSlider.builder(
                    itemCount: 3,
                    carouselController: boardingController,
                    itemBuilder: (context, index, int pageViewIndex) =>
                        OnBoardItem(
                      boardingModel: listOfBoardingItems[index],
                    ),
                    options: CarouselOptions(
                      viewportFraction: 0.8,
                      height: 550.h,
                      onPageChanged: (index, value) => onPageChanged(index),
                      enlargeCenterPage: true,
                      initialPage: 0,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  CustomButton(
                    width: 310.w,
                    height: 52.h,
                    backgroundColor: AppColors.primaryColor,
                    text: isLast ? context.tr.start : context.tr.next,
                    onPressed: () {
                      if (isLast) {
                        saveOnBoardingState(context);
                      }
                      boardingController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void saveOnBoardingState(BuildContext context) {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateToAndFinish(
          context,
          LoginScreen(),
        );
      }
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void onPageChanged(int index) {
    if (index == listOfBoardingItems.length - 1) {
      setState(() {
        isLast = true;
      });
    } else {
      setState(() {
        isLast = false;
      });
    }
  }
}
