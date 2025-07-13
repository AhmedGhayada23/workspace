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
import 'package:workspace/utils/routing.dart';

class SignUpController extends GetxController {
  RxBool loading = false.obs;
  var obscureTextpassword = true.obs;
  var obscureTextconfirmpassword = true.obs;
  RxString types = ''.obs;
  RxString userType = ''.obs;

  final Map<String, String> userTypes = {
    'طالب': 'student',
    'موظف': 'employee',
    'مستقل': 'independent',
    'شركة': 'company',
  };
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>(); // GlobalKey فريدة لـ SignUp

  final FocusNode nextFieldFocus = FocusNode();
  late TextEditingController fullNameRegisterTextEditingController;
  late TextEditingController phoneRegisterTextEditingController;
  late TextEditingController emailRegisterTextEditingController;
  late TextEditingController passwordRegisterTextEditingController;
  late TextEditingController confirmRegisterTextEditingController;

  bool validateForm() {
    return registerFormKey.currentState?.validate() ?? false;
  }

  void submitRegister() {
    if (validateForm()) {
      registerAccount();
    } else {
      // إظهار رسالة خطأ في حالة وجود مشاكل في النموذج
    }
  }

  Future<void> registerAccount() async {
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
        Constants.registerApi,
        data: {
          'name': fullNameRegisterTextEditingController.text.trim(),
          'type': types.value,
          'email': emailRegisterTextEditingController.text.trim(),
          'mobile': phoneRegisterTextEditingController.text.trim(),
          'password': passwordRegisterTextEditingController.text.trim(),
          'password_confirmation': confirmRegisterTextEditingController.text.trim(),
        },
      );

      if (_isSuccessfulResponse(response)) {
        loading.value = false;

        Get.offAllNamed(AppRouting.otpView, parameters: {
          'email': emailRegisterTextEditingController.text,
          'new': 'true',
        });
        LocalStorage().writeValue(Constants.userType, 'normal');
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

  // login with google

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
        log('Access Token sign up :: ${googleAuth.accessToken}');
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

  // login with google and req api server
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

  bool _isSuccessfulResponse(dio.Response response) {
    return response.statusCode == 200 && response.data['status'] == true;
  }

  @override
  void onInit() {
    super.onInit();
    fullNameRegisterTextEditingController = TextEditingController();
    phoneRegisterTextEditingController = TextEditingController();
    emailRegisterTextEditingController = TextEditingController();
    passwordRegisterTextEditingController = TextEditingController();
    confirmRegisterTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameRegisterTextEditingController.dispose();
    phoneRegisterTextEditingController.dispose();
    emailRegisterTextEditingController.dispose();
    passwordRegisterTextEditingController.dispose();
    confirmRegisterTextEditingController.dispose();
    nextFieldFocus.dispose();
    super.dispose();
  }
}
