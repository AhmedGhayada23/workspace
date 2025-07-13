import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:dio/dio.dart' as dio;
import 'package:workspace/core/widgets/booking_success_popup_widget.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';


class ConfirmBookingController extends GetxController {
  RxBool loadingProfit = false.obs;

 late Spaces spaces;

  String formatDate(String dateString) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(dateString);
    return '${date.day}-${date.month}-${date.year}'; // النتيجة: 11-5-2025
  }




  Future<void> confirmBookingProfit() async {
    log('message');
    loadingProfit.value = true;
    RemoteConnectionDio remoteConnectionDio = RemoteConnectionDio();

    final networkInfo = NetworkInfoImpl(Connectivity());
    final hasConnection = await networkInfo.isConnected;
    if (!hasConnection) {
      log('mess');
      loadingProfit.value = false;
      showCustomSnackBar(Get.context!, "لا يوجد اتصال بالإنترنت", SnackBarType.noConnection);
      return; // لازم توقف هنا
    }
    log('messs');
    try {
      log('messssss');
      dio.Response response = await remoteConnectionDio.dio.post(
        Constants.reservationsApi,
        data: {
          'space_id': Get.parameters['id'].toString(),
          'is_profit': 'true',
          'subscription_id': Get.parameters['subscription_id'].toString(),
          'start_date': Get.parameters['startDate'],
          'end_date': Get.parameters['endDate'],
          'start_time': Get.parameters['startTime'].toString(),
          'end_time': Get.parameters['endTime'].toString(),
          'seats_count': Get.parameters['seatsCount'].toString(),
        },
      );
      log('messssssa');
      if (_isSuccessfulResponse(response)) {
        loadingProfit.value = false;

        showBookingSuccessPopup();
      } else {
        loadingProfit.value = false;
        final message = response.data['message'];
        String messageText = "حدث خطأ غير متوقع";

        if (message is Map) {
          messageText = message.entries
              .map((entry) => entry.value is List ? entry.value.join("\n") : entry.value.toString())
              .join("\n");
          showCustomSnackBar(Get.context!, messageText, SnackBarType.error);
        } else if (message is List) {
          messageText = message.join("\n");
          showCustomSnackBar(Get.context!, messageText, SnackBarType.error);
        } else if (message is String) {
          messageText = message;
          showCustomSnackBar(Get.context!, messageText, SnackBarType.error);
        }
      }
    } catch (e) {
      loadingProfit.value = false;
      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    }
  }





  bool _isSuccessfulResponse(dio.Response response) {
    return response.statusCode == 200 && response.data['status'] == true;
  }

void showBookingSuccessPopup() {
  showDialog(
    context: Get.context!,
    builder: (_) => const BookingSuccessPopup(),
  );
}

  @override
  void onInit() {

    spaces =  Get.arguments as Spaces;

    super.onInit();
  }
}
