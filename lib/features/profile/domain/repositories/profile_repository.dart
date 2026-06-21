import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/features/profile/data/model/profile_data_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileDataModel>> getProfile();

  Future<Either<Failure, Unit>> logout();

  /// تُعيد رسالة النجاح من الخادم.
  Future<Either<Failure, String>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  });

  /// تعديل إعدادات الحساب (الاسم/النوع/البريد/الهاتف + صورة اختيارية).
  Future<Either<Failure, Unit>> editSettings({
    required String name,
    required String type,
    required String email,
    required String mobile,
    String? imagePath,
    bool deleteImage,
  });

  /// تعديل الملف الشخصي (نبذة/جنس/عمر/تعليم + مستندات PDF).
  Future<Either<Failure, Unit>> editProfile({
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
