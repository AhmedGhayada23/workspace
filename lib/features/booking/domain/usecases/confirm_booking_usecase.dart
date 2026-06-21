import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/booking/domain/repositories/booking_repository.dart';

class ConfirmBookingUseCase implements UseCase<Unit, ConfirmBookingParams> {
  final BookingRepository repository;

  ConfirmBookingUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ConfirmBookingParams params) {
    return repository.confirmProfit(
      spaceId: params.spaceId,
      subscriptionId: params.subscriptionId,
      startDate: params.startDate,
      endDate: params.endDate,
      startTime: params.startTime,
      endTime: params.endTime,
      seatsCount: params.seatsCount,
    );
  }
}

class ConfirmBookingParams extends Equatable {
  final String spaceId;
  final String subscriptionId;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String seatsCount;

  const ConfirmBookingParams({
    required this.spaceId,
    required this.subscriptionId,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.seatsCount,
  });

  factory ConfirmBookingParams.fromMap(Map<String, String> p) {
    return ConfirmBookingParams(
      spaceId: p['id'] ?? '',
      subscriptionId: p['subscription_id'] ?? '',
      startDate: p['startDate'] ?? '',
      endDate: p['endDate'] ?? '',
      startTime: p['startTime'] ?? '',
      endTime: p['endTime'] ?? '',
      seatsCount: p['seatsCount'] ?? '',
    );
  }

  @override
  List<Object?> get props =>
      [spaceId, subscriptionId, startDate, endDate, startTime, endTime, seatsCount];
}
