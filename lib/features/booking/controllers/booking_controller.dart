import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';
import 'package:workspace/utils/routing.dart';

class BookingController extends GetxController {
  late List<dynamic> subscriptions;
  late Spaces spaces;
  RxInt subscriptionId = 0.obs;
  RxString startDate = ''.obs;
  RxString endDate = ''.obs;
  RxString startTime = ''.obs;
  RxBool selectStartTime = false.obs;
  RxString endTime = ''.obs;
  RxBool selectEndTime = false.obs;

  late TextEditingController seatsCountTextEditingController;
  final GlobalKey<FormState> bookingFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    subscriptions = arguments['subscriptions'] as List<dynamic>;
    spaces = arguments['space'] as Spaces;
    seatsCountTextEditingController = TextEditingController();
  }

  bool validateForm() {
    return bookingFormKey.currentState?.validate() ?? false;
  }

  void submitBooking() {
    if (validateForm()) {
      pushDataBooking();
    } else {
      // إظهار رسالة خطأ في حالة وجود مشاكل في النموذج
    }
  }

  void pushDataBooking() {
    Get.toNamed(
      AppRouting.confirmBookingView,
      arguments: spaces,
      parameters: {
        'id': Get.parameters['id'].toString(),
        'nameCompany': Get.parameters['nameCompany'].toString(),
        'imageCompany': Get.parameters['imageCompany'].toString(),
        'address': Get.parameters['address'].toString(),
        'is_profit': Get.parameters['is_profit'].toString(),
        'subscription_id': subscriptionId.value.toString(),
        'startDate': startDate.value,
        'endDate': endDate.value,
        'startTime': startTime.value,
        'endTime': endTime.value,
        'seatsCount': seatsCountTextEditingController.text,
      },
    );
  }

  @override
  void dispose() {
    seatsCountTextEditingController.dispose();
    super.dispose();
  }
}
