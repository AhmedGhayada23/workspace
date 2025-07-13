import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:dio/dio.dart' as dio;

class RatingController extends GetxController {
  RxBool loading = false.obs;
  late TextEditingController noteTextEditingController;
  RxList<Map<String, String>> evaluations = <Map<String, String>>[].obs;

  Future submitRatings(String id) async {
    loading.value = true;
    RemoteConnectionDio remoteConnectionDio = RemoteConnectionDio();

    final networkInfo = NetworkInfoImpl(Connectivity());
    final hasConnection = await networkInfo.isConnected;
    if (!hasConnection) {
      loading.value = false;
      showCustomSnackBar(Get.context!, "لا يوجد اتصال بالإنترنت", SnackBarType.noConnection);
      return; // لازم توقف هنا
    }

    try {
      dio.Response response = await remoteConnectionDio.dio.post(
        Constants.ratingApi,
        data: {
          'evaluations': evaluations,
          'message': noteTextEditingController.text,
          'reservation_id': id,
        },
      );

      if (_isSuccessfulResponse(response)) {
         noteTextEditingController.clear();
        evaluations.value = [];
        loading.value = false;
        Get.back();
        showCustomSnackBar(Get.context!, 'شكرا على تقيمك', SnackBarType.success);
      } else {
        Get.back();
        loading.value = false;
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
        noteTextEditingController.clear();
        evaluations.value = [];
      }
    } catch (e) {
      loading.value = false;
      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    }
  }

  bool _isSuccessfulResponse(dio.Response response) {
    return response.statusCode == 200 && response.data['status'] == true;
  }

  @override
  void onInit() {
    noteTextEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    noteTextEditingController.dispose();
    noteTextEditingController.clear();
    evaluations.value = [];
    super.dispose();
  }
}
