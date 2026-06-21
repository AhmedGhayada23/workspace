import 'package:dio/dio.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/features/auth/data/models/auth_token_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthTokenModel> signIn({required String email, required String password});

  Future<void> register({
    required String name,
    required String type,
    required String email,
    required String mobile,
    required String password,
    required String passwordConfirmation,
  });

  Future<AuthTokenModel> googleLogin({required String accessToken, required String type});

  Future<void> sendResetCode(String email);

  Future<AuthTokenModel> verifyActivationCode({required String email, required String code});

  Future<void> verifyForgotPasswordCode({required String email, required String code});

  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String confirmNewPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<AuthTokenModel> signIn({required String email, required String password}) async {
    final response = await dio.post(
      Constants.loginApi,
      data: {'email': email.trim(), 'password': password.trim()},
    );
    _ensureSuccess(response);
    return AuthTokenModel.fromResponse(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> register({
    required String name,
    required String type,
    required String email,
    required String mobile,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await dio.post(
      Constants.registerApi,
      data: {
        'name': name.trim(),
        'type': type,
        'email': email.trim(),
        'mobile': mobile.trim(),
        'password': password.trim(),
        'password_confirmation': passwordConfirmation.trim(),
      },
    );
    _ensureSuccess(response);
  }

  @override
  Future<AuthTokenModel> googleLogin({required String accessToken, required String type}) async {
    final response = await dio.post(
      Constants.googleLoginApi,
      data: {'google_access_token': accessToken, 'type': type},
    );
    _ensureSuccess(response);
    return AuthTokenModel.fromResponse(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> sendResetCode(String email) async {
    final response = await dio.post(
      Constants.forgetPasswordSendCodeApi,
      data: {'email': email.trim()},
    );
    _ensureSuccess(response);
  }

  @override
  Future<AuthTokenModel> verifyActivationCode({required String email, required String code}) async {
    final response = await dio.post(
      Constants.checkCodeActiveApi,
      data: {'code': code, 'email': email},
    );
    _ensureSuccess(response);
    return AuthTokenModel.fromResponse(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> verifyForgotPasswordCode({required String email, required String code}) async {
    final response = await dio.post(
      Constants.checkCodeForgetPasswordApi,
      data: {'code': code, 'email': email},
    );
    _ensureSuccess(response);
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final response = await dio.post(
      Constants.forgetPasswordResetPasswordApi,
      data: {
        'new_password': newPassword.trim(),
        'confirm_new_password': confirmNewPassword.trim(),
        'email': email,
      },
    );
    _ensureSuccess(response);
  }

  /// يتحقق من نجاح الاستجابة وإلا يرمي [ServerException] برسالة مفهومة.
  void _ensureSuccess(Response response) {
    final isSuccess = response.statusCode == 200 && response.data['status'] == true;
    if (isSuccess) return;
    if (response.statusCode == 401) {
      throw const UnauthorizedException();
    }
    throw ServerException(_extractMessage(response.data));
  }

  String _extractMessage(dynamic data) {
    final message = (data is Map) ? data['message'] : null;
    if (message is Map) {
      return message.entries
          .map((e) => e.value is List ? (e.value as List).join('\n') : e.value.toString())
          .join('\n');
    } else if (message is List) {
      return message.join('\n');
    } else if (message is String) {
      return message;
    }
    return 'حدث خطأ غير متوقع';
  }
}
