import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/features/search/domain/entities/search_result.dart';
import 'package:workspace/features/search/domain/usecases/search_spaces_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchSpacesUseCase searchSpacesUseCase;
  final LocalStorage localStorage;

  static const _historyKey = 'searchHistory';

  SearchCubit({required this.searchSpacesUseCase, required this.localStorage})
      : super(const SearchState());

  Future<void> loadHistory() async {
    final list = await localStorage.readList(_historyKey);
    emit(state.copyWith(history: list));
  }

  void setQuery(String value) => emit(state.copyWith(query: value));

  Future<void> search(String text) async {
    if (text.trim().isEmpty) return;
    emit(state.copyWith(status: SearchStatus.loading, query: text));
    final result = await searchSpacesUseCase(text.trim());
    await result.fold(
      (failure) async => emit(state.copyWith(
        status: SearchStatus.error,
        errorMessage: failure.message,
      )),
      (items) async {
        await _addToHistory(text.trim());
        emit(state.copyWith(status: SearchStatus.loaded, results: items));
      },
    );
  }

  void clearResults() {
    emit(state.copyWith(status: SearchStatus.initial, results: [], query: ''));
  }

  Future<void> _addToHistory(String value) async {
    final list = await localStorage.readList(_historyKey);
    list.removeWhere((e) => e == value);
    list.insert(0, value);
    if (list.length > 10) list.removeRange(10, list.length);
    await localStorage.writeList(_historyKey, list);
    emit(state.copyWith(history: list));
  }

  Future<void> removeHistory(int index) async {
    final list = List<String>.from(state.history)..removeAt(index);
    await localStorage.writeList(_historyKey, list);
    emit(state.copyWith(history: list));
  }
}
