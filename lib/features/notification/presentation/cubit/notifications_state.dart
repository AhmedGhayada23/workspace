part of 'notifications_cubit.dart';

enum NotificationsStatus { initial, loading, loaded, error }

class NotificationsState extends Equatable {
  final NotificationsStatus status;
  final List<Notifications> items;
  final int page;
  final bool hasMore;
  final bool loadingMore;
  final bool hasUnread;
  final String errorMessage;

  const NotificationsState({
    this.status = NotificationsStatus.initial,
    this.items = const [],
    this.page = 1,
    this.hasMore = false,
    this.loadingMore = false,
    this.hasUnread = false,
    this.errorMessage = '',
  });

  NotificationsState copyWith({
    NotificationsStatus? status,
    List<Notifications>? items,
    int? page,
    bool? hasMore,
    bool? loadingMore,
    bool? hasUnread,
    String? errorMessage,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      items: items ?? this.items,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
      hasUnread: hasUnread ?? this.hasUnread,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, items, page, hasMore, loadingMore, hasUnread, errorMessage];
}
