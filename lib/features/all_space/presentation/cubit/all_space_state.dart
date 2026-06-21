part of 'all_space_cubit.dart';

enum AllSpaceStatus { initial, loading, loaded, error }

class AllSpaceState extends Equatable {
  final int profitIndex;
  final int provinceId;
  final bool hasUnread;
  final int unreadCount;

  // قائمة المساحات + الترقيم
  final AllSpaceStatus spacesStatus;
  final List<SpaceItem> spaces;
  final int page;
  final bool hasMore;
  final bool loadingMore;
  final String errorMessage;

  const AllSpaceState({
    this.profitIndex = 0,
    this.provinceId = 0,
    this.hasUnread = false,
    this.unreadCount = 0,
    this.spacesStatus = AllSpaceStatus.initial,
    this.spaces = const [],
    this.page = 1,
    this.hasMore = false,
    this.loadingMore = false,
    this.errorMessage = '',
  });

  AllSpaceState copyWith({
    int? profitIndex,
    int? provinceId,
    bool? hasUnread,
    int? unreadCount,
    AllSpaceStatus? spacesStatus,
    List<SpaceItem>? spaces,
    int? page,
    bool? hasMore,
    bool? loadingMore,
    String? errorMessage,
  }) {
    return AllSpaceState(
      profitIndex: profitIndex ?? this.profitIndex,
      provinceId: provinceId ?? this.provinceId,
      hasUnread: hasUnread ?? this.hasUnread,
      unreadCount: unreadCount ?? this.unreadCount,
      spacesStatus: spacesStatus ?? this.spacesStatus,
      spaces: spaces ?? this.spaces,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        profitIndex,
        provinceId,
        hasUnread,
        unreadCount,
        spacesStatus,
        spaces,
        page,
        hasMore,
        loadingMore,
        errorMessage,
      ];
}
