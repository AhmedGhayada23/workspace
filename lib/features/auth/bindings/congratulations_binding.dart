import 'package:get/get.dart';
import 'package:workspace/features/auth/controllers/congratulations_controller.dart';

class CongratulationsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> CongratulationsController(),fenix: true);
  }
}