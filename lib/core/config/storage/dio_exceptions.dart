import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/utils/routing.dart';

class DioExceptions implements Exception {
  final String message;

  DioExceptions._(this.message);

  factory DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return DioExceptions._("تم إلغاء الطلب إلى الخادم");
      case DioExceptionType.connectionTimeout:
        return DioExceptions._("انتهت مهلة الاتصال بالخادم");
      case DioExceptionType.receiveTimeout:
        return DioExceptions._("انتهت مهلة الاستجابة من الخادم");
      case DioExceptionType.sendTimeout:
        return DioExceptions._("انتهت مهلة إرسال البيانات إلى الخادم");
      case DioExceptionType.badCertificate:
        return DioExceptions._("شهادة غير صالحة");
      case DioExceptionType.connectionError:
        return DioExceptions._("خطأ في الاتصال بالخادم");
      case DioExceptionType.unknown:
        if (dioError.message?.contains("SocketException") == true) {
          return DioExceptions._("لا يوجد اتصال بالإنترنت");
        }
        return DioExceptions._("حدث خطأ غير متوقع");
      case DioExceptionType.badResponse:
        return DioExceptions._(
          _handleError(dioError.response?.statusCode, dioError.response?.data),
        );
      default:
        return DioExceptions._("حدث خطأ غير متوقع");
    }
  }

  static String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'طلب غير صالح';
      case 401:
        return 'غير مصرح، يرجى تسجيل الدخول مجددًا';
      case 403:
        return 'تم الرفض، ليس لديك صلاحيات';
      case 404:
        return error['message'] ?? 'العنصر غير موجود';
      case 500:
        return error['message'] ?? 'خطأ داخلي في الخادم';
      case 502:
        return 'البوابة غير صالحة';
      default:
        return 'حدث خطأ غير معروف من الخادم';
    }
  }

  @override
  String toString() => message;
}
