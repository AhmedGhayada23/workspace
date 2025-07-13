import 'package:get/get.dart';
import 'package:workspace/features/notification/controllers/notifcation_controller.dart';

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(()=>NotifcationController(),fenix: true);
  }
}