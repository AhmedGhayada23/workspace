import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/utils/routing.dart';
import 'package:dio/dio.dart' as dio;

class DeleteAccountSentOtpController extends GetxController {
  RxBool loading = false.obs;
  final GlobalKey<FormState> deleteAccountFormKey = GlobalKey<FormState>();
  late TextEditingController emaildeleteAccountTextEditingController;

  @override
  void onInit() {
    super.onInit();
    emaildeleteAccountTextEditingController = TextEditingController();
  }

  // دالة للتحقق من صحة النموذج
  bool validateForm() {
    return deleteAccountFormKey.currentState?.validate() ?? false;
  }

  void submitDeleteAccount() {
    if (validateForm()) {
      // ✅ النموذج صحيح
      sentCodeForDeleteAccountAccount();
    } else {
      // ❌ النموذج غير صحيح
      // Get.snackbar("خطأ", "يرجى التحقق من الحقول", snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> sentCodeForDeleteAccountAccount() async {
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
        Constants.sentCodeForDeleteAccountApi,
        data: {'email': emaildeleteAccountTextEditingController.text},
      );

      if (_isSuccessfulResponse(response)) {
        Get.toNamed(AppRouting.deleteAccountVerificationCodeView,parameters: {
          'email' : emaildeleteAccountTextEditingController.text,
        });
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

  bool _isSuccessfulResponse(dio.Response response) {
    return response.statusCode == 200 && response.data['status'] == true;
  }

  @override
  void dispose() {
    super.dispose();
    deleteAccountFormKey.currentState?.dispose();
    emaildeleteAccountTextEditingController.clear();
  }
}
