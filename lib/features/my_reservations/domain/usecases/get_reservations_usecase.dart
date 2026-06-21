import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/my_reservations/domain/entities/reservations_page.dart';
import 'package:workspace/features/my_reservations/domain/repositories/reservations_repository.dart';

class GetReservationsUseCase implements UseCase<ReservationsPage, ReservationsParams> {
  final ReservationsRepository repository;

  GetReservationsUseCase(this.repository);

  @override
  Future<Either<Failure, ReservationsPage>> call(ReservationsParams params) {
    return repository.getReservations(page: params.page, statusTypeId: params.statusTypeId);
  }
}

class ReservationsParams extends Equatable {
  final int page;
  final int statusTypeId;

  const ReservationsParams({required this.page, required this.statusTypeId});

  @override
  List<Object?> get props => [page, statusTypeId];
}
