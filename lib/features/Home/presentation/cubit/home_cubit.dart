import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/features/Home/domain/entities/space_item.dart';
import 'package:workspace/features/Home/domain/usecases/get_main_page_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetMainPageUseCase getMainPageUseCase;
  final LocalStorage localStorage;

  HomeCubit({required this.getMainPageUseCase, required this.localStorage})
      : super(const HomeState());

  Future<void> load() async {
    await getSpaces(null);
  }

  /// إعادة تحميل (سحب للتحديث) مع الحفاظ على الفلتر المختار.
  Future<void> refresh() async {
    await getSpaces(
      state.filterIndex == 0 ? null : (state.filterIndex == 1 ? 'non-profit' : 'profit'),
    );
  }

  Future<void> changeFilter(int index) async {
    if (state.filterIndex == index) return;
    emit(state.copyWith(filterIndex: index));
    await getSpaces(
      index == 0 ? null : (index == 1 ? 'non-profit' : 'profit'),
    );
  }

  Future<void> getSpaces(String? filterProfit) async {
    emit(state.copyWith(spacesStatus: HomeStatus.loading));
    final result = await getMainPageUseCase(filterProfit);
    result.fold(
      (failure) => emit(state.copyWith(
        spacesStatus: HomeStatus.error,
        errorMessage: failure.message,
      )),
      (page) => emit(state.copyWith(
        spacesStatus: HomeStatus.loaded,
        newSpaces: page.newSpaces,
        suggestSpaces: page.suggestSpaces,
      )),
    );
  }

  /// تنسيق وقت التوفّر "من - إلى" بالعربية.
  String availableText(SpaceItem item) {
    return '${_formatTime(item.availableFrom)} - ${_formatTime(item.availableTo)}';
  }

  String _formatTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return '---';
    try {
      final formatted = DateFormat('hh:mm a').format(
        DateFormat('hh:mm a').parse(timeStr.toUpperCase()),
      );
      return formatted.contains('AM')
          ? formatted.replaceAll('AM', 'صباحًا')
          : formatted.replaceAll('PM', 'مساءً');
    } catch (_) {
      return '---';
    }
  }
}
