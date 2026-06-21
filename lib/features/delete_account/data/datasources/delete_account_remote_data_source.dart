import 'package:dio/dio.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/error/exceptions.dart';

abstract class DeleteAccountRemoteDataSource {
  Future<void> sendCode(String email);
  Future<void> verifyCode({required String email, required String code});
}

class DeleteAccountRemoteDataSourceImpl implements DeleteAccountRemoteDataSource {
  final Dio dio;

  DeleteAccountRemoteDataSourceImpl(this.dio);

  @override
  Future<void> sendCode(String email) async {
    final response = await dio.post(
      Constants.sentCodeForDeleteAccountApi,
      data: {'email': email.trim()},
    );
    if (!_ok(response)) throw ServerException(_message(response.data));
  }

  @override
  Future<void> verifyCode({required String email, required String code}) async {
    final response = await dio.post(
      Constants.chechCodeForDeleteAccountApi,
      data: {'email': email.trim(), 'code': code.trim()},
    );
    if (!_ok(response)) throw ServerException(_message(response.data));
  }

  bool _ok(Response response) =>
      response.statusCode == 200 && response.data['status'] == true;

  String _message(dynamic data) {
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
