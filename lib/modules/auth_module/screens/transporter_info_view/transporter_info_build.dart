import 'package:emdad/layout/transporter_layout/transporter_layout.dart';
import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/vendor_info_view/choose_location_build_item.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_text_form_with_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransporterInfoBuild extends StatefulWidget {
  TransporterInfoBuild({Key? key}) : super(key: key);

  @override
  State<TransporterInfoBuild> createState() => _TransporterInfoBuildState();
}

class _TransporterInfoBuildState extends State<TransporterInfoBuild> {
  List<String> choices = [
    'عربه نصف نقل',
    'سياره نقل',
    'شاحنة كبيرة',
    'عربه نصف نقل مزوده بثلاجه',
  ];

  final List<String> _filters = [];

  TextEditingController organizationNameController = TextEditingController();

  TextEditingController commercialRegisterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    child: CustomText(
                      text: 'شركه نقل',
                      textStyle: secondaryTextStyle(),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextFormFiledWithBorder(
                    controller: organizationNameController,
                    hint: 'الهدي والتقوي',
                    type: TextInputType.text,
                    validate: (String? value) {},
                    titleText: 'آسم المؤسسة',
                  ),
                  SizedBox(height: 15.h),
                  TextFormFiledWithBorder(
                    controller: commercialRegisterController,
                    hint: '١٢٣٤٥٦٧٨',
                    type: TextInputType.text,
                    validate: (String? value) {},
                    titleText: 'السجل التجاري',
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    text: 'وسيلة النقل',
                    textStyle:
                    thirdTextStyle().copyWith(fontWeight: FontWeight.w500),
                  ),
                  Wrap(
                    children: List.generate(
                      choices.length,
                          (index) =>
                          Padding(
                            padding: EdgeInsets.all(6.r),
                            child: FilterChip(
                              avatar: CircleAvatar(
                                child: Text(
                                  choices[index].substring(0, 1),
                                  style: thirdTextStyle(),
                                ),
                              ),
                              label: Text(
                                choices[index],
                                style: thirdTextStyle(),
                              ),
                              selected: _filters.contains(choices[index]),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    _filters.add(choices[index]);
                                  } else {
                                    _filters.removeWhere(
                                            (element) =>
                                        element == choices[index]);
                                  }
                                });
                              },
                            ),
                          ),
                    ),
                  ),
                  CustomText(
                    text: 'مختارة: ${_filters.join(', ')}',
                    textStyle: thirdTextStyle(),
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    text: 'الموقع',
                    textStyle: thirdTextStyle(),
                  ),
                  SizedBox(height: 15.h),
                  if(cubit.selectedLocation == null)
                    ChooseLocationBuildItem(
                      cubit: cubit,
                    ) else
                    Text(
                      cubit.selectedLocation.toString(),
                    ),
                  SizedBox(height: 60.h),
                  Align(
                    child: CustomButton(
                      width: 287.w,
                      height: 40.h,
                      backgroundColor: AppColors.textButtonColor,
                      onPressed: () {
                        navigateToAndFinish(context, const TransporterLayout());
                      },
                      text: 'انهاء',
                      radius: 4.r,
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
