import 'package:emdad/models/general_models/facility_type_model.dart';
import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FacilityBuildItem extends StatelessWidget {
  const FacilityBuildItem({
    Key? key,
    required this.facilityTypeModel,
    required this.cubit,
  }) : super(key: key);

  final FacilityTypeModel facilityTypeModel;
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: cubit.facilityType == facilityTypeModel.facilityType
                ? AppColors.secondaryColor
                : Colors.grey[400]!,
            width: 2),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ListTile(
          onTap: () {
            cubit.changeFacilityType(facilityTypeModel.facilityType);
          },
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          title: Text(
            facilityTypeModel.title,
            style: thirdTextStyle(),
          ),
          leading: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child:  cubit.facilityType == facilityTypeModel.facilityType
                ? icon(AppColors.secondaryColor, const Key('1'))
                : icon(Colors.grey[400]!, const Key('2')),
          ),
          contentPadding: const EdgeInsets.all(16),
          horizontalTitleGap: 40,
        ),
      ),
    );
  }
  Widget icon(Color color, Key key) => SvgPicture.asset(
    facilityTypeModel.imagePath,
    width: 50,
    key: key,
    color: color,
  );
}
