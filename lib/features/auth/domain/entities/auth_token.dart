import 'package:equatable/equatable.dart';

/// كيان توكن المصادقة (يُمرَّر بين الطبقات بدون تفاصيل JSON).
class AuthToken extends Equatable {
  final String token;

  const AuthToken({required this.token});

  @override
  List<Object?> get props => [token];
}
