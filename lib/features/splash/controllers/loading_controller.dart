import 'package:get/get.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/utils/routing.dart';

class LoadingController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _decideNextRoute();
  }

  Future<void> _decideNextRoute() async {
    // إعطاء وقت بسيط لإظهار شاشة التحميل بشكل سلس
    await Future.delayed(const Duration(milliseconds: 2200));

    final hasToken = await LocalStorage().readValue(Constants.token) != null;

    if (hasToken) {
      Get.offAllNamed(AppRouting.btnNavView);
    } else {
      Get.offAllNamed(AppRouting.splashView);
    }
  }
}
