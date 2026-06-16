import 'package:get/get.dart';
import 'package:workspace/features/splash/controllers/loading_controller.dart';

class LoadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoadingController());
  }
}
