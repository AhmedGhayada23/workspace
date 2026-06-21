part of 'my_reservations_cubit.dart';

enum ReservationsStatus { initial, loading, loaded, error }

/// نتيجة إجراء (إلغاء/إعادة) لعرض snackbar ثم تُمسح.
class ReservationAction extends Equatable {
  final String message;
  final bool isError;
  final bool hasValue;

  const ReservationAction.none()
      : message = '',
        isError = false,
        hasValue = false;
  const ReservationAction.success(this.message)
      : isError = false,
        hasValue = true;
  const ReservationAction.failure(this.message)
      : isError = true,
        hasValue = true;

  @override
  List<Object?> get props => [message, isError, hasValue];
}

class MyReservationsState extends Equatable {
  final int statusFilter;
  final ReservationsStatus status;
  final List<Reservations> items;
  final int page;
  final bool hasMore;
  final bool loadingMore;
  final String errorMessage;
  final ReservationAction action;

  const MyReservationsState({
    this.statusFilter = 0,
    this.status = ReservationsStatus.initial,
    this.items = const [],
    this.page = 1,
    this.hasMore = false,
    this.loadingMore = false,
    this.errorMessage = '',
    this.action = const ReservationAction.none(),
  });

  MyReservationsState copyWith({
    int? statusFilter,
    ReservationsStatus? status,
    List<Reservations>? items,
    int? page,
    bool? hasMore,
    bool? loadingMore,
    String? errorMessage,
    ReservationAction? action,
  }) {
    return MyReservationsState(
      statusFilter: statusFilter ?? this.statusFilter,
      status: status ?? this.status,
      items: items ?? this.items,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
      errorMessage: errorMessage ?? this.errorMessage,
      action: action ?? this.action,
    );
  }

  @override
  List<Object?> get props =>
      [statusFilter, status, items, page, hasMore, loadingMore, errorMessage, action];
}
