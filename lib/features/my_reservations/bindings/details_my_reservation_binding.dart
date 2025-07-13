import 'package:get/get.dart';
import 'package:workspace/features/my_reservations/controllers/details_my_reservation.dart';

class DetailsMyReservationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> DetailsMyResevationController(),fenix: true);
  }
} 