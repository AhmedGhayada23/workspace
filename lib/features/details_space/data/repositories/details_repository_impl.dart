import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/features/details_space/data/datasources/details_remote_data_source.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';
import 'package:workspace/features/details_space/domain/repositories/details_repository.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  final DetailsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DetailsRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, DetailsSpaceModel>> getDetails(int id) {
    return _guard(() => remoteDataSource.getDetails(id));
  }

  @override
  Future<Either<Failure, Unit>> bookNonProfit(int spaceId) {
    return _guard(() async {
      await remoteDataSource.bookNonProfit(spaceId);
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
