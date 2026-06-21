import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/features/notification/domain/entities/notifications_page.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, NotificationsPage>> getNotifications(int page);
  Future<Either<Failure, Unit>> markAllAsRead();
}
