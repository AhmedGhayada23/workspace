import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/features/rating/domain/usecases/submit_rating_usecase.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  final SubmitRatingUseCase submitRatingUseCase;

  RatingCubit(this.submitRatingUseCase) : super(const RatingState());

  /// يضبط قيمة معيار (يستبدل القيمة السابقة لنفس النوع — لا يكرّرها).
  void setRating(String type, int value) {
    final updated = Map<String, int>.from(state.evaluations)..[type] = value;
    emit(state.copyWith(evaluations: updated));
  }

  Future<void> submit({required int reservationId, required String message}) async {
    emit(state.copyWith(status: RatingStatus.loading));
    final result = await submitRatingUseCase(SubmitRatingParams(
      reservationId: reservationId,
      evaluations: state.evaluations,
      message: message,
    ));
    result.fold(
      (failure) => emit(state.copyWith(status: RatingStatus.failure, message: failure.message)),
      (msg) => emit(state.copyWith(status: RatingStatus.success, message: msg)),
    );
  }
}
