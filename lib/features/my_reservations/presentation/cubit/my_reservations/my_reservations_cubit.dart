import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/features/my_reservations/data/models/order_model.dart';
import 'package:workspace/features/my_reservations/domain/usecases/get_reservations_usecase.dart';
import 'package:workspace/features/my_reservations/domain/usecases/reservation_actions_usecase.dart';

part 'my_reservations_state.dart';

class MyReservationsCubit extends Cubit<MyReservationsState> {
  final GetReservationsUseCase getReservationsUseCase;
  final CancelReservationUseCase cancelReservationUseCase;
  final ReReserveUseCase reReserveUseCase;

  MyReservationsCubit({
    required this.getReservationsUseCase,
    required this.cancelReservationUseCase,
    required this.reReserveUseCase,
  }) : super(const MyReservationsState());

  Future<void> loadFirstPage() async {
    emit(state.copyWith(status: ReservationsStatus.loading, items: [], page: 1));
    final result = await getReservationsUseCase(
      ReservationsParams(page: 1, statusTypeId: state.statusFilter),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: ReservationsStatus.error,
        errorMessage: failure.message,
      )),
      (data) => emit(state.copyWith(
        status: ReservationsStatus.loaded,
        items: data.items,
        page: 1,
        hasMore: !data.isLastPage,
      )),
    );
  }

  Future<void> loadMore() async {
    if (state.loadingMore || !state.hasMore || state.status != ReservationsStatus.loaded) return;
    emit(state.copyWith(loadingMore: true));
    final next = state.page + 1;
    final result = await getReservationsUseCase(
      ReservationsParams(page: next, statusTypeId: state.statusFilter),
    );
    result.fold(
      (_) => emit(state.copyWith(loadingMore: false)),
      (data) => emit(state.copyWith(
        items: [...state.items, ...data.items],
        page: next,
        hasMore: !data.isLastPage,
        loadingMore: false,
      )),
    );
  }

  void changeStatus(int index) {
    if (state.statusFilter == index) return;
    emit(state.copyWith(statusFilter: index));
    loadFirstPage();
  }

  Future<void> cancel(int reservationId) async {
    final result = await cancelReservationUseCase(reservationId);
    result.fold(
      (failure) => emit(state.copyWith(action: ReservationAction.failure(failure.message))),
      (_) {
        _updateStatus(reservationId, 3);
        emit(state.copyWith(action: const ReservationAction.success('تم الإلغاء بنجاح')));
      },
    );
  }

  Future<void> reReserve(int reservationId) async {
    final result = await reReserveUseCase(reservationId);
    result.fold(
      (failure) => emit(state.copyWith(action: ReservationAction.failure(failure.message))),
      (_) {
        _updateStatus(reservationId, 1);
        emit(state.copyWith(action: const ReservationAction.success('تم اعادة ارسال الحجز')));
      },
    );
  }

  void _updateStatus(int reservationId, int statusId) {
    final updated = state.items.map((r) {
      if (r.id == reservationId) r.status?.id = statusId;
      return r;
    }).toList();
    emit(state.copyWith(items: updated));
  }

  void clearAction() => emit(state.copyWith(action: const ReservationAction.none()));
}
