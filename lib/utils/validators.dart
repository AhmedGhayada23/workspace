class Validators {
  static String? required(String? value, {String fieldName = 'هذا الحقل'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName مطلوب';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'البريد الإلكتروني غير صالح';
    }
    return null;
  }

  static String? minLength(String? value, int minLength, {String fieldName = 'الحقل'}) {
    if (value == null || value.length < minLength) {
      return '$fieldName يجب أن لا يقل عن $minLength أحرف';
    }
    return null;
  }
static String? phone(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'رقم الهاتف مطلوب';
  }

  value = value.trim();


  // التحقق من أن الرقم يتكون من 10 أرقام ويبدأ بـ 059 أو 056
  final phoneRegex = RegExp(r'^05[69]\d{7}$');

  if (!phoneRegex.hasMatch(value)) {
    return 'رقم الهاتف غير صالح. يجب أن يبدأ بـ 059 أو 056 \nويتكون من 10 أرقام';
  }

  return null;
}

//   static String? phone(String? value) {
//   if (value == null || value.trim().isEmpty) {
//     return 'رقم الهاتف مطلوب';
//   }

//   value = value.trim();
//   // فحص باستخدام regex: يبدأ بـ + ثم أرقام، مثلاً +966501234567
//   final phoneRegex = RegExp(r'^\+[1-9]\d{7,14}$');

//   if (!phoneRegex.hasMatch(value)) {
//     return 'رقم الهاتف غير صالح. يجب أن يبدأ بـ "+" ويتبعه رمز الدولة ورقم الهاتف';
//   }

//   return null;
// }


  static String? match(String? value, String? otherValue, {String fieldName = 'القيمة'}) {
    if (value != otherValue) {
      return '$fieldName غير مطابقة';
    }
    return null;
  }


  static String? positiveInteger(String? value, {String fieldName = 'هذا الحقل'}) {
  if (value == null || value.trim().isEmpty) {
    return '$fieldName مطلوب';
  }
  final trimmed = value.trim();

  // التأكد أن القيمة رقم صحيح موجب فقط (بدون كسور أو أعداد سالبة)
  final regex = RegExp(r'^[1-9]\d*$');
  if (!regex.hasMatch(trimmed)) {
    return '$fieldName يجب أن يكون رقمًا صحيحًا موجبًا\n بدون كسور أو أصفار في البداية';
  }
  return null;
}

}
