import 'package:get/get.dart';
import 'package:workspace/features/Home/controllers/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
  Get.lazyPut(()=> HomeController(),fenix: true);
  }
}