/// استثناءات تُرمى من طبقة الـ data (datasources) ثم تُحوّل إلى Failure في الـ repository.
library;

class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'حدث خطأ في الخادم']);
}

class NetworkException implements Exception {
  final String message;
  const NetworkException([this.message = 'لا يوجد اتصال بالإنترنت']);
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'خطأ في التخزين المحلي']);
}

class UnauthorizedException implements Exception {
  final String message;
  const UnauthorizedException([this.message = 'انتهت الجلسة، يرجى تسجيل الدخول مجدداً']);
}
