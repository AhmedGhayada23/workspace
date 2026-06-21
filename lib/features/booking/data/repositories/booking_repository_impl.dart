import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:workspace/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BookingRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> confirmProfit({
    required String spaceId,
    required String subscriptionId,
    required String startDate,
    required String endDate,
    required String startTime,
    required String endTime,
    required String seatsCount,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      await remoteDataSource.confirmProfit(
        spaceId: spaceId,
        subscriptionId: subscriptionId,
        startDate: startDate,
        endDate: endDate,
        startTime: startTime,
        endTime: endTime,
        seatsCount: seatsCount,
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'تعذّر الاتصال بالخادم'));
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
