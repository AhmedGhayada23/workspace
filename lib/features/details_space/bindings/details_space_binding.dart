import 'package:get/get.dart';
import 'package:workspace/features/details_space/controllers/details_space_controller.dart';

class DetailsSpaceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> DetailsSpaceController(),fenix: true);
  }
}
