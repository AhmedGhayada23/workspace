import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:workspace/core/message/message_snack_bar.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();
  factory NetworkManager() => _instance;
  NetworkManager._internal();

  final Connectivity _connectivity = Connectivity();
  bool _hasShownInitialConnection = false;

  void initListener({Function? onConnected}) {
    _connectivity.onConnectivityChanged.listen((result) {
      final connectionStatus = result.isNotEmpty ? result[0] : ConnectivityResult.wifi;

      log("نتيجة الاتصال: $connectionStatus");

      if (!_hasShownInitialConnection) {
        _hasShownInitialConnection = true;
        if (connectionStatus == ConnectivityResult.none) {
          showCustomSnackBar(Get.context!, "لا يوجد اتصال بالإنترنت", SnackBarType.noConnection);
        }
      } else {
        if (connectionStatus != ConnectivityResult.none) {
          showCustomSnackBar(Get.context!, "تم الاتصال بالإنترنت", SnackBarType.successInterNet);

          // 🔽 نفذ الفنكشن عند الاتصال إذا تم توفيرها
          if (onConnected != null) {
            onConnected();
          }
        } else {
          showCustomSnackBar(Get.context!, "لا يوجد اتصال بالإنترنت", SnackBarType.noConnection);
        }
      }
    });
  }
}
