import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/features/my_reservations/data/models/details_resevation_model.dart';
import 'package:workspace/features/my_reservations/domain/entities/reservations_page.dart';

abstract class ReservationsRepository {
  /// [statusTypeId] 0 = الكل، وإلا يُرسَل كفلتر.
  Future<Either<Failure, ReservationsPage>> getReservations({
    required int page,
    required int statusTypeId,
  });

  Future<Either<Failure, Unit>> cancel(int reservationId);
  Future<Either<Failure, Unit>> reReserve(int reservationId);
  Future<Either<Failure, DetailsResevationModel>> getDetails(int reservationId);
}
