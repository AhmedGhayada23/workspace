import 'dart:developer';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';

class FcmNotificationController extends GetxController {
  RxString fcmToken = ''.obs;
  final LocalStorage prefs = LocalStorage();

  /// حالة التنبيهات غير المقروءة
  RxBool hasUnread = false.obs;

  @override
  void onInit() {
    FirebaseMessaging.instance.getToken().then((newToken) {
      fcmToken.value = newToken!;
      log('FCM :: ${fcmToken.value}');
    });
    loadUnreadState();
    super.onInit();
  }

  void markAsUnread() {
    hasUnread.value = true;
    prefs.writeValue('hasUnreadNotification', true); // احفظ التغيير
  }

  void clearUnread() {
    hasUnread.value = false;
    prefs.writeValue('hasUnreadNotification', false); // احفظ التغيير
  }

  void loadUnreadState() async {
    final stored = await prefs.readValue('hasUnreadNotification');
    stored == true ? hasUnread.value = true : false;
  }

  Future<void> saveFcmToken() async {
    try {
      final remoteConnectionDio = RemoteConnectionDio();
      final response = await remoteConnectionDio.dio.post(
        Constants.storeTokenApi,
        data: {'fcm_token': fcmToken.value},
      );
    } catch (e) {}
  }
}
