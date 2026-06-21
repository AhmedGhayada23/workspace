import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:workspace/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:workspace/features/auth/domain/entities/auth_token.dart';
import 'package:workspace/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthToken>> signIn({
    required String email,
    required String password,
  }) {
    return _guard(() async {
      final model = await remoteDataSource.signIn(email: email, password: password);
      await localDataSource.cacheToken(model.token);
      await localDataSource.cacheUserType('normal');
      return model;
    });
  }

  @override
  Future<Either<Failure, Unit>> register({
    required String name,
    required String type,
    required String email,
    required String mobile,
    required String password,
    required String passwordConfirmation,
  }) {
    return _guard(() async {
      await remoteDataSource.register(
        name: name,
        type: type,
        email: email,
        mobile: mobile,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      await localDataSource.cacheUserType('normal');
      return unit;
    });
  }

  @override
  Future<Either<Failure, AuthToken>> googleLogin({
    required String accessToken,
    required String type,
  }) {
    return _guard(() async {
      final model = await remoteDataSource.googleLogin(accessToken: accessToken, type: type);
      await localDataSource.cacheToken(model.token);
      await localDataSource.cacheUserType('normal');
      return model;
    });
  }

  @override
  Future<Either<Failure, Unit>> sendResetCode(String email) {
    return _guard(() async {
      await remoteDataSource.sendResetCode(email);
      return unit;
    });
  }

  @override
  Future<Either<Failure, AuthToken>> verifyActivationCode({
    required String email,
    required String code,
  }) {
    return _guard(() async {
      final model = await remoteDataSource.verifyActivationCode(email: email, code: code);
      await localDataSource.cacheToken(model.token);
      return model;
    });
  }

  @override
  Future<Either<Failure, Unit>> verifyForgotPasswordCode({
    required String email,
    required String code,
  }) {
    return _guard(() async {
      await remoteDataSource.verifyForgotPasswordCode(email: email, code: code);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String newPassword,
    required String confirmNewPassword,
  }) {
    return _guard(() async {
      await remoteDataSource.resetPassword(
        email: email,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );
      return unit;
    });
  }

  /// يغلّف نداء الشبكة: يتحقق من الاتصال ويحوّل الاستثناءات إلى Failure.
  Future<Either<Failure, T>> _guard<T>(Future<T> Function() body) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      return Right(await body());
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'تعذّر الاتصال بالخادم'));
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
