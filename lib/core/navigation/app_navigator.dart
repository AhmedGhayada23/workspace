/// تجريد التنقّل — تستخدمه الـ views بدل استدعاء الـ Navigator مباشرة.
///
/// التنفيذ الحالي [FlutterAppNavigator] يعتمد على Flutter Navigator عبر
/// مفتاح عام (navigatorKey)، فالـ views لا تعرف تفاصيل التنقّل.
abstract class AppNavigator {
  void back();
  void toSignIn();
  void offAllToSignIn();
  void toSignUp();
  void toResetPassword();
  void offAllToHome();
  void offAllToSplash();

  /// الانتقال إلى الشاشة الرئيسية مع تحديد تبويب الشريط السفلي.
  void offAllToHomeTab(int index);

  void toOtp({required String email, required bool isNewAccount});
  void toNewPassword({required String email});
  void offAllToCongratulations();

  // Home / spaces
  void toSearch();
  void toNotifications();
  void toAllSpace();
  void toDetails(int id);

  /// الانتقال لتفاصيل مساحة مع استبدال المكدّس حتى الشريط السفلي (من شاشة تفاصيل لأخرى).
  void replaceToDetails(int id);

  /// شاشة الحجز — تُمرَّر الوسائط كما تتوقّعها ميزة الحجز حالياً.
  void toBooking({
    required Map<String, dynamic> arguments,
    required Map<String, String> parameters,
  });

  /// شاشة تأكيد الحجز.
  void toConfirmBooking({
    required Object arguments,
    required Map<String, String> parameters,
  });

  /// تفاصيل حجز — يُمرَّر كائن الحجز كوسيطة.
  void toReservationDetails(Object reservation);

  // Profile
  void toEditProfile();
  void toSettingProfile();
  void toChangePassword();
  void toDeleteAccount();
  void toDeleteAccountVerification(String email);
}
