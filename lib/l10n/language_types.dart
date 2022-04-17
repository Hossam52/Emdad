abstract class LangType {
  final String langCode;
  final String langDisplayName;

  LangType({required this.langCode, required this.langDisplayName});
}

class EnglishLang extends LangType {
  EnglishLang() : super(langCode: 'en', langDisplayName: 'English');
}

class ArabicLang extends LangType {
  ArabicLang() : super(langCode: 'ar', langDisplayName: 'اللغة العربية');
}

final allSupportedLangs = [
  EnglishLang(),
  ArabicLang(),
];
