import 'package:get/get.dart';
import 'package:workspace/features/profile/controllers/change_password_controller.dart';

class ChangePasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> ChangepasswordPageController(),fenix: true);
  }
}
