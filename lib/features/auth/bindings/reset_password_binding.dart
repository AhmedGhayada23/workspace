import 'package:get/get.dart';
import 'package:workspace/features/auth/controllers/reset_password_controller.dart';

class ResetPasswordBiding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(()=> ResetPasswordController(),fenix: true);
  }
}