import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/features/Home/data/datasources/home_remote_data_source.dart';
import 'package:workspace/features/Home/domain/entities/home_profile.dart';
import 'package:workspace/features/Home/domain/entities/main_page.dart';
import 'package:workspace/features/Home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, MainPage>> getMainPage(String? filterProfit) {
    return _guard(() => remoteDataSource.getMainPage(filterProfit));
  }

  @override
  Future<Either<Failure, HomeProfile>> getProfileHeader() {
    return _guard(() => remoteDataSource.getProfileHeader());
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
