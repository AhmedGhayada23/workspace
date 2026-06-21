import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';

abstract class BookingRepository {
  Future<Either<Failure, Unit>> confirmProfit({
    required String spaceId,
    required String subscriptionId,
    required String startDate,
    required String endDate,
    required String startTime,
    required String endTime,
    required String seatsCount,
  });
}
