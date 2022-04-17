import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/dialogs/change_language_dialog.dart';
import 'package:flutter/material.dart';

class ChangeLangWidget extends StatelessWidget {
  const ChangeLangWidget({Key? key, this.color}) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(context: context, builder: (_) => ChangeLanguageDialog());
      },
      icon: Icon(
        MyIcons.translation,
        color: color ?? AppColors.primaryColor,
      ),
    );
  }
}
