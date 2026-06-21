import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/features/booking/domain/usecases/confirm_booking_usecase.dart';

part 'confirm_booking_state.dart';

class ConfirmBookingCubit extends Cubit<ConfirmBookingState> {
  final ConfirmBookingUseCase confirmBookingUseCase;

  ConfirmBookingCubit(this.confirmBookingUseCase) : super(const ConfirmBookingState());

  Future<void> confirm(ConfirmBookingParams params) async {
    emit(state.copyWith(status: ConfirmBookingStatus.loading));
    final result = await confirmBookingUseCase(params);
    result.fold(
      (failure) => emit(state.copyWith(
        status: ConfirmBookingStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: ConfirmBookingStatus.success)),
    );
  }

  void reset() => emit(state.copyWith(status: ConfirmBookingStatus.idle));
}
