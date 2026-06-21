import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/notification/data/model/notification_model.dart';
import 'package:workspace/features/notification/domain/usecases/notifications_usecases.dart';
import 'package:workspace/features/notification/presentation/cubit/notification_badge_cubit.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkNotificationsReadUseCase markReadUseCase;
  final LocalStorage localStorage;

  NotificationsCubit({
    required this.getNotificationsUseCase,
    required this.markReadUseCase,
    required this.localStorage,
  }) : super(const NotificationsState());

  Future<void> loadFirstPage() async {
    emit(state.copyWith(status: NotificationsStatus.loading, items: [], page: 1));
    final result = await getNotificationsUseCase(1);
    result.fold(
      (failure) => emit(state.copyWith(
        status: NotificationsStatus.error,
        errorMessage: failure.message,
      )),
      (data) => emit(state.copyWith(
        status: NotificationsStatus.loaded,
        items: data.items,
        page: 1,
        hasMore: !data.isLastPage,
        hasUnread: _computeUnread(data.items),
      )),
    );
  }

  Future<void> loadMore() async {
    if (state.loadingMore || !state.hasMore || state.status != NotificationsStatus.loaded) return;
    emit(state.copyWith(loadingMore: true));
    final next = state.page + 1;
    final result = await getNotificationsUseCase(next);
    result.fold(
      (_) => emit(state.copyWith(loadingMore: false)),
      (data) {
        final merged = [...state.items, ...data.items];
        emit(state.copyWith(
          items: merged,
          page: next,
          hasMore: !data.isLastPage,
          loadingMore: false,
          hasUnread: _computeUnread(merged),
        ));
      },
    );
  }

  Future<void> markAllAsRead() async {
    if (!state.hasUnread) return;
    final result = await markReadUseCase(const NoParams());
    result.fold(
      (_) {},
      (_) {
        final now = DateFormat('yyyy-MM-dd hh:mm:ss a').format(DateTime.now());
        for (final n in state.items) {
          n.readAt ??= now;
        }
        localStorage.writeValue(Constants.unreadNotification, false);
        sl<NotificationBadgeCubit>().clear(); // تصفير العدّاد المشترك
        emit(state.copyWith(items: List.of(state.items), hasUnread: false));
      },
    );
  }

  bool _computeUnread(List<Notifications> items) => items.any((n) => n.readAt == null);

  /// نص "منذ ..." من تاريخ الإشعار.
  String timeAgo(String dateTimeString) {
    try {
      var normalized = dateTimeString
          .replaceAll(RegExp(r' am$', caseSensitive: false), ' AM')
          .replaceAll(RegExp(r' pm$', caseSensitive: false), ' PM');
      final dateTime = DateFormat('yyyy-MM-dd hh:mm:ss a').parse(normalized).toLocal();
      final diff = DateTime.now().difference(dateTime);

      if (diff.inSeconds < 0) return 'الآن';
      if (diff.inSeconds < 60) return 'قبل ${diff.inSeconds} ثانية';
      if (diff.inMinutes < 60) return 'قبل ${diff.inMinutes} دقيقة';
      if (diff.inHours < 24) return 'قبل ${diff.inHours} ساعة';
      if (diff.inDays < 7) return 'قبل ${diff.inDays} يوم';
      if (diff.inDays < 30) return 'قبل ${(diff.inDays / 7).floor()} أسبوع';
      if (diff.inDays < 365) return 'قبل ${(diff.inDays / 30).floor()} شهر';
      return 'قبل ${(diff.inDays / 365).floor()} سنة';
    } catch (_) {
      return 'تاريخ غير صالح';
    }
  }
}
