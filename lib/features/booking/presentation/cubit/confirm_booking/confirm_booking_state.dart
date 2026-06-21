part of 'confirm_booking_cubit.dart';

enum ConfirmBookingStatus { idle, loading, success, failure }

class ConfirmBookingState extends Equatable {
  final ConfirmBookingStatus status;
  final String errorMessage;

  const ConfirmBookingState({
    this.status = ConfirmBookingStatus.idle,
    this.errorMessage = '',
  });

  ConfirmBookingState copyWith({
    ConfirmBookingStatus? status,
    String? errorMessage,
  }) {
    return ConfirmBookingState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
