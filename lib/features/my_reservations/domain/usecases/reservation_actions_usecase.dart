import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/my_reservations/data/models/details_resevation_model.dart';
import 'package:workspace/features/my_reservations/domain/repositories/reservations_repository.dart';

class CancelReservationUseCase implements UseCase<Unit, int> {
  final ReservationsRepository repository;
  CancelReservationUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(int id) => repository.cancel(id);
}

class ReReserveUseCase implements UseCase<Unit, int> {
  final ReservationsRepository repository;
  ReReserveUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(int id) => repository.reReserve(id);
}

class GetReservationDetailsUseCase implements UseCase<DetailsResevationModel, int> {
  final ReservationsRepository repository;
  GetReservationDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, DetailsResevationModel>> call(int id) => repository.getDetails(id);
}
