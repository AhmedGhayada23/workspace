import 'package:get/get.dart';
import 'package:workspace/features/booking/controllers/booking_controller.dart';

class BookingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> BookingController(),fenix: true);
  }
}