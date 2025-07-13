import 'package:get/get.dart';
import 'package:workspace/features/visitor_profile/controllers/visitor_profile_controller.dart';

class VisitorProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VisitorProfileController());
  }
}
