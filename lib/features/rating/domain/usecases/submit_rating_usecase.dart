import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/rating/domain/repositories/rating_repository.dart';

class SubmitRatingUseCase implements UseCase<String, SubmitRatingParams> {
  final RatingRepository repository;

  SubmitRatingUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(SubmitRatingParams params) {
    return repository.submitRating(
      reservationId: params.reservationId,
      evaluations: params.evaluations,
      message: params.message,
    );
  }
}

class SubmitRatingParams extends Equatable {
  final int reservationId;
  final Map<String, int> evaluations;
  final String message;

  const SubmitRatingParams({
    required this.reservationId,
    required this.evaluations,
    required this.message,
  });

  @override
  List<Object?> get props => [reservationId, evaluations, message];
}
