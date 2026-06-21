import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:workspace/core/config/constants.dart';

/// يرسل رمز FCM إلى الخادم (endpoint: /v1/store-token) ليُمكّن إرسال الإشعارات.
/// يُستدعى بعد دخول المستخدم المصادَق عليه.
class FcmTokenService {
  final Dio dio;

  FcmTokenService(this.dio);

  Future<void> sync() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token == null || token.isEmpty) return;
      await dio.post(Constants.storeTokenApi, data: {'fcm_token': token});
    } catch (_) {
      // تجاهل الفشل (لا يمنع استخدام التطبيق)
    }
  }
}
