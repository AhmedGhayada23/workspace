import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/notification/domain/entities/notifications_page.dart';
import 'package:workspace/features/notification/domain/repositories/notifications_repository.dart';

class GetNotificationsUseCase implements UseCase<NotificationsPage, int> {
  final NotificationsRepository repository;

  GetNotificationsUseCase(this.repository);

  @override
  Future<Either<Failure, NotificationsPage>> call(int page) {
    return repository.getNotifications(page);
  }
}

class MarkNotificationsReadUseCase implements UseCase<Unit, NoParams> {
  final NotificationsRepository repository;

  MarkNotificationsReadUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return repository.markAllAsRead();
  }
}
