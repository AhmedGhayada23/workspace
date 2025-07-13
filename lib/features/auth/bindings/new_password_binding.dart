import 'package:get/get.dart';
import 'package:workspace/features/auth/controllers/new_password_controller.dart';

class NewPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> NewPasswordController(),fenix: true);
  }
}