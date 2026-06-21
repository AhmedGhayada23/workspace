import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/features/auth/data/datasources/google_auth_service.dart';
import 'package:workspace/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:workspace/features/profile/data/model/profile_data_model.dart';
import 'package:workspace/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final LocalStorage localStorage;
  final GoogleAuthService googleAuthService;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localStorage,
    required this.googleAuthService,
  });

  @override
  Future<Either<Failure, ProfileDataModel>> getProfile() {
    return _guard(() => remoteDataSource.getProfile());
  }

  @override
  Future<Either<Failure, Unit>> logout() {
    return _guard(() async {
      await remoteDataSource.logout();
      await googleAuthService.signOut(); // إنهاء جلسة Google/Firebase
      await localStorage.removeKey(Constants.token);
      // مسح بيانات خاصة بالحساب السابق حتى لا يرثها الحساب التالي.
      await localStorage.removeKey(Constants.unreadNotification);
      return unit;
    });
  }

  @override
  Future<Either<Failure, String>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    return _guard(() => remoteDataSource.changePassword(
          oldPassword: oldPassword,
          newPassword: newPassword,
          confirmPassword: confirmPassword,
        ));
  }

  @override
  Future<Either<Failure, Unit>> editSettings({
    required String name,
    required String type,
    required String email,
    required String mobile,
    String? imagePath,
    bool deleteImage = false,
  }) {
    return _guard(() async {
      await remoteDataSource.editSettings(
        name: name,
        type: type,
        email: email,
        mobile: mobile,
        imagePath: imagePath,
        deleteImage: deleteImage,
      );
      return unit;
    });
  }

  @override
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
  }) {
    return _guard(() async {
      await remoteDataSource.editProfile(
        aboutMe: aboutMe,
        gender: gender,
        age: age,
        dob: dob,
        universityNumber: universityNumber,
        specialty: specialty,
        university: university,
        address: address,
        documentPaths: documentPaths,
      );
      return unit;
    });
  }

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() body) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      return Right(await body());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'تعذّر الاتصال بالخادم'));
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
