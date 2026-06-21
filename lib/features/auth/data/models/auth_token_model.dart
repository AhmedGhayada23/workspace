import 'package:workspace/features/auth/domain/entities/auth_token.dart';

/// نموذج التوكن في طبقة الـ data — يعرف كيف يُبنى من JSON.
class AuthTokenModel extends AuthToken {
  const AuthTokenModel({required super.token});

  /// يبني التوكن من جسم الاستجابة: { data: { access_token: "..." } }
  factory AuthTokenModel.fromResponse(Map<String, dynamic> json) {
    final accessToken = json['data']?['access_token']?.toString() ?? '';
    return AuthTokenModel(token: 'Bearer $accessToken');
  }
}
