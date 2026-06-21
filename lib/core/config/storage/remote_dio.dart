import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_router.dart';
import 'package:workspace/utils/routing.dart';

class RemoteConnectionDio {
  late Dio _dio;

  static RemoteConnectionDio? _instance;

  RemoteConnectionDio._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        validateStatus: (_) => true,
        receiveTimeout: const Duration(seconds: Constants.receiveTimeout),
        connectTimeout: const Duration(seconds: Constants.connectionTimeout),
        headers: {
          'Accept': 'application/json',
          'Authorization': LocalStorage().readValue<String>(Constants.token),
          'lang': LocalStorage().readValue('lang') ?? 'ar',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) {


          handler.next(e);
          DioExceptions.fromDioError(e).toString();
        },
        onResponse: (e, handler) {
          log(e.toString());

          if (e.statusCode == 401) {
            LocalStorage().removeKey(Constants.token);
            // تنفيذ إجراء عند ظهور 401
            log('Unauthorized - 401');
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              AppRouting.signInView,
              (_) => false,
              arguments: const RouteArgs(),
            );
            showCustomSnackBar(
              navigatorKey.currentContext!,
              'انتهت الجسلة يرجى تسجيل الدخول مجددًا',
              SnackBarType.warning,
            );
          }

          handler.next(e);
        },
        onRequest: (options, handler) {
          log('${LocalStorage().readValue<String>(Constants.token)}');
          if (LocalStorage().readValue<String>(Constants.token) != null) {
            log('${LocalStorage().readValue<String>(Constants.token)}');

            options.headers.addAll({
              'Accept': 'application/json',
              'Authorization': LocalStorage().readValue<String>(Constants.token),
              'lang': LocalStorage().readValue('lang') ?? 'ar',
            });
          }
          handler.next(options);
        },
      ),
    );
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 30,
      ),
    );
  }

  factory RemoteConnectionDio() {
    return _instance ??= RemoteConnectionDio._();
  }

  Dio get dio => _dio;
}
