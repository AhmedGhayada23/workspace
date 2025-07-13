import 'package:get/get.dart';
import 'package:workspace/features/search/controllers/search_controller.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> SearchPageContrller(),fenix: true);
  }
}