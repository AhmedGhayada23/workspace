import 'package:get/get.dart';
import 'package:workspace/core/localization/translation_ar.dart';
import 'package:workspace/core/localization/translation_en.dart';


class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': enUS,
        'ar': arEG,
      };
}