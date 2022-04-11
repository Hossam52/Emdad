import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoDataWidget extends StatelessWidget {
  NoDataWidget({
    Key? key,
    this.text,
    required this.onPressed,
  }) : super(key: key);

  String? text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var textTranslate = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 45,
            color: Colors.grey,
          ),
          const SizedBox(height: 15),
          Text(
            text?? textTranslate.no_data,
            style: thirdTextStyle().copyWith(color: Colors.grey),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(textTranslate.try_again),
          ),
        ],
      ),
    );
  }
}
