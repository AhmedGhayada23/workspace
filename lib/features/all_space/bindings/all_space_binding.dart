import 'package:get/get.dart';
import 'package:workspace/features/all_space/controllers/all_space_controller.dart';

class AllSpaceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> AllSpaceController(),fenix: true);
  }
}