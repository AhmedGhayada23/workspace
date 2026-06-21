import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_router.dart';

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
          showCustomSnackBar(navigatorKey.currentContext!, "لا يوجد اتصال بالإنترنت", SnackBarType.noConnection);
        }
      } else {
        if (connectionStatus != ConnectivityResult.none) {
          showCustomSnackBar(navigatorKey.currentContext!, "تم الاتصال بالإنترنت", SnackBarType.successInterNet);

          // 🔽 نفذ الفنكشن عند الاتصال إذا تم توفيرها
          if (onConnected != null) {
            onConnected();
          }
        } else {
          showCustomSnackBar(navigatorKey.currentContext!, "لا يوجد اتصال بالإنترنت", SnackBarType.noConnection);
        }
      }
    });
  }
}
