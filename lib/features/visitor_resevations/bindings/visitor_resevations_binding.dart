import 'package:get/get.dart';
import 'package:workspace/features/visitor_resevations/controllers/visitor_resevations_controller.dart';

class VisitorResevationsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VisitorResevationsController());
  }
}
