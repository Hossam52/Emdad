import 'package:emdad/l10n/language_types.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/ui_componants/default_drop_down.dart';
import 'package:flutter/material.dart';

class ChangeLanguageDialog extends StatelessWidget {
  ChangeLanguageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultDropDown(
                elevation: 4,
                label: 'اللغة',
                selectedValue: allSupportedLangs.first.langDisplayName,
                onChanged: (val) {},
                validator: (val) {},
                items:
                    allSupportedLangs.map((e) => e.langDisplayName).toList()),
            SizedBox(
              height: SharedMethods.getHeightFraction(context, 0.02),
            ),
            CustomButton(
              backgroundColor: AppColors.successColor,
              text: 'حفظ',
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
