part of 'rating_cubit.dart';

enum RatingStatus { idle, loading, success, failure }

class RatingState extends Equatable {
  final RatingStatus status;
  final Map<String, int> evaluations;
  final String message;

  const RatingState({
    this.status = RatingStatus.idle,
    this.evaluations = const {},
    this.message = '',
  });

  RatingState copyWith({
    RatingStatus? status,
    Map<String, int>? evaluations,
    String? message,
  }) {
    return RatingState(
      status: status ?? this.status,
      evaluations: evaluations ?? this.evaluations,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, evaluations, message];
}
