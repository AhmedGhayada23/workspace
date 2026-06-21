import 'package:workspace/core/localization/translation_ar.dart';

/// امتداد ترجمة بسيط بديل عن `.tr` الخاص بـ GetX.
/// التطبيق مثبّت على اللغة العربية، لذا نقرأ من خريطة [arEG]
/// ونُعيد المفتاح نفسه إن لم تُوجد ترجمة (نفس سلوك GetX).
extension AppTr on String {
  String get tr => arEG[this] ?? this;
}
