import 'package:get/get.dart';
import 'package:workspace/features/visitor_home/controllers/visitor_home_controller.dart';

class VisitorHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VisitorHomeController());
  }
}
