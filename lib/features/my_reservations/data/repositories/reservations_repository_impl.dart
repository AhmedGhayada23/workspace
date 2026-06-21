import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/features/my_reservations/data/datasources/reservations_remote_data_source.dart';
import 'package:workspace/features/my_reservations/data/models/details_resevation_model.dart';
import 'package:workspace/features/my_reservations/domain/entities/reservations_page.dart';
import 'package:workspace/features/my_reservations/domain/repositories/reservations_repository.dart';

class ReservationsRepositoryImpl implements ReservationsRepository {
  final ReservationsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ReservationsRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, ReservationsPage>> getReservations({
    required int page,
    required int statusTypeId,
  }) {
    return _guard(() => remoteDataSource.getReservations(page: page, statusTypeId: statusTypeId));
  }

  @override
  Future<Either<Failure, Unit>> cancel(int reservationId) {
    return _guard(() async {
      await remoteDataSource.cancel(reservationId);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> reReserve(int reservationId) {
    return _guard(() async {
      await remoteDataSource.reReserve(reservationId);
      return unit;
    });
  }

  @override
  Future<Either<Failure, DetailsResevationModel>> getDetails(int reservationId) {
    return _guard(() => remoteDataSource.getDetails(reservationId));
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
