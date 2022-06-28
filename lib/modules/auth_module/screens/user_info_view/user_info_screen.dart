import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/users/app_user_model.dart';
import 'package:emdad/models/users/user/user_data_model.dart';
import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/vendor_info_view/choose_location_build_item.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:emdad/shared/widgets/default_progress_button.dart';
import 'package:emdad/shared/widgets/shared_componants/custom_country_city_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({
    Key? key,
    required this.token,
    required this.cubit,
  }) : super(key: key);

  final String token;
  final AuthCubit cubit;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  TextEditingController organizationNameController = TextEditingController();
  TextEditingController commercialRegisterController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cubit,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Scaffold(
            backgroundColor: const Color.fromRGBO(246, 246, 246, 1.0),
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(246, 246, 246, 1.0),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Form(
                key: formKey,
                child: Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          child: CustomText(
                            text: 'مطعم \\ كافيه',
                            textStyle: secondaryTextStyle(),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CustomTextFormField(
                          controller: organizationNameController,
                          hint: 'الهدي والتقوي',
                          type: TextInputType.text,
                          validation: (String? value) =>
                              SharedMethods.defaultValidation(value),
                          titleText: 'آسم المؤسسة',
                          backgroundColor: AppColors.textWhiteGrey,
                          hasBorder: false,
                        ),
                        SizedBox(height: 15.h),
                        CustomTextFormField(
                          controller: commercialRegisterController,
                          hint: '١٢٣٤٥٦٧٨',
                          type: TextInputType.text,
                          validation: (String? value) =>
                              SharedMethods.defaultValidation(value),
                          titleText: 'السجل التجاري',
                          backgroundColor: AppColors.textWhiteGrey,
                          hasBorder: false,
                        ),
                        SizedBox(height: 10.h),
                        CustomText(
                          text: 'الموقع',
                          textStyle: thirdTextStyle(),
                        ),
                        SizedBox(height: 10.h),
                        CustomCountryCityDropdown(
                          cubit: cubit,
                          countries: cubit.countries,
                          cities: cubit.cities,
                        ),
                        SizedBox(height: 20.h),
                        if (cubit.selectedLocation == null)
                          ChooseLocationBuildItem(
                            cubit: cubit,
                          )
                        else
                          Text(
                            cubit.selectedLocation.toString(),
                          ),
                        SizedBox(height: 60.h),
                        Align(
                          alignment: Alignment.center,
                          child: DefaultProgressButton(
                            buttonState: cubit.completeProfileStates,
                            idleText: 'انهاء',
                            failText: 'حدث خطأ',
                            successText: 'تم التسجيل',
                            onPressed: () {
                              formKey.currentState!.save();
                              if (formKey.currentState!.validate()) {
                                cubit.completeProfile(
                                  UserDataModel(
                                    organizationName:
                                        organizationNameController.text,
                                    commercialRegister:
                                        commercialRegisterController.text,
                                    country: cubit.selectedCountry!,
                                    city: cubit.selectedCity!,
                                    locationData: LocationData(
                                      latitude: cubit.selectedLocationTest!.lat,
                                      longitude:
                                          cubit.selectedLocationTest!.lon,
                                    ),
                                  ),
                                  facilityType: FacilityType.user,
                                  token: widget.token,
                                  context: context,
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    organizationNameController.dispose();
    commercialRegisterController.dispose();
    super.dispose();
  }
}
