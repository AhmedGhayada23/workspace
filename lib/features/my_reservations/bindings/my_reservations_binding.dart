import 'package:get/get.dart';
import 'package:workspace/features/my_reservations/controllers/my_reservations_controller.dart';

class MyReservationsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> MyReservationsController(),fenix: true);
  }

}