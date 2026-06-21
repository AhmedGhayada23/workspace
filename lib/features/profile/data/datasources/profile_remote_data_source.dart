import 'package:dio/dio.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/features/profile/data/model/profile_data_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileDataModel> getProfile();
  Future<void> logout();
  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  });
  Future<void> editSettings({
    required String name,
    required String type,
    required String email,
    required String mobile,
    String? imagePath,
    bool deleteImage,
  });
  Future<void> editProfile({
    required String aboutMe,
    required String gender,
    required String age,
    required String dob,
    required String universityNumber,
    required String specialty,
    required String university,
    required String address,
    required List<String> documentPaths,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl(this.dio);

  @override
  Future<ProfileDataModel> getProfile() async {
    final response = await dio.get(Constants.profileMeApi);
    if (!_ok(response)) throw const ServerException();
    return ProfileDataModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> logout() async {
    final response = await dio.post(Constants.logoutApi);
    if (!_ok(response)) throw ServerException(_message(response.data));
  }

  @override
  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await dio.post(
      Constants.updatePasswordApi,
      data: {
        'old_password': oldPassword.trim(),
        'password': newPassword.trim(),
        'password_confirmation': confirmPassword.trim(),
      },
    );
    if (!_ok(response)) throw ServerException(_message(response.data));
    return _message(response.data);
  }

  @override
  Future<void> editSettings({
    required String name,
    required String type,
    required String email,
    required String mobile,
    String? imagePath,
    bool deleteImage = false,
  }) async {
    final map = <String, dynamic>{
      'name': name.trim(),
      'type': type,
      'email': email.trim(),
      'mobile': mobile.trim(),
    };
    if (imagePath != null && imagePath.isNotEmpty) {
      map['image'] = await MultipartFile.fromFile(imagePath, filename: _basename(imagePath));
    } else if (deleteImage) {
      // إرسال image فارغة لحذف الصورة الحالية من السيرفر.
      map['image'] = '';
    }
    final response = await dio.post(Constants.settingAccountApi, data: FormData.fromMap(map));
    if (!_ok(response)) throw ServerException(_message(response.data));
  }

  @override
  Future<void> editProfile({
    required String aboutMe,
    required String gender,
    required String age,
    required String dob,
    required String universityNumber,
    required String specialty,
    required String university,
    required String address,
    required List<String> documentPaths,
  }) async {
    // نبني FormData يدوياً لضمان اسم حقل الملفات "documents[]" بالضبط
    // (FormData.fromMap قد يحوّله إلى documents[][] فلا يتعرّف عليه السيرفر).
    final formData = FormData();
    void addIfValid(String key, String value) {
      if (value.trim().isNotEmpty) formData.fields.add(MapEntry(key, value.trim()));
    }

    addIfValid('about_me', aboutMe);
    formData.fields.add(MapEntry('gender', gender)); // مطلوب دائماً
    addIfValid('age', age);
    addIfValid('dob', dob);
    addIfValid('university_number', universityNumber);
    addIfValid('specialty', specialty);
    addIfValid('university', university);
    addIfValid('address', address);

    // المستندات الحالية تأتي كروابط (URL) من السيرفر — نرفع الملفات المحلية الجديدة فقط.
    final newFiles = documentPaths.where((p) => !p.startsWith('http')).toList();
    for (final p in newFiles) {
      formData.files.add(MapEntry(
        'documents[]',
        await MultipartFile.fromFile(
          p,
          filename: _basename(p),
          contentType: DioMediaType('application', 'pdf'),
        ),
      ));
    }

    final response = await dio.post(Constants.editAccountApi, data: formData);
    if (!_ok(response)) throw ServerException(_message(response.data));
  }

  String _basename(String filePath) => filePath.split(RegExp(r'[/\\]')).last;

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
    return 'تم بنجاح';
  }
}
