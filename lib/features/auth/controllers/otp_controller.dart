import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/features/notification/controllers/fcm_notification_controller.dart';
import 'package:workspace/utils/routing.dart';
import 'package:dio/dio.dart' as dio;

class OTPController extends GetxController {
  RxBool loading = false.obs;
  RxInt secondsRemaining = 60.obs;
  RxBool canResend = false.obs;
  Timer? timer;
  RxString code = ''.obs;
  final fcmController = Get.put(FcmNotificationController());
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    startCountdown();
  }

  // دالة للتحقق من صحة النموذج
  bool validateForm() {
    return otpFormKey.currentState?.validate() ?? false;
  }

  void submitOtpCode() {
    if (validateForm()) {
      // ✅ النموذج صحيح
      checkCodeAccount();
    } else {
      // ❌ النموذج غير صحيح
      // Get.snackbar("خطأ", "يرجى التحقق من الحقول", snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> checkCodeAccount() async {
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
        Get.parameters['new'] == 'true'
            ? Constants.checkCodeActiveApi
            : Constants.checkCodeForgetPasswordApi,
        data: {'code': code.value, 'email': Get.parameters['email']},
      );

      if (_isSuccessfulResponse(response)) {
        loading.value = false;
        if (Get.parameters['new'] == 'true') {
          final localStorage = LocalStorage();
          await localStorage.writeValue(
            Constants.token,
            'Bearer ${response.data['data']['access_token']}',
          );
          fcmController.saveFcmToken();
          Get.offNamed(AppRouting.btnNavView);
        } else {
          Get.offNamed(
            AppRouting.newPassordView,
            parameters: {'email': Get.parameters['email'].toString()},
          );
        }
      } else {
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
      }
    } catch (e) {
      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    }
  }

  Future<void> resetCodeAccount() async {
    RemoteConnectionDio remoteConnectionDio = RemoteConnectionDio();

    final networkInfo = NetworkInfoImpl(Connectivity());
    final hasConnection = await networkInfo.isConnected;
    if (!hasConnection) {
      showCustomSnackBar(Get.context!, "لا يوجد اتصال بالإنترنت", SnackBarType.noConnection);
      return; // لازم توقف هنا
    }

    try {
      dio.Response response = await remoteConnectionDio.dio.post(
        Constants.forgetPasswordSendCodeApi,
        data: {'email': Get.parameters['email']},
      );

      if (_isSuccessfulResponse(response)) {
        final message = response.data['message'];
        String messageText = "حدث خطأ غير متوقع";

        if (message is Map) {
          messageText = message.entries
              .map((entry) => entry.value is List ? entry.value.join("\n") : entry.value.toString())
              .join("\n");
          showCustomSnackBar(Get.context!, messageText, SnackBarType.success);
        } else if (message is List) {
          messageText = message.join("\n");
          showCustomSnackBar(Get.context!, messageText, SnackBarType.success);
        } else if (message is String) {
          messageText = message;
          showCustomSnackBar(Get.context!, messageText, SnackBarType.success);
        }

        startCountdown();
      } else {
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
      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    }
  }

  bool _isSuccessfulResponse(dio.Response response) {
    return response.statusCode == 200 && response.data['status'] == true;
  }

  void startCountdown() {
    secondsRemaining.value = 60;
    canResend.value = false;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value == 0) {
        canResend.value = true;
        timer.cancel();
      } else {
        secondsRemaining.value--;
      }
    });
  }

  void resendCode() {
    if (!canResend.value) return;

    // هنا يتم تنفيذ إعادة إرسال الكود
    print("🔁 تم إرسال الكود");

    startCountdown(); // يعيد تشغيل العد
  }

  String get formattedTime {
    final minutes = secondsRemaining.value ~/ 60;
    final seconds = secondsRemaining.value % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    otpFormKey.currentState?.dispose();
    timer?.cancel();
    super.onClose();
  }
}
