part of 'details_reservation_cubit.dart';

enum DetailsReservationStatus { initial, loading, loaded, error }

class DetailsReservationState extends Equatable {
  final DetailsReservationStatus status;
  final Reservations? reservation;
  final DetailsResevationModel? details;
  final String errorMessage;

  const DetailsReservationState({
    this.status = DetailsReservationStatus.initial,
    this.reservation,
    this.details,
    this.errorMessage = '',
  });

  DetailsReservationState copyWith({
    DetailsReservationStatus? status,
    Reservations? reservation,
    DetailsResevationModel? details,
    String? errorMessage,
  }) {
    return DetailsReservationState(
      status: status ?? this.status,
      reservation: reservation ?? this.reservation,
      details: details ?? this.details,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, reservation, details, errorMessage];
}
