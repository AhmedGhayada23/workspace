part of 'details_cubit.dart';

enum DetailsStatus { initial, loading, loaded, error }

enum BookingStatus { idle, loading, success, failure }

class DetailsState extends Equatable {
  final DetailsStatus status;
  final DetailsSpaceModel? model;
  final BookingStatus bookingStatus;
  final int bookingTypeIndex;
  final String errorMessage;

  const DetailsState({
    this.status = DetailsStatus.initial,
    this.model,
    this.bookingStatus = BookingStatus.idle,
    this.bookingTypeIndex = 1,
    this.errorMessage = '',
  });

  DetailsState copyWith({
    DetailsStatus? status,
    DetailsSpaceModel? model,
    BookingStatus? bookingStatus,
    int? bookingTypeIndex,
    String? errorMessage,
  }) {
    return DetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      bookingTypeIndex: bookingTypeIndex ?? this.bookingTypeIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, model, bookingStatus, bookingTypeIndex, errorMessage];
}
