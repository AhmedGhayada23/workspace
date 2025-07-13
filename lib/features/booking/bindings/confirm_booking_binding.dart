import 'package:get/get.dart';
import 'package:workspace/features/booking/controllers/confirm_booking_controller.dart';

class ConfirmBookingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> ConfirmBookingController(),fenix: true);
  }
}