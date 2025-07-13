import 'package:get/get.dart';
import 'package:workspace/features/profile/controllers/setting_profile_controller.dart';

class SettingProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> SettingProfileController(),fenix: true);
  }
}