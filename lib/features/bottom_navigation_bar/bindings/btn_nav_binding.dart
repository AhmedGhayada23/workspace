import 'package:get/get.dart';
import 'package:workspace/features/bottom_navigation_bar/controllers/btn_nav_controller.dart';

class BtnNavBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> BtnNavController(),fenix: true);
  }
}