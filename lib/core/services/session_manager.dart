import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/features/auth/data/datasources/google_auth_service.dart';
import 'package:workspace/features/notification/presentation/cubit/notification_badge_cubit.dart';
import 'package:workspace/features/profile/presentation/cubit/profile/profile_cubit.dart';

/// تنظيف الجلسة بالكامل (مثل تسجيل الخروج) — يُستدعى عند انتهاء الجلسة (401)
/// أو الخروج اليدوي: يمسح التوكن والبيانات المحلية ويُنهي جلسة Google ويصفّر
/// النسخ المشتركة (البروفايل + عدّاد الإشعارات).
class SessionManager {
  static Future<void> clear() async {
    final storage = LocalStorage();
    await storage.removeKey(Constants.token);
    await storage.removeKey(Constants.unreadNotification);

    try {
      await sl<GoogleAuthService>().signOut();
    } catch (_) {}
    try {
      sl<ProfileCubit>().reset();
    } catch (_) {}
    try {
      sl<NotificationBadgeCubit>().clear();
    } catch (_) {}
  }
}
