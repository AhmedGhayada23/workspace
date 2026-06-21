import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/navigation/app_router.dart';
import 'package:workspace/features/notification/presentation/cubit/notification_badge_cubit.dart';
import 'package:workspace/utils/routing.dart';
import '../core/styles/app_colors.dart';
import '../firebase_options.dart';

@pragma('vm:entry-point')
// هذه هي دالة معالجة إشعارات الخلفية (Background) عند تلقي رسالة بينما يكون التطبيق في الخلفية.
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage remoteMessage) async {
  // تأكد من أنك قد قمت بتهيئة Firebase قبل معالجة الرسائل في الخلفية.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print('firebaseMessagingBackgroundHandler: ${remoteMessage.messageId}');
  // يمكن إضافة منطق لحفظ البيانات في التخزين المحلي أو أي عمليات أخرى تتعلق بالإشعار.

  await LocalStorage().writeValue(Constants.unreadNotification, true);
}

// يتم تعريف القناة الخاصة بالإشعارات على Android
late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin localNotificationsPlugin;

mixin FbNotifications {
  /// يتم استدعاؤها في دالة `main` بين `ensureInitialized()` و `runApp()`
  static Future<void> initNotifications() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    if (Platform.isAndroid) {
      channel = const AndroidNotificationChannel(
        'workSpace_flutter_channel',
        'flutter android Notifications Channel',
        description: 'This channel will receive notifications specific to flutter-app',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        ledColor: AppColors.secondary,
        showBadge: true,
        playSound: true,
      );

      localNotificationsPlugin = FlutterLocalNotificationsPlugin();

      // إنشاء القناة
      await localNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      // طلب إذن إشعارات Android 13+
      final granted =
          await localNotificationsPlugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
              ?.requestNotificationsPermission();

      if (granted != null && granted) {
        print('Android Notification Permission Granted');
      } else {
        print('Android Notification Permission Denied');
      }
    }

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // طلب إذن الإشعارات على iOS
  Future<void> requestNotificationPermissions() async {
    NotificationSettings notificationSettings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: false,
      announcement: false,
      provisional: false,
      criticalAlert: false,
    );
    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
      print('GRANT PERMISSION');
    } else if (notificationSettings.authorizationStatus == AuthorizationStatus.denied) {
      print('Permission Denied');
    }
  }

  // التعامل مع إشعارات Foreground على Android
  void initializeForegroundNotificationForAndroid() {
    log('message fica 1');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await LocalStorage().writeValue(Constants.unreadNotification, true);
      sl<NotificationBadgeCubit>().refresh(); // تحديث العدّاد فوراً

      log('message fica 2');
      log('Message Received Type: ${message.messageType}');
      log('Message Received Data: ${message.data}');
      log('Message Received category: ${message.category}');
      log('Message Received from: ${message.from}');
      log('Message Received notification: ${message.notification}');
      log('Message Received senderId: ${message.senderId}');
      log('Message Received: ${message.messageId}');

      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = notification?.android;
      if (notification != null && androidNotification != null) {
        localNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'launcher_icon',
              colorized: true,
            ),
          ),
        );
      }
    });
  }

  // التعامل مع الضغط على الإشعار عندما يكون التطبيق في الواجهة
  void manageNotificationAction() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('onMessageOpenedApp');
      log('messageOnMessageOpenedApp :: ${message.data}');
      log('message.data.toString :: ${message.data.toString()}');
      navigatorKey.currentState?.pushNamed(
        AppRouting.notifcationView,
        arguments: const RouteArgs(),
      );
      // controlNotificationNavigation(message.data);
    });
  }

  // التحكم في التنقل عند الضغط على الإشعار
  static void controlNotificationNavigation(Map<String, dynamic> data) async {
    log('Data Navigation: $data');
    if (data['type'] != null) {
      switch (data['type']) {
        case 'orderWaitingNew':
          var orderWaiting = data['order_id'];
          log('Order Waiting Id: $orderWaiting');
          break;

        case 'link':
          // await _launchUrl(Uri.parse(data['url']));
          print('Navigate to settings');
          break;

        case 'orderWaitingChanging':
          log('order Waiting Changing Id: ${data['order_id']}');
          break;
      }
    }
  }

  // فتح الرابط عند الضغط على "link" في بيانات الإشعار
  // static Future<void> _launchUrl(Uri uri) async {
  //   if (await canLaunchUrl(uri)) {
  //     launchUrl(uri);
  //   }
  // }
}
