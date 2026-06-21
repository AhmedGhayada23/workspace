import 'package:equatable/equatable.dart';

/// النوع الأساسي للأخطاء الذي يُمرَّر داخل Either<Failure, T> بين الطبقات.
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// خطأ قادم من الخادم (استجابة غير ناجحة أو خطأ 5xx/4xx).
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'حدث خطأ في الخادم']);
}

/// انقطاع الاتصال بالإنترنت.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'لا يوجد اتصال بالإنترنت']);
}

/// خطأ في التخزين المحلي.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'خطأ في التخزين المحلي']);
}

/// انتهاء صلاحية الجلسة (401).
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'انتهت الجلسة، يرجى تسجيل الدخول مجدداً']);
}
