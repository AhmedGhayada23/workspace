import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/features/delete_account/data/datasources/delete_account_remote_data_source.dart';
import 'package:workspace/features/delete_account/domain/repositories/delete_account_repository.dart';

class DeleteAccountRepositoryImpl implements DeleteAccountRepository {
  final DeleteAccountRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DeleteAccountRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> sendCode(String email) {
    return _guard(() async {
      await remoteDataSource.sendCode(email);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> verifyCode({required String email, required String code}) {
    return _guard(() async {
      await remoteDataSource.verifyCode(email: email, code: code);
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
