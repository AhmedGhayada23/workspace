import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:workspace/core/widgets/type_popup_widget.dart';
import 'package:workspace/features/notification/controllers/fcm_notification_controller.dart';
import 'package:workspace/utils/routing.dart';

class SignInController extends GetxController {
  RxBool loading = false.obs;
  var obscureText = true.obs;
  RxBool isChecked = false.obs;
  var obscureTextpassword = true.obs;
  RxString userType = ''.obs;
  final fcmController = Get.put(FcmNotificationController());

  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>(); // GlobalKey فريدة لـ SignIn

  late TextEditingController emailSignInTextEditingController;
  late TextEditingController passwordSignInTextEditingController;

  bool validateForm() {
    return signInFormKey.currentState?.validate() ?? false;
  }

  void loginRemembar() {
    if (isChecked.value) {
      LocalStorage().writeValue('email', emailSignInTextEditingController.text);
      LocalStorage().writeValue('password', passwordSignInTextEditingController.text);
      LocalStorage().writeValue('remember_me', true);
    } else {
      LocalStorage().removeKey('email');
      LocalStorage().removeKey('password');
      LocalStorage().writeValue('remember_me', false);
    }

    // تابع تسجيل الدخول الحقيقي هنا
  }

  void submitSignIn() {
    if (validateForm()) {
      signInAccount();
    } else {
      // إظهار رسالة خطأ في حالة وجود مشاكل في النموذج
    }
  }

  Future<void> signInAccount() async {
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
        Constants.loginApi,
        data: {
          'email': emailSignInTextEditingController.text.trim(),
          'password': passwordSignInTextEditingController.text.trim(),
        },
      );

      if (_isSuccessfulResponse(response)) {
        loading.value = false;

        // حفظ التوكن
        final localStorage = LocalStorage();
        await localStorage.writeValue(
          Constants.token,
          'Bearer ${response.data['data']['access_token']}',
        );
        LocalStorage().writeValue(Constants.userType, 'normal');

        loginRemembar(); // حفظ بيانات الدخول إذا لزم
        fcmController.saveFcmToken();
        // الانتقال إلى الشاشة الرئيسية
        Get.offAllNamed(AppRouting.btnNavView);
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

  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // ✅ بعد تسجيل الدخول بنجاح عبر Firebase
      final email = userCredential.user?.email;

      if (email != null) {
        log('Access Token :: ${googleAuth.accessToken}');
        showCustomPopup(Get.context!, () {
          loginWitGoogleApi(googleAuth.accessToken.toString(), userType.value);
        });
        // await _sendGoogleLoginToApi(email);
      }

      return userCredential;
    } catch (e) {
      print('Google Sign-In error: $e');
      return null;
    }
  }

  Future<void> loginWitGoogleApi(String accessToken, String userType) async {
    final networkInfo = NetworkInfoImpl(Connectivity());
    final hasConnection = await networkInfo.isConnected;
    if (!hasConnection) {
      showCustomSnackBar(Get.context!, "لا يوجد اتصال بالإنترنت", SnackBarType.noConnection);
      return; // لازم توقف هنا
    }

    try {
      final remoteConnectionDio = RemoteConnectionDio();
      final response = await remoteConnectionDio.dio.post(
        Constants.googleLoginApi,
        data: {'google_access_token': accessToken, 'type': userType},
      );

      if (_isSuccessfulResponse(response)) {
        LocalStorage().writeValue(Constants.userType, 'normal');
        // حفظ التوكن
        final localStorage = LocalStorage();
        await localStorage.writeValue(
          Constants.token,
          'Bearer ${response.data['data']['access_token']}',
        );

        // الانتقال إلى الشاشة الرئيسية
        Get.offAllNamed(AppRouting.btnNavView);
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

  @override
  void onInit() {
    super.onInit();
    emailSignInTextEditingController = TextEditingController();
    passwordSignInTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    emailSignInTextEditingController.dispose();
    passwordSignInTextEditingController.dispose();
    super.dispose();
  }
}
