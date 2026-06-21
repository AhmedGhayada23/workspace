import 'package:workspace/utils/fb_notifications.dart';

/// خدمة إشعارات تغلّف الـ mixin [FbNotifications] لتُحقن وتُستدعى من الـ Cubits
/// بدل وضع المنطق داخل وحدة تحكّم منفصلة.
class NotificationService with FbNotifications {}
