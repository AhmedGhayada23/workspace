import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/network/network_info.dart';

class ChangepasswordPageController extends GetxController {
  RxBool loading = false.obs;
  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  late TextEditingController oldPasswordChangePasswordTextEditingController;
  late TextEditingController newPasswordChangePasswordTextEditingController;
  late TextEditingController conPasswordChangePasswordTextEditingController;

  RxBool obscureTextold = true.obs;
  RxBool obscureTextnew = true.obs;
  RxBool obscureTextcon = true.obs;

  @override
  void onInit() {
    super.onInit();

    oldPasswordChangePasswordTextEditingController = TextEditingController();
    newPasswordChangePasswordTextEditingController = TextEditingController();
    conPasswordChangePasswordTextEditingController = TextEditingController();
  }

  // دالة للتحقق من صحة النموذج
  bool validateForm() {
    return changePasswordFormKey.currentState?.validate() ?? false;
  }

  void submitChangePassword() {
    if (validateForm()) {
      changePasswordAccount();
    } else {
      // ❌ النموذج غير صحيح
      // Get.snackbar("خطأ", "يرجى التحقق من الحقول", snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> changePasswordAccount() async {
    loading.value = true;
    final networkInfo = NetworkInfoImpl(Connectivity());
    final hasConnection = await networkInfo.isConnected;
    if (!hasConnection) {
      loading.value = false;
      showCustomSnackBar(Get.context!, "لا يوجد اتصال بالإنترنت", SnackBarType.noConnection);
      return; // لازم توقف هنا
    }

    try {
      final remoteConnectionDio = RemoteConnectionDio();
      final response = await remoteConnectionDio.dio.post(
        Constants.updatePasswordApi,
        data: {
          'old_password': oldPasswordChangePasswordTextEditingController.text.trim(),
          'password': newPasswordChangePasswordTextEditingController.text.trim(),
          'password_confirmation': conPasswordChangePasswordTextEditingController.text.trim(),
        },
      );

      if (_isSuccessfulResponse(response)) {
        loading.value = false;

        oldPasswordChangePasswordTextEditingController.clear();
        newPasswordChangePasswordTextEditingController.clear();
        conPasswordChangePasswordTextEditingController.clear();

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
  void dispose() {
    changePasswordFormKey.currentState?.dispose();
    oldPasswordChangePasswordTextEditingController.clear();
    newPasswordChangePasswordTextEditingController.clear();
    conPasswordChangePasswordTextEditingController.clear();
    super.dispose();
  }
}
