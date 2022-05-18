import 'dart:developer';

import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/background_stack.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/custom_update_profile_app_bar.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/update_profile_text_field.dart';
import 'package:emdad/modules/user_module/vendors_module/change_filters_cubit/change_filters_cubit.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/profile_picture.dart';
import 'package:emdad/shared/widgets/shared_componants/custom_country_city_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final organizationController = TextEditingController();

  final commericalRegisterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = AppCubit.get(context).getUser!;
    organizationController.text = user.organizationName!;
    commericalRegisterController.text = user.commercialRegister!;
  }

  @override
  Widget build(BuildContext context) {
    final user = AppCubit.get(context).getUser!;
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ChangeFiltersCubit()
              ..initFilters(context,
                  initialCountryCode: user.country, intialCity: user.city),
          ),
          BlocProvider(
            create: (context) => AuthCubit(),
            lazy: false,
          ),
        ],
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, authState) {
            if (authState is UpdateProfileSuccessState) {
              SharedMethods.showToast(context, 'تم تحديث بيانات الحساب بنجاح',
                  color: AppColors.successColor, textColor: Colors.white);
            }
            if (authState is UpdateProfileErrorState) {
              SharedMethods.showToast(context, authState.error,
                  color: AppColors.errorColor, textColor: Colors.white);
            }
          },
          builder: (context, auhtState) {
            return ChangeFiltersBlocBuilder(
              builder: (context, state) {
                final filtersCubit = ChangeFiltersCubit.instance(context);
                log(filtersCubit.countries.toString());
                return BackgroundStack(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const CustomUpdateProfileAppBar(
                          title: 'تعديل الملف الشخصي'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const _ProfilePicture(),
                            UpdateProfileTextField(
                                enabled: false,
                                textEditingController:
                                    TextEditingController(text: user.name!),
                                label: 'الاسم',
                                hint: '',
                                validator: (val) {
                                  return null;
                                }),
                            UpdateProfileTextField(
                                textEditingController: organizationController,
                                label: 'اسم المؤسسة',
                                hint: 'ادخل الاسم',
                                validator: (val) {
                                  return null;
                                }),
                            UpdateProfileTextField(
                                textEditingController:
                                    commericalRegisterController,
                                label: 'السجل الضريبي',
                                hint: 'ادخل السجل الضريبي',
                                isDigitsOnly: true,
                                validator: (val) {
                                  return null;
                                }),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                Expanded(
                                  child: _CustomDropDown(
                                    selected: filtersCubit.selectedCountry,
                                    items: filtersCubit.countries,
                                    onChange: (country) =>
                                        filtersCubit.changeSelectedCountry(
                                            context, country!),
                                    title: 'الدولة',
                                  ),
                                ),
                                Expanded(
                                  child: _CustomDropDown(
                                    title: 'المدينة',
                                    selected: filtersCubit.selectedCity,
                                    items: filtersCubit.cities,
                                    onChange: (city) =>
                                        filtersCubit.changeSelectedCity(city!),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            auhtState is UpdateProfileLoadingState
                                ? const CircularProgressIndicator()
                                : CustomButton(
                                    text: 'تعديل',
                                    width: 180.w,
                                    onPressed: () {
                                      log('//${organizationController.text} ${commericalRegisterController.text} ${filtersCubit.selectedCountryCode} ${filtersCubit.selectedCity}');

                                      // return;
                                      AuthCubit.get(context).updateProfile(
                                          context: context,
                                          organization:
                                              organizationController.text,
                                          commericalRegister:
                                              commericalRegisterController.text,
                                          country:
                                              filtersCubit.selectedCountryCode!,
                                          city: filtersCubit.selectedCity!);
                                    },
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
              },
            );
          },
        ),
      ),
    );
  }
}

class _ProfilePicture extends StatelessWidget {
  const _ProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AppCubit.get(context).getUser!;
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is PickPersonalImageErrorState) {
        SharedMethods.showToast(context, state.error,
            color: AppColors.errorColor, textColor: Colors.white);
      }
    }, builder: (context, state) {
      final authCubit = AuthCubit.get(context);
      return Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          authCubit.hasPickedPersonalImage
              ? ProfilePictureFromFile(file: authCubit.selectedImageFile!)
              : MyProfilePicture(url: user.logoUrl!),
          CircleAvatar(
              backgroundColor: AppColors.secondaryColor,
              child: IconButton(
                onPressed: () {
                  AuthCubit.get(context).changePicture();
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ))
        ],
      );
    });
  }
}

class _CustomDropDown extends StatelessWidget {
  const _CustomDropDown(
      {Key? key,
      required this.selected,
      required this.items,
      this.onChange,
      required this.title})
      : super(key: key);
  final String? selected;
  final List<String> items;
  final void Function(String? val)? onChange;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: thirdTextStyle().copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 5),
          DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                    elevation: 1,
                    value: selected,
                    items: items
                        .map((e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)))
                        .toList(),
                    onChanged: onChange),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
