import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/features/notification/data/datasources/notifications_remote_data_source.dart';
import 'package:workspace/features/notification/domain/entities/notifications_page.dart';
import 'package:workspace/features/notification/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NotificationsRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, NotificationsPage>> getNotifications(int page) {
    return _guard(() => remoteDataSource.getNotifications(page));
  }

  @override
  Future<Either<Failure, Unit>> markAllAsRead() {
    return _guard(() async {
      await remoteDataSource.markAllAsRead();
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
