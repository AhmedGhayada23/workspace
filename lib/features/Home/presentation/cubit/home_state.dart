part of 'home_cubit.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus spacesStatus;
  final List<SpaceItem> newSpaces;
  final List<SpaceItem> suggestSpaces;
  final int filterIndex;
  final bool hasUnread;
  final int unreadCount;
  final String errorMessage;

  const HomeState({
    this.spacesStatus = HomeStatus.initial,
    this.newSpaces = const [],
    this.suggestSpaces = const [],
    this.filterIndex = 0,
    this.hasUnread = false,
    this.unreadCount = 0,
    this.errorMessage = '',
  });

  HomeState copyWith({
    HomeStatus? spacesStatus,
    List<SpaceItem>? newSpaces,
    List<SpaceItem>? suggestSpaces,
    int? filterIndex,
    bool? hasUnread,
    int? unreadCount,
    String? errorMessage,
  }) {
    return HomeState(
      spacesStatus: spacesStatus ?? this.spacesStatus,
      newSpaces: newSpaces ?? this.newSpaces,
      suggestSpaces: suggestSpaces ?? this.suggestSpaces,
      filterIndex: filterIndex ?? this.filterIndex,
      hasUnread: hasUnread ?? this.hasUnread,
      unreadCount: unreadCount ?? this.unreadCount,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        spacesStatus,
        newSpaces,
        suggestSpaces,
        filterIndex,
        hasUnread,
        unreadCount,
        errorMessage,
      ];
}
