part of 'search_cubit.dart';

enum SearchStatus { initial, loading, loaded, error }

class SearchState extends Equatable {
  final SearchStatus status;
  final List<SearchResultItem> results;
  final List<String> history;
  final String query;
  final String errorMessage;

  const SearchState({
    this.status = SearchStatus.initial,
    this.results = const [],
    this.history = const [],
    this.query = '',
    this.errorMessage = '',
  });

  bool get showHistory =>
      history.isNotEmpty && results.isEmpty && status != SearchStatus.loading;

  SearchState copyWith({
    SearchStatus? status,
    List<SearchResultItem>? results,
    List<String>? history,
    String? query,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      results: results ?? this.results,
      history: history ?? this.history,
      query: query ?? this.query,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, results, history, query, errorMessage];
}
