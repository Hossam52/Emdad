import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension TranslationService on BuildContext {
  AppLocalizations get tr {
    return AppLocalizations.of(this)!;
  }
}
