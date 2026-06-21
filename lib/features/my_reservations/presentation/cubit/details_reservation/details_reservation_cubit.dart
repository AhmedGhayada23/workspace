import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/features/my_reservations/data/models/details_resevation_model.dart';
import 'package:workspace/features/my_reservations/data/models/order_model.dart';
import 'package:workspace/features/my_reservations/domain/usecases/reservation_actions_usecase.dart';

part 'details_reservation_state.dart';

class DetailsReservationCubit extends Cubit<DetailsReservationState> {
  final GetReservationDetailsUseCase getDetailsUseCase;

  DetailsReservationCubit(this.getDetailsUseCase) : super(const DetailsReservationState());

  Future<void> load(Reservations reservation) async {
    emit(state.copyWith(status: DetailsReservationStatus.loading, reservation: reservation));
    final result = await getDetailsUseCase(reservation.id!);
    result.fold(
      (failure) => emit(state.copyWith(
        status: DetailsReservationStatus.error,
        errorMessage: failure.message,
      )),
      (details) => emit(state.copyWith(
        status: DetailsReservationStatus.loaded,
        details: details,
      )),
    );
  }
}
