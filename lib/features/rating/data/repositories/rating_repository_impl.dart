import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/features/rating/data/datasources/rating_remote_data_source.dart';
import 'package:workspace/features/rating/domain/repositories/rating_repository.dart';

class RatingRepositoryImpl implements RatingRepository {
  final RatingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RatingRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, String>> submitRating({
    required int reservationId,
    required Map<String, int> evaluations,
    required String message,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final result = await remoteDataSource.submitRating(
        reservationId: reservationId,
        evaluations: evaluations,
        message: message,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'تعذّر الاتصال بالخادم'));
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
