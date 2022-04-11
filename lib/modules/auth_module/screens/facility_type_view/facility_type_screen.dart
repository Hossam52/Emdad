import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/general_models/facility_type_model.dart';
import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/transporter_info_view/transporter_info_screen.dart';
import 'package:emdad/modules/auth_module/screens/user_info_view/user_info_screen.dart';
import 'package:emdad/modules/auth_module/screens/vendor_info_view/vendor_info_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/ui_componants/default_loader.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'facility_type_build_item.dart';

class FacilityTypeScreen extends StatelessWidget {
  const FacilityTypeScreen({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..getUserSettings(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  state is! UserGetSettingsLoadingState,
              fallbackBuilder: (context) => const DefaultLoader(),
              widgetBuilder: (context) => state is UserGetSettingsErrorState
                  ? NoDataWidget(onPressed: () => cubit.getUserSettings())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                        child: Column(
                          children: [
                            CustomText(
                              text: 'حدد نوع المنشأة الخاصة بك',
                              textStyle: thirdTextStyle(),
                            ),
                            SizedBox(height: 20.h),
                            SvgPicture.asset(
                                'assets/images/undraw_building.svg'),
                            SizedBox(height: 40.h),
                            ListView.separated(
                              itemCount: listOfTypesItems.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 30),
                              itemBuilder: (context, index) =>
                                  FacilityBuildItem(
                                facilityTypeModel: listOfTypesItems[index],
                                cubit: cubit,
                              ),
                            ),
                            SizedBox(height: 60.h),
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: CustomButton(
                                text: 'التالى',
                                width: MediaQuery.of(context).size.width * 0.4,
                                onPressed: cubit.facilityType != null
                                    ? () {
                                        switch (cubit.facilityType!) {
                                          case FacilityType.vendor:
                                            navigateTo(
                                                context,
                                                VendorInfoScreen(
                                                  token: token,
                                                  cubit: cubit,
                                                ));
                                            break;
                                          case FacilityType.user:
                                            navigateTo(
                                                context,
                                                UserInfoScreen(
                                                  token: token,
                                                  cubit: cubit,
                                                ));
                                            break;
                                          case FacilityType.transport:
                                            navigateTo(context,
                                                TransporterInfoScreen(
                                                  token: token,
                                                  cubit: cubit,
                                                ));
                                            break;
                                        }
                                      }
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
